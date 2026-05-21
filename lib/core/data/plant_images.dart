import 'package:medical_herb/core/constants/app_images.dart';

/// Maps plant names to their image asset paths.
/// Add or update entries as images become available.
const Map<String, String> plantImages = {
  "Tulsi": 'assets/background_image/herb_banner.webp',
  "Lajjabati": 'assets/background_image/herb_banner.webp',
  "Neem": 'assets/background_image/nim.jpeg',
  "Aloe Vera": 'assets/background_image/herb_banner.webp',
  "Mint": 'assets/app_icons/mint.webp',
  "Ashwagandha": 'assets/background_image/herb_banner.webp',
  "Moringa": 'assets/background_image/moringa.jpg',
  "Akanda": 'assets/background_image/herb_banner.webp',
  "Arjun": 'assets/background_image/herb_banner.webp',
  "Ashoka": 'assets/background_image/herb_banner.webp',
  "Aparajita": 'assets/background_image/herb_banner.webp',
  "Kalojira": 'assets/background_image/herb_banner.webp',
  "Thankuni": 'assets/background_image/herb_banner.webp',
  "Pathorkuchi": 'assets/background_image/herb_banner.webp',
  "Raktakarabi": 'assets/background_image/herb_banner.webp',
  "Hibiscus": 'assets/background_image/herb_banner.webp',
  "Curry Leaf": 'assets/background_image/herb_banner.webp',
  "Aishtha Nageni": 'assets/background_image/herb_banner.webp',
  "Bideshi Lata": 'assets/background_image/herb_banner.webp',
  "Devils Backbone": 'assets/background_image/herb_banner.webp',
  "Dipto luchi": 'assets/background_image/herb_banner.webp',
  "Kumari Lata": 'assets/background_image/herb_banner.webp',
  "Nageshwar": 'assets/background_image/herb_banner.webp',
  "Nayan Tara": 'assets/background_image/herb_banner.webp',
};

String imageForPlant(String plantName) {
  return plantImages[plantName] ?? AppImages.exploreImage;
}
