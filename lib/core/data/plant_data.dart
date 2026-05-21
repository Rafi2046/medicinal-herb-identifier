class PlantData {
  final String description;
  final List<String> medicinalUses;
  final List<String> goodSides;
  final List<String> badSides;
  final String scientificName;
  final String family;
  final String region;

  PlantData({
    required this.description,
    required this.medicinalUses,
    required this.goodSides,
    required this.badSides,
    required this.scientificName,
    required this.family,
    required this.region,
  });
}
