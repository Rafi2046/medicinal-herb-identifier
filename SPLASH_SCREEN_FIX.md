# Splash Screen Image Fix

## Issues Identified

### 1. **Wrong Asset Paths** ❌
The splash screen was using incorrect asset paths with an extra `/images/` folder that doesn't exist:
- Wrong: `'assets/images/background_image/shape.webp'`
- Wrong: `'assets/images/app_logo/logo.png'`

### 2. **Missing Error Handlers** ❌
The Image.asset widgets had no error handling, causing the app to show blank screens if assets failed to load.

### 3. **Timer Initialization Issues** ❌
- Timer was created before calling `super.initState()`
- No mounted check before navigation
- Not using const for Duration

## Fixes Applied ✅

### 1. Corrected Asset Paths
Updated to the actual folder structure:
```dart
// Background image
'assets/background_image/shape.webp'

// App logo
'assets/app_logo/logo.png'
```

### 2. Added Error Handlers
Both images now have errorBuilder callbacks:
```dart
Image.asset(
  'assets/background_image/shape.webp',
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return const SizedBox(); // Gracefully hide if fails
  },
)

Image.asset(
  'assets/app_logo/logo.png',
  height: AppSpacing.h100,
  fit: BoxFit.contain,
  errorBuilder: (context, error, stackTrace) {
    // Show fallback icon and text
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_hospital, size: 100, color: Colors.green[700]),
        const SizedBox(height: 16),
        const Text('Medical Herb', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  },
)
```

### 3. Fixed Timer Initialization
```dart
@override
void initState() {
  super.initState(); // Called first
  _navigateToHome();
}

void _navigateToHome() {
  Timer(
    const Duration(seconds: 3), // const
    () {
      if (mounted) { // Check mounted state
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    },
  );
}
```

### 4. Added Background Color
Set explicit background color to white for consistency:
```dart
Scaffold(
  backgroundColor: Colors.white,
  body: Stack(...)
)
```

## Verified Asset Structure
```
assets/
  ├── app_logo/
  │   └── logo.png ✓
  ├── background_image/
  │   └── shape.webp ✓
  └── icons/
```

## pubspec.yaml Assets Configuration ✓
```yaml
flutter:
  assets:
    - assets/app_logo/
    - assets/background_image/
    - assets/icons/
```

## Additional Issue: Storage Error

The ADB installation error you encountered:
```
INSTALL_FAILED_INSUFFICIENT_STORAGE
```

### Solutions:

1. **Clean the emulator** (if using emulator):
   - Wipe data from AVD Manager
   - Or increase storage size in AVD settings

2. **Clean the project**:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

3. **If on physical device**:
   - Free up storage space
   - Uninstall the old app version: `adb uninstall com.example.medical_herb`
   - Then reinstall

## Result

The splash screen will now:
- ✅ Display images correctly with proper paths
- ✅ Show fallback UI if assets fail to load
- ✅ Navigate safely with mounted checks
- ✅ Have better error resilience
- ✅ Follow Flutter best practices
