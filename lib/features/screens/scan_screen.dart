import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _hasOpenedCamera = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasOpenedCamera) {
        _hasOpenedCamera = true;
        _openCamera();
      }
    });
  }

  Future<void> _openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image captured: ${image.path}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    return ColoredBox(
      color: const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt_outlined, size: 64, color: Color(0xFF2D9E61)),
              const SizedBox(height: 16),
              Text('Opening Camera...', style: AppTextStyles.heading2),
              const SizedBox(height: 8),
              Text('Point the camera at a herb to identify it.', style: AppTextStyles.body3),
            ],
          ),
        ),
      ),
    );
  }
}