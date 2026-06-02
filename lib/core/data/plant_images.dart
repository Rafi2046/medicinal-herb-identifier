import 'package:medical_herb/core/constants/app_images.dart';

const Map<String, String> plantImages = {
  "Tulsi": 'assets/images/tulsi.webp',
  "Lajjabati": 'assets/images/Lajjabati.webp',
  "Lojjaboti": 'assets/images/Lajjabati.webp',
  "Pudina": 'assets/images/mint.webp',
  "Neem": 'assets/images/Neem.webp',
  "Aloe Vera": 'assets/images/aloe_vera.webp',
  "Ashwagandha": 'assets/images/ashwagandha.webp',
  "Moringa": 'assets/background_image/moringa.jpg',
  "Akanda": 'assets/images/akanda.webp',
  "Arjun": 'assets/images/Arjun.webp',
  "Ashoka": 'assets/images/Ashoka.webp',
  "Aparajita": 'assets/images/Aparajita.webp',
  "Kalojira": 'assets/images/Kalojira.webp',
  "Thankuni": 'assets/images/Thankuni.webp',
  "Pathorkuchi": 'assets/images/Pathorkuchi.webp',
  "Raktakarabi": 'assets/images/Raktakarabi.webp',
  "Roktokorobi": 'assets/images/Raktakarabi.webp',
  "Hibiscus": 'assets/images/Hibiscus.webp',
  "Aishtha Nageni": 'assets/images/Aishtha Nageni.webp',
  "Anshte Lota": 'assets/images/Aishtha Nageni.webp',
  "Bideshi Lata": 'assets/images/bideshi_lata.webp',
  "Devils Backbone": 'assets/images/Devils Backbone.webp',
  "Devil's Backbone": 'assets/images/Devils Backbone.webp',
  "Dipto Luchi": 'assets/images/Dipto luchi.webp',
  "Dipto luchi": 'assets/images/Dipto luchi.webp',
  "Kumari Lata": 'assets/images/Kumari Lata.webp',
  "Kumari Lota": 'assets/images/Kumari Lata.webp',
  "Nageshwar": 'assets/images/Nageshwar.webp',
  "Nayan Tara": 'assets/images/noyontara.jpg',
  "Curry Leaf": 'assets/images/Curry_Leaf.webp',
  "Kori Pata": 'assets/images/Curry_Leaf.webp',
};

String imageForPlant(String plantName) {
  return plantImages[plantName] ?? AppImages.exploreImage;
}
