# Installation Guide

## Prerequisites

- Flutter SDK 3.10.4 or later
- Dart SDK 3.10.4 or later
- Android Studio (for Android development)
- Xcode (for iOS development on macOS)
- A physical device or emulator with sufficient storage (4GB+ recommended)

## Step-by-Step Installation

### 1. Install Dependencies

```bash
cd /Users/rafi/StudioProjects/medical_herb
flutter pub get
```

### 2. Configure Permissions

#### Android Permissions
The app requires camera and storage permissions. These are already configured in `android/app/src/main/AndroidManifest.xml`.

#### iOS Permissions
For iOS, permissions are configured in `ios/Runner/Info.plist`.

### 3. Add Your TFLite Model (Optional)

```bash
# Place your trained model in:
cp /path/to/your/herb_model.tflite assets/models/

# Update labels if needed:
nano assets/models/labels.txt
```

**Note:** If no model is added, the app will run in demo mode with simulated predictions.

### 4. Build and Run

#### Option A: Run on Debug Mode
```bash
flutter run
```

#### Option B: Run on Release Mode (Recommended for Storage Issues)
```bash
flutter run --release
```

#### Option C: Build APK
```bash
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Platform-Specific Setup

### Android Setup

1. **Minimum SDK:** Android 5.0 (API level 21)
2. **Target SDK:** Android 14 (API level 34)
3. **Required Permissions:**
   - Camera
   - Read External Storage
   - Write External Storage (for Android < 10)

#### Increase Emulator Storage
```bash
# Method 1: Through AVD Manager UI
# Tools → Device Manager → Edit → Show Advanced Settings → Internal Storage: 4096 MB

# Method 2: Command line
emulator -avd YOUR_AVD_NAME -partition-size 4096
```

### iOS Setup

1. **Minimum iOS:** 12.0
2. **Required Permissions:**
   - Camera Usage
   - Photo Library Usage

#### Run on iOS
```bash
cd ios
pod install
cd ..
flutter run
```

## Troubleshooting Installation Issues

### Issue 1: INSTALL_FAILED_INSUFFICIENT_STORAGE

**Solution:**
```bash
# Clean build
flutter clean

# Run in release mode
flutter run --release

# OR increase emulator storage (see Android Setup above)
```

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

### Issue 2: Dependencies Not Installing

**Solution:**
```bash
# Clear pub cache
flutter pub cache clean

# Get dependencies again
flutter pub get

# If still failing, upgrade Flutter
flutter upgrade
```

### Issue 3: Gradle Build Errors

**Solution:**
```bash
# Clean gradle cache
cd android
./gradlew clean
cd ..

# Rebuild
flutter clean
flutter pub get
flutter run
```

### Issue 4: Pod Install Fails (iOS)

**Solution:**
```bash
cd ios
pod deintegrate
pod cache clean --all
pod install
cd ..
flutter run
```

### Issue 5: TFLite Package Issues

**Solution:**
```bash
# If tflite_flutter fails to install, try:
flutter clean
flutter pub cache clean
flutter pub get

# For Android: Add to android/app/build.gradle.kts
android {
    packagingOptions {
        pickFirst("lib/arm64-v8a/libtensorflowlite_c.so")
        pickFirst("lib/armeabi-v7a/libtensorflowlite_c.so")
        pickFirst("lib/x86/libtensorflowlite_c.so")
        pickFirst("lib/x86_64/libtensorflowlite_c.so")
    }
}
```

## Post-Installation Verification

### 1. Check Installation
```bash
flutter doctor -v
```

### 2. Verify Dependencies
```bash
flutter pub deps
```

### 3. Run Tests
```bash
flutter test
```

### 4. Check for Errors
```bash
flutter analyze
```

## Quick Start Commands

```bash
# Setup (run once)
chmod +x setup.sh
./setup.sh

# Development
flutter run

# Release build
flutter run --release

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Clean project
flutter clean

# Update dependencies
flutter pub upgrade
```

## Environment Variables

No special environment variables are required. The app uses local assets and storage.

## Storage Requirements

- **Source Code:** ~50 MB
- **Build Files:** ~500 MB - 1 GB
- **App Size:** ~50-100 MB (debug), ~20-30 MB (release)
- **Runtime Storage:** ~10-50 MB (for scan history and favorites)

**Recommendation:** Ensure at least 2-4 GB free space on your device/emulator.

## Performance Tips

1. **Use Release Mode:** Always use `--release` flag for better performance
2. **Optimize Images:** Compress images before scanning
3. **Clear Cache:** Regularly run `flutter clean`
4. **Close Other Apps:** Free up RAM when testing
5. **Use Physical Device:** Better performance than emulators

## Getting Help

If you encounter issues:

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Read error messages carefully
3. Check Flutter issues: https://github.com/flutter/flutter/issues
4. Check TFLite issues: https://github.com/tensorflow/flutter-tflite/issues
5. Post on Stack Overflow with `flutter` tag

## Next Steps

After successful installation:

1. Grant camera and storage permissions
2. Try scanning a herb image
3. Explore the history tab
4. Add herbs to favorites
5. View detailed herb information

---

**Note:** This app works offline after installation. No internet connection is required for herb identification.
