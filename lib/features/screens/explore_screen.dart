import 'package:flutter/material.dart';
import 'package:medical_herb/features/screens/widgets/explore_screen_widget.dart';
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          ExploreScreenWidget()
        ],
      ),
    );
  }
}
