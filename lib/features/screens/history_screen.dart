import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/features/screens/widgets/history_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TODAY', style: AppTextStyles.heading4),
              ...historyProvider
                  .getItemsByCategory('TODAY')
                  .map(
                    (item) => HistoryWidget(
                      herbName: item.herbName,
                      imagePath: item.dotImage,
                      imagePath2: item.herbImage,
                      imagePath3: item.iconImage,
                      time: item.time,
                      confidence: item.confidence,
                      onDelete: () => historyProvider.removeItem(item.id),
                    ),
                  ),
              Text('YESTERDAY', style: AppTextStyles.heading4),
              ...historyProvider
                  .getItemsByCategory('YESTERDAY')
                  .map(
                    (item) => HistoryWidget(
                      herbName: item.herbName,
                      imagePath: item.dotImage,
                      imagePath2: item.herbImage,
                      imagePath3: item.iconImage,
                      time: item.time,
                      confidence: item.confidence,
                      onDelete: () => historyProvider.removeItem(item.id),
                    ),
                  ),
              Text('THIS WEEK', style: AppTextStyles.heading4),
              ...historyProvider
                  .getItemsByCategory('THIS WEEK')
                  .map(
                    (item) => HistoryWidget(
                      herbName: item.herbName,
                      imagePath: item.dotImage,
                      imagePath2: item.herbImage,
                      imagePath3: item.iconImage,
                      time: item.time,
                      confidence: item.confidence,
                      onDelete: () => historyProvider.removeItem(item.id),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
