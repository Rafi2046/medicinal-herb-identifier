import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';
import 'package:medical_herb/features/screens/widgets/history_widget.dart';
import 'package:medical_herb/features/screens/widgets/tab_screen_header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _showBackButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _showBackButton = Navigator.canPop(context);
        });
      }
    });
  }

  Widget _buildSection(String title, List<HistoryItem> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading4),
        ...items.map((item) => HistoryWidget(
          id: item.id,
          herbName: item.herbName,
          confidence: '${item.confidence.toStringAsFixed(1)}%',
          time: item.time,
          source: item.source,
          onDelete: () => context.read<HistoryProvider>().removeItem(item.id),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HerbFullDetailsScreen(herbName: item.herbName),
            ),
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);

    final todayItems = historyProvider.getItemsByCategory('TODAY');
    final yesterdayItems = historyProvider.getItemsByCategory('YESTERDAY');
    final thisWeekItems = historyProvider.getItemsByCategory('THIS WEEK');
    final olderItems = historyProvider.getItemsByCategory('OLDER');

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabScreenHeader(
              showBackButton: _showBackButton,
              title: 'History',
              subtitle: '${historyProvider.items.length} scans',
            ),
            Expanded(
              child: historyProvider.items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.history, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No scan history yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your scanned herbs will appear here',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {},
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSection('TODAY', todayItems),
                            _buildSection('YESTERDAY', yesterdayItems),
                            _buildSection('THIS WEEK', thisWeekItems),
                            _buildSection('OLDER', olderItems),
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
}
