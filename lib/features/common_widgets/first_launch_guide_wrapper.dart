import 'package:flutter/material.dart';
import 'package:medical_herb/features/screens/widgets/screen_guide_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchGuideWrapper extends StatefulWidget {
  final Widget child;

  const FirstLaunchGuideWrapper({super.key, required this.child});

  @override
  State<FirstLaunchGuideWrapper> createState() => _FirstLaunchGuideWrapperState();
}

class _FirstLaunchGuideWrapperState extends State<FirstLaunchGuideWrapper> {

  @override
  void initState() {
    super.initState();
    _checkAndShowGuide();
  }

  Future<void> _checkAndShowGuide() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenGuide = prefs.getBool('has_seen_guide') ?? false;

    if (!hasSeenGuide) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 💡 ম্যাজিক! এখানে এখন বটম শিটের বদলে সেন্ট্রাল ডায়লগ কল হবে
        ScanGuideDialog.show(context);
      });
      await prefs.setBool('has_seen_guide', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}