# Features Documentation

## Core Features

### 1. Image Capture & Selection

#### Camera Capture
- **Direct Photo Capture**: Take photos directly from the app
- **Image Quality**: Automatically optimized to 1024x1024
- **Compression**: 85% quality for optimal balance
- **Format Support**: JPEG, PNG

#### Gallery Selection
- **Photo Library Access**: Choose from existing images
- **Multi-format Support**: Works with all standard image formats
- **Auto-resize**: Images automatically resized for model input

**Technical Details:**
```dart
// Camera settings
maxWidth: 1024
maxHeight: 1024
imageQuality: 85
source: ImageSource.camera / ImageSource.gallery
```

---

### 2. AI-Powered Herb Identification

#### Machine Learning Model
- **Framework**: TensorFlow Lite
- **Input Size**: 224x224x3 (RGB)
- **Input Type**: Float32 (normalized 0-1)
- **Output**: Softmax probabilities
- **Inference Time**: < 1 second on modern devices

#### Image Preprocessing
1. **Decode**: Convert image bytes to pixel data
2. **Resize**: Scale to 224x224 pixels
3. **Normalize**: Convert RGB values to 0-1 range
4. **Format**: Reshape to [1, 224, 224, 3] tensor

#### Supported Herbs (Default Database)
1. Aloe Vera
2. Basil (Tulsi)
3. Mint (Pudina)
4. Neem
5. Turmeric
6. Ginger
7. Ashwagandha
8. Brahmi
9. Moringa
10. Giloy

**Extensible:** Add more herbs by updating the model and database.

---

### 3. Confidence Scoring

#### Confidence Levels
- **90-100%**: Excellent match - Very high confidence
- **80-89%**: Good match - High confidence
- **70-79%**: Moderate confidence - Result likely correct
- **60-69%**: Low confidence - Please verify
- **<60%**: Very low confidence - Retake image recommended

#### Visual Indicators
- Color-coded progress bar
- Percentage display
- Descriptive message
- Icon representation

#### Technical Implementation
```dart
// Confidence calculation
double confidence = max(softmax_probabilities)
String label = labels[argmax(softmax_probabilities)]
```

---

### 4. Detailed Herb Information

#### Information Provided
- **Common Name**: Local/English name
- **Scientific Name**: Latin taxonomic name
- **Description**: Detailed overview of the herb
- **Medicinal Uses**: List of health benefits and applications
- **Precautions**: Important safety information

#### Data Structure
```dart
class Herb {
  String id;
  String name;
  String scientificName;
  String description;
  List<String> medicinalUses;
  String? imagePath;
  double? confidence;
}
```

#### UI Components
- Expandable cards
- Scrollable content
- Formatted text
- Icons and visual hierarchy
- Share functionality (coming soon)

---

### 5. Favorites System

#### Functionality
- **Add to Favorites**: Tap heart icon
- **Remove from Favorites**: Tap again to remove
- **Persistent Storage**: Saved locally using Hive
- **Quick Access**: Easy retrieval of saved herbs

#### Storage
- Local NoSQL database (Hive)
- No internet required
- Instant access
- Unlimited favorites (storage permitting)

#### Implementation
```dart
// Toggle favorite
await provider.toggleFavorite(herbId);

// Check if favorite
bool isFavorite = provider.isFavorite(herbId);
```

---

### 6. Scan History

#### Features
- **Automatic Saving**: All scans saved automatically
- **Image Preservation**: Original scan images stored
- **Metadata Tracking**: Confidence, timestamp, herb info
- **Search & Filter**: (Coming in future update)
- **Clear History**: Option to clear all or individual items

#### History Entry Data
```dart
class ScanHistory {
  String id;
  String herbName;
  String scientificName;
  String imagePath;
  double confidence;
  DateTime timestamp;
}
```

#### UI Features
- List view with thumbnails
- Timestamp display (relative and absolute)
- Confidence badges
- Delete individual items
- Clear all with confirmation

---

### 7. Modern UI/UX

#### Material 3 Design
- Dynamic color schemes
- Elevated cards
- Smooth animations
- Responsive layouts
- Touch feedback

#### Dark Mode Support
- Automatic system theme detection
- Seamless switching
- Optimized contrast
- Battery-friendly (OLED)

#### Responsive Design
- Adapts to screen sizes
- Portrait and landscape
- Tablet support
- Accessibility features

#### Color Scheme
```dart
// Light theme
seedColor: Colors.green
brightness: Brightness.light

// Dark theme
seedColor: Colors.green
brightness: Brightness.dark
```

---

### 8. Offline Functionality

#### Complete Offline Support
- No internet required after installation
- Local model inference
- Local data storage
- Instant responses

#### Benefits
- Privacy protection
- Works anywhere
- No data charges
- Fast performance
- Reliable operation

---

## Advanced Features

### State Management

#### Provider Pattern
- Centralized state management
- Reactive UI updates
- Clean architecture
- Testable code

#### Key Providers
- `HerbProvider`: Main app state
- Manages predictions
- Handles history
- Controls favorites

### Local Storage

#### Hive Database
- NoSQL document database
- Fast read/write
- Type-safe
- Cross-platform

#### Storage Types
- Scan history
- Favorites list
- User preferences
- Cached images

### Error Handling

#### Graceful Degradation
- Clear error messages
- User-friendly alerts
- Retry options
- Fallback behavior

#### Error Types Handled
- Camera access denied
- Storage full
- Model loading failed
- Image processing errors
- Prediction failures

---

## Performance Optimizations

### Image Processing
- Efficient resize algorithms
- Memory management
- Async operations
- Quality vs. size balance

### Model Inference
- GPU acceleration (when available)
- Multi-threading (4 threads)
- Optimized model format
- Batch processing support

### UI Performance
- Lazy loading
- Image caching
- Smooth animations
- Efficient rebuilds

---

## Security & Privacy

### Data Privacy
- All data stored locally
- No cloud uploads
- No tracking
- No analytics (by default)

### Permissions
- Camera: Only for capture
- Storage: Only for image access
- No network permission required

---

## Accessibility

### Features
- Screen reader support
- High contrast modes
- Large touch targets
- Clear labels
- Keyboard navigation (web)

---

## Future Features (Roadmap)

### Planned Enhancements
- [ ] Search functionality in history
- [ ] Export history to PDF
- [ ] Share results via social media
- [ ] Multiple language support
- [ ] Augmented Reality (AR) mode
- [ ] Community contributions
- [ ] Herb comparison feature
- [ ] Dosage calculator
- [ ] Interaction checker
- [ ] Location-based suggestions

---

## Technical Specifications

### Performance Metrics
- **App Size**: 20-30 MB (release)
- **Memory Usage**: 50-150 MB
- **Inference Time**: 500-1000ms
- **Image Processing**: 200-500ms
- **Storage**: 10-50 MB (history)

### Supported Platforms
- Android 5.0+ (API 21+)
- iOS 12.0+
- Tablet support
- (Future: Web, Desktop)

### Dependencies
- Flutter SDK
- TensorFlow Lite
- Image processing libraries
- State management (Provider)
- Local storage (Hive)

---

## API Reference

### ModelService
```dart
// Initialize model
await modelService.initialize();

// Predict from image
PredictionResult result = await modelService.predict(imageFile);

// Get top N predictions
List<PredictionResult> results = await modelService.predictTopN(imageFile, topN: 3);

// Get herb details
Herb herb = modelService.getHerbDetails(label);
```

### HerbProvider
```dart
// Initialize
await provider.initialize();

// Predict
await provider.predictFromImage(imageFile);

// Favorites
await provider.toggleFavorite(herbId);
bool isFavorite = provider.isFavorite(herbId);

// History
List<ScanHistory> history = provider.scanHistory;
await provider.clearHistory();
await provider.deleteHistoryItem(id);
```

---

## Best Practices

### For Best Results
1. Use clear, well-lit photos
2. Focus on leaf details
3. Avoid blurry images
4. Center the herb in frame
5. Use plain background
6. Capture from multiple angles

### App Usage
1. Grant required permissions
2. Keep app updated
3. Clear cache periodically
4. Backup important history
5. Use release builds for production

---

## Credits

Built with:
- Flutter framework
- TensorFlow Lite
- Material Design 3
- Open source packages

For educational and informational purposes only.
