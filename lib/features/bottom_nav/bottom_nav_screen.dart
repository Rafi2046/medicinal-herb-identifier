import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/main/presentation/models/nav_item.dart';
import 'package:medical_herb/features/screens/explore_screen.dart';
import 'package:medical_herb/features/screens/history_screen.dart';
import 'package:medical_herb/features/screens/home_screen.dart';
import 'package:medical_herb/features/screens/saved_screen.dart';
import 'package:medical_herb/features/screens/upload_screen.dart';
import 'package:medical_herb/features/common_widgets/scan_error_dialog.dart';
import 'package:medical_herb/features/bottom_nav/widgets/nav_tiles.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  static const double barBodyHeight = 64;
  static const double fabOverhang = 28;

  static double tabContentBottomInset(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom + barBodyHeight + fabOverhang;
  }

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    SavedScreen(),
    HistoryScreen(),
  ];

  static const List<NavItem> _navItems = [
    NavItem(title: 'Home', icon: Icons.home_outlined),
    NavItem(title: 'Explore', icon: Icons.menu_book_outlined),
    NavItem(
      title: 'Scan',
      icon: Icons.camera_alt_outlined,
      style: MainNavTabStyle.centerFab,
    ),
    NavItem(title: 'Saved', icon: Icons.favorite_border),
    NavItem(title: 'History', icon: Icons.schedule_outlined),
  ];

  Future<void> _onScanTap() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null || !mounted) return;

    final provider = context.read<ScanProvider>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await provider.processPickedImage(image.path);

    if (!mounted) return;
    Navigator.pop(context);

    if (result['success'] == true) {
      final imagePath = result['imagePath'] as String;
      final predictionResult = result['predictionResult'] as PredictionResult;

      context.read<HistoryProvider>().addScan(
        predictionResult.primaryPrediction,
        predictionResult.primaryConfidence,
        ScanSource.camera,
      );

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UploadScreen(
            imagePath: imagePath,
            predictionResult: predictionResult,
          ),
        ),
      );
    } else {
      final message =
          result['message'] as String? ?? 'Failed to identify plant.';
      ScanErrorDialog.show(context, message);
    }
  }

  int _screenIndex(int navIndex) => navIndex < 2 ? navIndex : navIndex - 1;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      // THIS IS CRUCIAL: It lets the background flow under the nav bar seamlessly
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildNavBar(bottomInset),
    );
  }

  Widget _buildNavBar(double bottomInset) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.03);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: BottomNavScreen.barBodyHeight + bottomInset + BottomNavScreen.fabOverhang,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // --- 1. The Bottom Navigation Bar Background & Border ---
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: BottomNavScreen.barBodyHeight + bottomInset,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: navBg,
                  border: const Border(
                    top: BorderSide(color: Colors.blueGrey, width: 1.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _navEntry(context, item: _navItems[0], navIndex: 0)),
                      Expanded(child: _navEntry(context, item: _navItems[1], navIndex: 1)),

                      // EMPTY SPACE FOR THE FLOATING BUTTON
                      const Expanded(child: SizedBox.shrink()),

                      Expanded(child: _navEntry(context, item: _navItems[3], navIndex: 3)),
                      Expanded(child: _navEntry(context, item: _navItems[4], navIndex: 4)),
                    ],
                  ),
                ),
              ),
            ),

            // --- 2. The Floating Scan Button ---
            Positioned(
              bottom: bottomInset, // Sits exactly on the bottom edge
              child: SizedBox(
                height: BottomNavScreen.barBodyHeight + BottomNavScreen.fabOverhang,
                child: ScanNavTile(
                  label: _navItems[2].title,
                  icon: _navItems[2].icon,
                  onTap: _onScanTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ONLY ONE _navEntry METHOD (Fixed the duplicate error)
  Widget _navEntry(
      BuildContext context, {
        required NavItem item,
        required int navIndex,
      }) {
    return SideNavTile(
      label: item.title,
      icon: item.icon,
      selected: _currentIndex == _screenIndex(navIndex),
      onTap: () => setState(() => _currentIndex = _screenIndex(navIndex)),
    );
  }
}