import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const CustomTabBarWidget({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const green = Color(0xFF13C366);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: ListenableBuilder(
        listenable: tabController,
        builder: (_, _) {
          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: List.generate(tabs.length, (i) {
                final selected = tabController.index == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => tabController.animateTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? green : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: green.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        tabs[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : (isDark
                                    ? Colors.white54
                                    : const Color(0xFF94A3B8)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
