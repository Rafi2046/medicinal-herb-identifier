# 🌿 Medicinal Herb Identification App

A production-ready Flutter mobile application that uses AI to identify medicinal herbs from leaf images using TensorFlow Lite.

## ✨ Features

### Core Functionality
- 📸 **Camera Capture**: Take photos of herbs directly from the app
- 🖼️ **Gallery Selection**: Choose existing images from your device
- 🤖 **AI-Powered Identification**: Uses TensorFlow Lite for offline herb recognition
- 📊 **Confidence Scoring**: Shows prediction confidence with visual indicators
- 📖 **Detailed Information**: Comprehensive medicinal uses and properties
- ⭐ **Favorites System**: Save your frequently used herbs
- 📜 **Scan History**: Track all your previous identifications

### Technical Features
- 🎨 **Material 3 Design**: Modern, beautiful UI with dynamic colors
- 🌓 **Dark Mode Support**: Automatic theme switching based on system preference
- 💾 **Local Storage**: All data stored locally using Hive
- 🚀 **Offline First**: Works completely offline after initial setup
- 📱 **Optimized Performance**: Efficient image processing and model inference
- 🔒 **Null Safety**: Full null safety implementation
- 🏗️ **Clean Architecture**: Scalable and maintainable code structure

## 🏗️ Architecture

```
lib/
├── main.dart                 # App entry point
├── model/                    # Data models
│   ├── herb_model.dart       # Herb and history models
│   └── herb_model.g.dart     # Generated Hive adapters
├── providers/                # State management
│   └── herb_provider.dart    # Main app state provider
├── screens/                  # UI screens
│   ├── home_screen.dart      # Home with tabs
│   ├── result_screen.dart    # Prediction results
│   └── details_screen.dart   # Herb details
└── services/                 # Business logic
    └── model_service.dart    # TFLite model operations

assets/
├── models/
│   ├── herb_model.tflite     # TFLite model (add your own)
│   └── labels.txt            # Class labels
└── images/                   # App images
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.4 or later)
- Android Studio / Xcode for mobile development
- A trained TensorFlow Lite model (or use demo mode)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/medical_herb.git
cd medical_herb
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Add your TFLite model** (optional)
   - Place your `herb_model.tflite` in `assets/models/`
   - Update `labels.txt` with your herb classes
   - If no model is provided, app runs in demo mode

4. **Run the app**
```bash
flutter run
```

## 📦 Dependencies

### Core Dependencies
- **flutter**: SDK
- **provider**: ^6.1.1 - State management
- **tflite_flutter**: ^0.11.0 - TensorFlow Lite inference
- **image**: ^4.1.7 - Image processing
- **image_picker**: ^1.0.7 - Camera and gallery access
- **hive**: ^2.2.3 - Local NoSQL database
- **hive_flutter**: ^1.1.0 - Hive Flutter integration
- **shared_preferences**: ^2.2.2 - Simple key-value storage
- **path_provider**: ^2.1.2 - File system access

### Dev Dependencies
- **flutter_lints**: ^6.0.0 - Linting rules
- **hive_generator**: ^2.0.1 - Code generation for Hive
- **build_runner**: ^2.4.8 - Code generation runner

## 🤖 AI Model Setup

### Model Requirements
- **Input Shape**: [1, 224, 224, 3]
- **Input Type**: Float32 (normalized 0-1)
- **Output**: Softmax probabilities
- **Format**: TensorFlow Lite (.tflite)

### Training Your Model

```python
import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D
from tensorflow.keras.models import Model

# Create model
base_model = MobileNetV2(weights='imagenet', include_top=False, input_shape=(224, 224, 3))
x = base_model.output
x = GlobalAveragePooling2D()(x)
x = Dense(128, activation='relu')(x)
predictions = Dense(num_classes, activation='softmax')(x)
model = Model(inputs=base_model.input, outputs=predictions)

# Train your model...
# model.fit(...)

# Convert to TFLite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()

with open('herb_model.tflite', 'wb') as f:
    f.write(tflite_model)
```

## 📱 Screenshots

[Add your app screenshots here]

## 🗂️ Herb Database

The app includes information for 10 common medicinal herbs:

1. **Aloe Vera** - Skin care and wound healing
2. **Basil (Tulsi)** - Stress relief and immunity
3. **Mint (Pudina)** - Digestive aid
4. **Neem** - Antibacterial properties
5. **Turmeric** - Anti-inflammatory
6. **Ginger** - Nausea relief
7. **Ashwagandha** - Adaptogen
8. **Brahmi** - Memory enhancement
9. **Moringa** - Nutrient-rich
10. **Giloy** - Immunity booster

You can extend this by modifying the `_getHerbDatabase()` method in `model_service.dart`.

## 🧪 Testing

The app includes demo mode for testing without a trained model:

```bash
flutter run
```

The demo mode will:
- Generate random predictions
- Show confidence scores
- Display all UI features
- Allow testing of all functionality

## 🔧 Configuration

### Adjusting Model Input Size
Edit `ModelService` in `services/model_service.dart`:
```dart
static const int inputSize = 224; // Change to your model's input size
```

### Adding More Herbs
1. Update `labels.txt` with new herb names
2. Add herb data in `_getHerbDatabase()` method
3. Retrain your model with new classes

## 📝 Code Quality

The project follows Flutter best practices:
- ✅ Null safety enabled
- ✅ Proper error handling
- ✅ Clean code architecture
- ✅ Comprehensive comments
- ✅ Material 3 design system
- ✅ Responsive layouts
- ✅ Performance optimizations

## 🐛 Troubleshooting

### Issue: "Model not found"
**Solution**: Either add your `.tflite` model to `assets/models/` or use demo mode.

### Issue: "Camera permission denied"
**Solution**: Grant camera permissions in device settings.

### Issue: INSTALL_FAILED_INSUFFICIENT_STORAGE
**Solution**: 
- Free up space on your device/emulator
- Use a device with more storage
- Or run: `adb shell pm clear com.android.vending` to clear cache

### Issue: "Image picker not working"
**Solution**: Check permissions in `AndroidManifest.xml` and `Info.plist`.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Disclaimer

This application is for educational purposes only. Always consult with qualified healthcare professionals before using any medicinal herbs. The information provided is not a substitute for professional medical advice.

## 👨‍💻 Author

Created with ❤️ using Flutter

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- TensorFlow team for TFLite
- Medicinal herb researchers and practitioners
- Open source community

---

**Note**: To use this app in production, please add your own trained TensorFlow Lite model. The demo mode is only for testing purposes.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
