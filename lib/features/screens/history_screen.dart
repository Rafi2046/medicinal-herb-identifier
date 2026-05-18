import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/features/screens/widgets/history_widget.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('TODAY',style: AppTextStyles.heading4,),
          HistoryWidget()
        ],
      ),
    );
  }
}
