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
    final result = await provider.processPickedImage(image.path);

    if (!mounted) return;

    if (result['success'] == true) {
      final imagePath = result['imagePath'] as String;
      final predictionResult = result['predictionResult'] as PredictionResult;
      final herbName = predictionResult.primaryPrediction;
      final confidence = predictionResult.primaryConfidence;
      context.read<HistoryProvider>().addScan(herbName, confidence, ScanSource.camera);
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
      final message = result['message'] as String? ?? 'Failed to identify plant.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  int _screenIndex(int navIndex) {
    if (navIndex < 2) return navIndex;
    return navIndex - 1;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: BottomNavScreen.barBodyHeight + bottomInset,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: navBg,
                  border: Border(
                    top: BorderSide(color: Colors.blueGrey, width: 2),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < _navItems.length; i++)
                        Expanded(
                          child: _navEntry(context, item: _navItems[i], navIndex: i),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navEntry(
    BuildContext context, {
    required NavItem item,
    required int navIndex,
  }) {
    if (item.style == MainNavTabStyle.centerFab) {
      return _ScanNavTile(
        label: item.title,
        icon: item.icon,
        onTap: _onScanTap,
      );
    }
    final selected = _currentIndex == _screenIndex(navIndex);
    return _SideNavTile(
      label: item.title,
      icon: item.icon,
      selected: selected,
      onTap: () => setState(() => _currentIndex = _screenIndex(navIndex)),
    );
  }
}

class _SideNavTile extends StatelessWidget {
  const _SideNavTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  static const Color _active = Color(0xFF27AE60);

  @override
  Widget build(BuildContext context) {
    final inactive = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);
    final color = selected ? _active : inactive;

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: _active.withValues(alpha: 0.1),
      child: Container(
        height: BottomNavScreen.barBodyHeight,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanNavTile extends StatelessWidget {
  const _ScanNavTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  static const Color _scanGreen = Color(0xFF27AE60);
  static const double _fabSize = 52;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: BottomNavScreen.barBodyHeight,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 24,
              width: _fabSize,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: _fabSize,
                      height: _fabSize,
                      decoration: BoxDecoration(
                        color: _scanGreen,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _scanGreen.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: iconColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _scanGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
