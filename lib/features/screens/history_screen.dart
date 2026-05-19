import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/features/screens/widgets/history_widget.dart';
import 'herb_full_details_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();

    final todayItems = historyProvider.getItemsByCategory('TODAY');
    final yesterdayItems = historyProvider.getItemsByCategory('YESTERDAY');
    final thisWeekItems = historyProvider.getItemsByCategory('THIS WEEK');

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            historyProvider.resetItems();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todayItems.isNotEmpty) ...[
                  Text('TODAY', style: AppTextStyles.heading4),
                  ...todayItems.map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HerbFullDetailsScreen(),
                          ),
                        );
                      },
                      child: HistoryWidget(
                        id: item.id,
                        herbName: item.herbName,
                        imagePath: item.dotImage,
                        imagePath2: item.herbImage,
                        imagePath3: item.iconImage,
                        time: item.time,
                        confidence: item.confidence,
                        onDelete: () => historyProvider.removeItem(item.id),
                      ),
                    ),
                  ),
                ],
                if (yesterdayItems.isNotEmpty) ...[
                  Text('YESTERDAY', style: AppTextStyles.heading4),
                  ...yesterdayItems.map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HerbFullDetailsScreen(),
                          ),
                        );
                      },
                      child: HistoryWidget(
                        id: item.id,
                        herbName: item.herbName,
                        imagePath: item.dotImage,
                        imagePath2: item.herbImage,
                        imagePath3: item.iconImage,
                        time: item.time,
                        confidence: item.confidence,
                        onDelete: () => historyProvider.removeItem(item.id),
                      ),
                    ),
                  ),
                ],
                if (thisWeekItems.isNotEmpty) ...[
                  Text('THIS WEEK', style: AppTextStyles.heading4),
                  ...thisWeekItems.map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HerbFullDetailsScreen(),
                          ),
                        );
                      },
                      child: HistoryWidget(
                        id: item.id,
                        herbName: item.herbName,
                        imagePath: item.dotImage,
                        imagePath2: item.herbImage,
                        imagePath3: item.iconImage,
                        time: item.time,
                        confidence: item.confidence,
                        onDelete: () => historyProvider.removeItem(item.id),
                      ),
                    ),
                  ),
                ],
                if (todayItems.isEmpty &&
                    yesterdayItems.isEmpty &&
                    thisWeekItems.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Text('No history items'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
