import 'package:flutter/material.dart';

class MedicalDisclaimerWidget extends StatelessWidget {
  const MedicalDisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        // Soft elegant background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white10
              : Colors.blueGrey.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.health_and_safety_outlined,
                color: isDark ? Colors.blueAccent : const Color(0xFF3B82F6),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Medical Disclaimer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The information provided here is for educational purposes only. Always consult with a qualified healthcare professional before using herbal remedies, especially if you are pregnant, nursing, have existing medical conditions, or are currently taking prescription medications.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white70 : const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
