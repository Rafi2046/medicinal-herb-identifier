# Quick Start Guide

Get your Medical Herb Identification app running in 5 minutes!

## ⚡ Quick Installation

```bash
# Navigate to project
cd /Users/rafi/StudioProjects/medical_herb

# Get dependencies
flutter pub get

# Run the app (choose one)
flutter run                    # Debug mode
flutter run --release          # Release mode (recommended for storage issues)
```

## 🚀 First Time Setup

### 1. Grant Permissions
When you first launch the app, grant:
- ✅ Camera permission
- ✅ Photo library/Storage permission

### 2. Test the App
1. Tap "Take Photo" or "Choose from Gallery"
2. Select/capture a herb image
3. Wait for AI analysis (~1 second)
4. View results and herb details

### 3. Explore Features
- 📊 Check confidence score
- 📖 Read medicinal uses
- ⭐ Add to favorites
- 📜 View scan history

## 🔧 Quick Fixes

### Storage Error on Emulator?
```bash
# Solution 1: Use release mode
flutter run --release

# Solution 2: Clean and rebuild
flutter clean && flutter pub get && flutter run --release
```

### Camera Not Working?
- Check permissions in device settings
- Restart the app
- Try using gallery option instead

### App Won't Install?
```bash
# Uninstall previous version
adb uninstall com.example.medical_herb

# Clear cache
flutter clean

# Reinstall
flutter run --release
```

## 📱 Using the App

### Home Screen
- **Take Photo**: Capture herb with camera
- **Choose from Gallery**: Select existing image
- **History Tab**: View past scans

### Result Screen
- View herb identification
- Check confidence score
- Add to favorites
- View detailed information

### Details Screen
- Scientific name
- Full description
- Medicinal uses list
- Important precautions

## 🤖 Demo Mode

No TFLite model? No problem!
- App runs in **demo mode** automatically
- Generates simulated predictions
- Perfect for testing UI/UX
- Add real model later: `assets/models/herb_model.tflite`

## 📋 Common Commands

```bash
# Development
flutter run                    # Debug
flutter run --release          # Release
flutter run --profile          # Profile

# Cleaning
flutter clean                  # Clean build
flutter pub cache clean        # Clean cache

# Building
flutter build apk --release    # Android APK
flutter build appbundle        # Android Bundle
flutter build ios --release    # iOS build

# Debugging
flutter doctor                 # Check setup
flutter devices                # List devices
flutter logs                   # View logs
```

## 🎯 Testing Workflow

1. **Connect device or start emulator**
   ```bash
   flutter devices
   ```

2. **Run in release mode** (better performance)
   ```bash
   flutter run --release
   ```

3. **Test core features**
   - ✅ Capture image
   - ✅ Select from gallery
   - ✅ View prediction
   - ✅ Check history
   - ✅ Add favorite

4. **Check for errors**
   ```bash
   flutter analyze
   ```

## 💡 Pro Tips

### For Developers
- Use `flutter run --release` for faster performance
- Enable hot reload in debug mode with `r`
- Full restart with `R`
- Clear app data: `flutter run --clear-cache`

### For Testing
- Test on physical device for best results
- Use high-quality herb images
- Ensure good lighting
- Test both camera and gallery features
- Verify dark mode appearance

### For Production
- Build release APK/IPA
- Test on multiple devices
- Verify permissions work
- Test offline functionality
- Check storage usage

## 🐛 Quick Troubleshooting

| Problem | Quick Fix |
|---------|-----------|
| Storage error | `flutter run --release` |
| Dependencies fail | `flutter clean && flutter pub get` |
| Camera not working | Check app permissions |
| Slow performance | Use release mode |
| Gradle errors | `cd android && ./gradlew clean` |
| Pod errors (iOS) | `cd ios && pod install` |

## 📚 Next Steps

Once app is running:

1. **Read full docs**
   - [README.md](README.md) - Project overview
   - [FEATURES.md](FEATURES.md) - All features
   - [INSTALLATION.md](INSTALLATION.md) - Detailed setup
   - [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Common issues

2. **Add your model**
   - Train custom TFLite model
   - Place in `assets/models/`
   - Update `labels.txt`
   - Rebuild app

3. **Customize**
   - Update herb database
   - Modify UI colors
   - Add more features
   - Contribute back!

## ✅ Verification Checklist

Before considering setup complete:

- [ ] App installs successfully
- [ ] Camera permission granted
- [ ] Gallery permission granted
- [ ] Can capture photo
- [ ] Can select from gallery
- [ ] Image analysis works
- [ ] Results display correctly
- [ ] Can view herb details
- [ ] History saves scans
- [ ] Favorites work
- [ ] Dark mode toggles
- [ ] No critical errors

## 🆘 Need Help?

1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Run `flutter doctor -v`
3. Check error logs
4. Search GitHub issues
5. Post on Stack Overflow

## 🎉 Success!

If you can scan a herb and see results, you're all set! 

Happy herb identifying! 🌿

---

**Estimated Time:** 5-10 minutes for basic setup

**Next:** [Read full features →](FEATURES.md)
