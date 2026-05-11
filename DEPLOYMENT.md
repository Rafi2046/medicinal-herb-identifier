# Deployment Guide

Guide for building and deploying the Medical Herb Identification app to production.

---

## 📋 Pre-Deployment Checklist

### Code Quality
- [ ] All features tested thoroughly
- [ ] No console errors or warnings
- [ ] Code properly commented
- [ ] Run `flutter analyze` with no issues
- [ ] Run `flutter test` (if tests exist)
- [ ] Performance optimized

### Assets & Resources
- [ ] TFLite model added and tested
- [ ] All images compressed
- [ ] Labels.txt updated
- [ ] App icon created
- [ ] Splash screen designed

### Configuration
- [ ] App name finalized
- [ ] Package name set correctly
- [ ] Version number updated
- [ ] Build number incremented
- [ ] Permissions verified

### Legal & Documentation
- [ ] Privacy policy created
- [ ] Terms of service written
- [ ] App store description ready
- [ ] Screenshots prepared
- [ ] Promotional graphics created

---

## 🤖 Android Deployment

### 1. Configure App Details

#### Update `android/app/build.gradle.kts`
```kotlin
android {
    namespace = "com.yourcompany.medical_herb"
    compileSdk = 34
    
    defaultConfig {
        applicationId = "com.yourcompany.medical_herb"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }
}
```

### 2. Create Keystore

```bash
# Generate keystore
keytool -genkey -v -keystore ~/medical-herb-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias medical-herb-key

# You'll be prompted for:
# - Keystore password
# - Key password
# - Name, Organization, etc.
```

### 3. Configure Signing

Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=medical-herb-key
storeFile=/Users/yourname/medical-herb-key.jks
```

Update `android/app/build.gradle.kts`:
```kotlin
// Add before android block
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... existing config ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### 4. Build Release APK

```bash
# Build APK
flutter build apk --release

# Output location:
# build/app/outputs/flutter-apk/app-release.apk

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Output location:
# build/app/outputs/bundle/release/app-release.aab
```

### 5. Test Release Build

```bash
# Install on device
adb install build/app/outputs/flutter-apk/app-release.apk

# Or use:
flutter install
```

### 6. Optimize APK Size

Add to `android/app/build.gradle.kts`:
```kotlin
android {
    buildTypes {
        release {
            // Enable code shrinking
            minifyEnabled true
            shrinkResources true
            
            // ProGuard rules
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    // Split APKs by ABI
    splits {
        abi {
            enable true
            reset()
            include "armeabi-v7a", "arm64-v8a", "x86_64"
            universalApk true
        }
    }
}
```

### 7. Google Play Store Submission

1. **Create Developer Account**
   - Go to https://play.google.com/console
   - Pay $25 one-time fee
   - Complete registration

2. **Create App**
   - Click "Create app"
   - Fill in app details
   - Select app category: Medical or Health & Fitness

3. **Upload Build**
   - Go to Release → Production
   - Create new release
   - Upload app-release.aab
   - Add release notes

4. **Store Listing**
   - App name: "Medicinal Herb Identifier"
   - Short description (80 chars)
   - Full description (4000 chars)
   - Screenshots (at least 2)
   - Feature graphic (1024x500)
   - App icon (512x512)

5. **Content Rating**
   - Fill out questionnaire
   - Medical app → Select appropriate options

6. **Pricing & Distribution**
   - Free or Paid
   - Select countries
   - Content rating acknowledgment

7. **Submit for Review**
   - Review all sections
   - Submit app
   - Wait 1-7 days for approval

---

## 🍎 iOS Deployment

### 1. Configure Xcode Project

Open `ios/Runner.xcworkspace` in Xcode:

1. Select Runner in Project Navigator
2. Go to Signing & Capabilities
3. Select your Team
4. Update Bundle Identifier: `com.yourcompany.medicalherb`

### 2. Update Info.plist

Ensure permissions are set in `ios/Runner/Info.plist` (already done).

### 3. Update Version

In `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

### 4. Build iOS App

```bash
# Build iOS release
flutter build ios --release

# Or build IPA
flutter build ipa --release
```

### 5. App Store Connect

1. **Create App Store Connect Account**
   - Enroll in Apple Developer Program ($99/year)
   - Go to https://appstoreconnect.apple.com

2. **Create App**
   - Click "+" → New App
   - Platform: iOS
   - Name: "Medicinal Herb Identifier"
   - Primary Language: English
   - Bundle ID: com.yourcompany.medicalherb
   - SKU: MEDHERB001

3. **App Information**
   - Category: Medical or Health & Fitness
   - Age Rating: 4+
   - Privacy Policy URL

4. **Prepare for Submission**
   - Screenshots (6.5", 5.5" required)
   - App Preview (optional video)
   - Promotional text
   - Description
   - Keywords
   - Support URL
   - Marketing URL (optional)

5. **Upload Build**
   ```bash
   # Using Xcode
   # Product → Archive → Distribute App
   
   # Or using Transporter app
   # Download from Mac App Store
   # Drag IPA file to upload
   ```

6. **TestFlight (Optional)**
   - Internal testing with up to 100 users
   - External testing with up to 10,000 users
   - Get feedback before public release

7. **Submit for Review**
   - Select build
   - Add App Review Information
   - Submit
   - Wait 24-48 hours for review

---

## 🌐 Web Deployment (Future)

### Build Web Version
```bash
flutter build web --release
```

### Deploy to Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Deploy
firebase deploy --only hosting
```

### Deploy to GitHub Pages
```bash
# Build
flutter build web --release --base-href "/medical_herb/"

# Copy to docs folder
cp -r build/web/* docs/

# Commit and push
git add docs/
git commit -m "Deploy web version"
git push

# Enable GitHub Pages in repository settings
```

---

## 📊 App Store Optimization (ASO)

### Keywords
- Medicinal herbs
- Herb identifier
- Plant identification
- AI herb scanner
- Herbal medicine
- Natural remedies
- Herb encyclopedia

### Title Suggestions
- "Medicinal Herb Identifier - AI Scanner"
- "HerbID: Medicinal Plant Identifier"
- "Ayurveda Herb Scanner & Guide"

### Description Template
```
🌿 Identify Medicinal Herbs Instantly with AI

Discover the power of nature with our AI-powered medicinal herb identification app. Simply take a photo or choose from your gallery, and get instant results with detailed information about medicinal properties.

✨ KEY FEATURES:
• AI-Powered Identification
• Offline Functionality
• Detailed Herb Information
• Medicinal Uses Database
• Scan History
• Favorites System
• Dark Mode Support

📸 HOW IT WORKS:
1. Capture or select herb image
2. AI analyzes in seconds
3. View identification results
4. Learn about medicinal uses

🌱 HERB DATABASE:
Comprehensive information on medicinal herbs including:
• Common and scientific names
• Medicinal properties
• Traditional uses
• Precautions and warnings

🔒 PRIVACY FIRST:
• 100% offline after installation
• No data collection
• No account required
• All data stored locally

⚠️ DISCLAIMER:
For educational purposes only. Consult healthcare professionals before using medicinal herbs.

Download now and unlock the healing power of nature! 🌿
```

---

## 📈 Post-Launch

### Analytics Setup (Optional)
```yaml
# Add to pubspec.yaml
dependencies:
  firebase_analytics: ^10.8.0
  firebase_crashlytics: ^3.4.9
```

### Monitoring
- Track crash reports
- Monitor user feedback
- Check download statistics
- Review app ratings

### Updates
1. Fix bugs reported by users
2. Add requested features
3. Update herb database
4. Improve ML model
5. Increment version number
6. Submit update

### Marketing
- Create social media presence
- Write blog posts
- Create demo videos
- Reach out to health bloggers
- Submit to app review sites

---

## 🔄 Version Management

### Semantic Versioning
Format: `MAJOR.MINOR.PATCH+BUILD`

Example:
- 1.0.0+1 - Initial release
- 1.0.1+2 - Bug fix
- 1.1.0+3 - New feature
- 2.0.0+4 - Major update

Update in `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

---

## 📝 Release Notes Template

```markdown
Version 1.0.0
- 🎉 Initial release
- 🤖 AI-powered herb identification
- 📸 Camera and gallery support
- 📚 10 medicinal herbs database
- ⭐ Favorites system
- 📜 Scan history
- 🌓 Dark mode support
- 🔒 100% offline functionality

Known Issues:
- None

Coming Soon:
- More herbs
- Multiple language support
- AR mode
```

---

## ⚠️ Important Notes

### Medical App Compliance
- Include proper disclaimers
- Don't make medical claims
- Recommend consulting professionals
- Follow app store medical app guidelines

### Privacy Policy (Required)
Create a privacy policy covering:
- Data collection (none in this case)
- Camera usage
- Storage permissions
- User rights
- Contact information

### Terms of Service
Basic terms covering:
- Acceptable use
- Disclaimer of warranties
- Limitation of liability
- Educational purpose only

---

## 🎯 Success Metrics

Track these after launch:
- Download count
- Daily/Monthly active users
- Average session duration
- Retention rate (Day 1, 7, 30)
- Crash-free rate (aim for 99%+)
- App store rating (aim for 4.5+)
- User reviews and feedback

---

## 📞 Support

After launch, provide:
- Support email
- FAQ page
- In-app feedback option
- Bug report mechanism
- Feature request form

---

## 🚀 Launch Checklist

Final checklist before submitting:

### Technical
- [ ] App builds successfully
- [ ] All features work correctly
- [ ] No crashes or critical bugs
- [ ] Performance is acceptable
- [ ] Tested on multiple devices
- [ ] Permissions work correctly
- [ ] Dark mode functions properly
- [ ] Offline mode works

### Assets
- [ ] App icon set (all sizes)
- [ ] Splash screen added
- [ ] Screenshots taken (all sizes)
- [ ] Feature graphic created
- [ ] Promotional graphics ready

### Legal
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Medical disclaimers added
- [ ] Copyright notices included
- [ ] Third-party licenses listed

### Store Listing
- [ ] App name finalized
- [ ] Description written
- [ ] Keywords researched
- [ ] Category selected
- [ ] Age rating appropriate
- [ ] Pricing set
- [ ] Countries selected

### Post-Launch
- [ ] Support email set up
- [ ] Social media accounts created
- [ ] Analytics configured
- [ ] Crash reporting enabled
- [ ] Update plan prepared

---

**Ready to launch! 🚀**

Good luck with your app deployment!
