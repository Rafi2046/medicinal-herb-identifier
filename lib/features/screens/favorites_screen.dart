// import 'package:flutter/material.dart';
// import 'package:medical_herb/core/constants/app_text_styles.dart';
//
// /// Favorites list for embedding in the main bottom navigation (no app bar).
// class FavoritesBody extends StatefulWidget {
//   const FavoritesBody({super.key});
//
//   @override
//   State<FavoritesBody> createState() => _FavoritesBodyState();
// }
//
// class _FavoritesBodyState extends State<FavoritesBody> {
//   final List<_FavoriteItem> _items = List<_FavoriteItem>.from(_favoriteSeed);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//       child: _items.isEmpty
//           ? _buildEmpty()
//           : ListView.separated(
//         itemCount: _items.length,
//         separatorBuilder: (_, _) => const SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final item = _items[index];
//           return _FavoriteCard(
//             item: item,
//             onRemove: () {
//               setState(() {
//                 _items.removeAt(index);
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildEmpty() {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               color: Color(0xFFE7F7EC),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.favorite_border_rounded,
//               size: 34,
//               color: Color(0xFF2D9E61),
//             ),
//           ),
//           const SizedBox(height: 14),
//           Text(
//             'No favorites yet',
//             style: AppTextStyles.heading3.copyWith(
//                 color: const Color(0xFF1F5F3D)),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             'Add herbs to favorites from scan results.',
//             style: AppTextStyles.body3.copyWith(color: const Color(0xFF727D75)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F2F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F2F8),
//         elevation: 0,
//         centerTitle: false,
//         title: Text(
//             'Favorites',
//             style: AppTextStyles.title),
//       ),
//     )
//     ,
//     body: const FavoritesBody(),
//     );
//     }
// }
//
// class _FavoriteCard extends StatelessWidget {
//   const _FavoriteCard({required this.item, required this.onRemove});
//
//   final _FavoriteItem item;
//   final VoidCallback onRemove;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFD9D9D9)),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x14000000),
//             blurRadius: 8,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               item.imagePath,
//               width: 52,
//               height: 52,
//               fit: BoxFit.cover,
//               errorBuilder: (_, _, _) =>
//                   Container(
//                     width: 52,
//                     height: 52,
//                     color: const Color(0xFFE7F7EC),
//                     alignment: Alignment.center,
//                     child: const Icon(
//                         Icons.image_not_supported_outlined, size: 18),
//                   ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: AppTextStyles.buttonText.copyWith(
//                     fontWeight: FontWeight.w700,
//                     color: const Color(0xFF1F5F3D),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   item.scientific,
//                   style: AppTextStyles.quickSubTile.copyWith(
//                     fontStyle: FontStyle.italic,
//                     color: const Color(0xFF727D75),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: onRemove,
//             icon: const Icon(Icons.favorite_rounded, color: Color(0xFFE53935)),
//             tooltip: 'Remove favorite',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _FavoriteItem {
//   const _FavoriteItem({
//     required this.name,
//     required this.scientific,
//     required this.imagePath,
//   });
//
//   final String name;
//   final String scientific;
//   final String imagePath;
// }
//
// const List<_FavoriteItem> _favoriteSeed = [
//   _FavoriteItem(
//     name: 'Joba',
//     scientific: 'Hibiscus rosa-sinensis',
//     imagePath: 'assets/background_image/joba.webp',
//   ),
//   _FavoriteItem(
//     name: 'Neem',
//     scientific: 'Azadirachta indica',
//     imagePath: 'assets/background_image/nim.jpeg',
//   ),
//   _FavoriteItem(
//     name: 'Moringa',
//     scientific: 'Moringa oleifera',
//     imagePath: 'assets/background_image/moringa.jpg',
//   ),
// ];
