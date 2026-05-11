# Troubleshooting Guide - Installation Storage Issues

## Problem: INSTALL_FAILED_INSUFFICIENT_STORAGE

This error occurs when the Android device/emulator doesn't have enough storage space to install the app.

## Solutions (in order of recommendation)

### Solution 1: Free Up Space on Emulator
1. Open Android Studio
2. Go to Tools → Device Manager (AVD Manager)
3. Click the pencil icon (Edit) on your emulator
4. Click "Show Advanced Settings"
5. Scroll to "Internal Storage" and increase it to at least 2048 MB
6. Click "Finish" and restart the emulator

### Solution 2: Clear App Data
```bash
# Clear the app data if it's already partially installed
adb shell pm clear com.example.medical_herb
adb shell pm uninstall com.example.medical_herb

# Then try installing again
flutter run
```

### Solution 3: Use Release Mode
Release builds are smaller than debug builds:
```bash
flutter run --release
```

### Solution 4: Clean and Rebuild
```bash
# Clean the build
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

### Solution 5: Create New Emulator with More Storage
1. Open Android Studio
2. Tools → Device Manager
3. Click "Create Device"
4. Select a device (e.g., Pixel 5)
5. Select a system image (e.g., Android 13)
6. Click "Show Advanced Settings"
7. Set Internal Storage: 4096 MB (4 GB)
8. Set SD Card: 512 MB
9. Click "Finish"

### Solution 6: Clear Emulator Cache
```bash
# Wipe emulator data
adb -e emu kill
# Then start the emulator fresh from AVD Manager
```

### Solution 7: Use Physical Device
If possible, use a physical Android device:
1. Enable Developer Options on your phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter devices` to verify connection
5. Run: `flutter run`

### Solution 8: Reduce APK Size
Add to `android/app/build.gradle.kts`:

```kotlin
android {
    buildTypes {
        getByName("debug") {
            isMinifyEnabled = true
            isShrinkResources = true
        }
    }
}
```

### Solution 9: Check Available Space
```bash
# Check available space on emulator
adb shell df -h

# If very low, use one of the solutions above
```

### Solution 10: Install via APK
Build and install APK manually:
```bash
# Build APK
flutter build apk --release

# Install APK
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Prevention Tips

1. **Regular Cleanup**: Regularly clean build folders
   ```bash
   flutter clean
   ```

2. **Use Release Builds**: For testing, use release mode when possible
   ```bash
   flutter run --release
   ```

3. **Optimize Assets**: Compress images and assets before adding to app

4. **Monitor Storage**: Keep an eye on emulator storage usage

5. **Proper Emulator Config**: Create emulators with adequate storage (4+ GB)

## Still Having Issues?

If none of these solutions work:

1. Check Android Studio logs for more details
2. Try updating Flutter: `flutter upgrade`
3. Update Android SDK tools
4. Reinstall Android Studio
5. Create a new Flutter project and migrate your code

## Quick Command Reference

```bash
# Flutter
flutter clean
flutter pub get
flutter run
flutter run --release
flutter devices

# ADB
adb devices
adb shell df -h
adb shell pm clear com.example.medical_herb
adb uninstall com.example.medical_herb

# Build
flutter build apk --release
flutter build appbundle --release
```

## Contact Support

If you continue experiencing issues, please:
1. Check Flutter GitHub issues
2. Post on Stack Overflow with the `flutter` tag
3. Join Flutter Discord community

---

**Note**: The error you encountered is specifically about storage. Make sure your emulator has at least 2-4 GB of internal storage available.
