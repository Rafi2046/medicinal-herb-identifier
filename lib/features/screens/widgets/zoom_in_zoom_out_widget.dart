import 'dart:io';
import 'package:flutter/material.dart';

class ZoomInZoomOutWidget extends StatelessWidget {
  final String imagePath;
  final GlobalKey cropKey;
  final VoidCallback onScan;

  const ZoomInZoomOutWidget({
    super.key,
    required this.imagePath,
    required this.cropKey,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF27AE60);

    return RepaintBoundary(
      key: cropKey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 6.0,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onScan,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black45, blurRadius: 6),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.center_focus_strong,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Scan Focus',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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
