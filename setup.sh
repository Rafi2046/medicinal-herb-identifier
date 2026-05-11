#!/bin/bash

# Medical Herb App - Setup Script
# This script will help you set up the application

echo "🌿 Medical Herb Identification App - Setup"
echo "=========================================="
echo ""

# Check Flutter installation
echo "📱 Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "   Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi
echo "✅ Flutter is installed"
echo ""

# Check Flutter version
echo "📋 Flutter version:"
flutter --version
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi
echo "✅ Dependencies installed successfully"
echo ""

# Check for model file
echo "🤖 Checking for TFLite model..."
if [ -f "assets/models/herb_model.tflite" ]; then
    echo "✅ Model file found"
else
    echo "⚠️  Model file not found"
    echo "   The app will run in demo mode."
    echo "   To use a real model, place 'herb_model.tflite' in 'assets/models/'"
fi
echo ""

# Check Android setup
echo "🤖 Checking Android setup..."
if [ -d "android" ]; then
    echo "✅ Android project found"
else
    echo "❌ Android project not found"
fi
echo ""

# Check iOS setup
echo "🍎 Checking iOS setup..."
if [ -d "ios" ]; then
    echo "✅ iOS project found"
else
    echo "❌ iOS project not found"
fi
echo ""

echo "=========================================="
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Connect your device or start an emulator"
echo "2. Run: flutter run"
echo "3. Grant camera and storage permissions when prompted"
echo ""
echo "For emulator storage issues:"
echo "- Use: flutter run --release"
echo "- Or increase emulator storage in AVD Manager"
echo ""
echo "Happy coding! 🚀"
