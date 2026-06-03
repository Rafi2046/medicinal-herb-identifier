import 'package:medical_herb/core/data/plant_data.dart';

final Map<String, PlantData> plantDatabase = {
  "Tulsi": PlantData(
    description:
        "Tulsi, also known as Holy Basil, is a sacred plant in Hindu belief. It is widely known for its medicinal properties and is commonly used in Ayurveda.",
    medicinalUses: [
      "Relieves cough and cold",
      "Boosts immunity",
      "Reduces stress and blood pressure",
      "Improves digestion",
    ],
    goodSides: [
      "Highly effective for respiratory issues",
      "Can be consumed daily as tea",
    ],
    badSides: [
      "May lower blood sugar too much for diabetic patients",
      "Not recommended in large quantities during pregnancy",
    ],
    scientificName: "Ocimum tenuiflorum",
    family: "Lamiaceae",
    region: "Indian Subcontinent",
  ),
  "Lajjabati": PlantData(
    description:
        "Lajjabati (Mimosa pudica), also called the sensitive plant, is known for its rapid plant movement. Its leaves fold inward and droop when touched.",
    medicinalUses: [
      "Treats bleeding piles",
      "Helps in wound healing",
      "Reduces joint pain (Arthritis)",
      "Controls diabetes",
    ],
    goodSides: [
      "Excellent natural remedy for cuts and wounds",
      "Has antibacterial properties",
    ],
    badSides: [
      "Overconsumption can be toxic",
      "Should be avoided by pregnant women",
    ],
    scientificName: "Mimosa pudica",
    family: "Fabaceae",
    region: "South and Central America",
  ),
  "Neem": PlantData(
    description:
        "Neem is a fast-growing tree known for its medicinal properties. Every part of the tree is used in traditional medicine for its antibacterial and antifungal properties.",
    medicinalUses: [
      "Treats skin infections and acne",
      "Boosts oral health",
      "Acts as a natural insect repellent",
      "Supports liver function",
    ],
    goodSides: [
      "Powerful antibacterial and antifungal properties",
      "All parts of the tree are useful",
    ],
    badSides: [
      "Can cause kidney damage in high doses",
      "Not safe for children in large amounts",
    ],
    scientificName: "Azadirachta indica",
    family: "Meliaceae",
    region: "Indian Subcontinent",
  ),
  "Aloe Vera": PlantData(
    description:
        "Aloe Vera is a succulent plant species widely used in cosmetics and traditional medicine. Its gel is known for soothing skin conditions and aiding digestion.",
    medicinalUses: [
      "Soothes sunburns and skin irritations",
      "Promotes wound healing",
      "Aids digestion and reduces constipation",
      "Moisturizes skin and hair",
    ],
    goodSides: ["Very safe for topical use", "Can be grown easily at home"],
    badSides: [
      "Oral consumption can cause cramping",
      "Latex from the leaf skin can be toxic",
    ],
    scientificName: "Aloe barbadensis miller",
    family: "Asphodelaceae",
    region: "Arabian Peninsula",
  ),
  "Pudina": PlantData(
    description:
        "Mint is a fragrant herb from the Mentha genus. It is widely used in culinary dishes, teas, and for its medicinal properties to aid digestion.",
    medicinalUses: [
      "Relieves indigestion and bloating",
      "Reduces nausea and headaches",
      "Freshens breath",
      "Clears nasal congestion",
    ],
    goodSides: [
      "Easy to grow and widely available",
      "Safe for regular consumption",
    ],
    badSides: [
      "Can worsen acid reflux in some people",
      "May interfere with certain medications",
    ],
    scientificName: "Mentha piperita",
    family: "Lamiaceae",
    region: "Europe and Middle East",
  ),
  "Ashwagandha": PlantData(
    description:
        "Ashwagandha is an adaptogenic herb used in Ayurveda for centuries. It helps the body manage stress and promotes overall vitality and well-being.",
    medicinalUses: [
      "Reduces stress and anxiety",
      "Boosts energy and stamina",
      "Improves brain function and memory",
      "Supports thyroid health",
    ],
    goodSides: [
      "Well-researched adaptogenic benefits",
      "Can be taken as powder or supplement",
    ],
    badSides: [
      "May cause thyroid hormone imbalance",
      "Not recommended during pregnancy",
    ],
    scientificName: "Withania somnifera",
    family: "Solanaceae",
    region: "India and North Africa",
  ),
  "Moringa": PlantData(
    description:
        "Moringa is a nutrient-rich tree often called the 'drumstick tree'. Its leaves, pods, and seeds are packed with vitamins, minerals, and antioxidants.",
    medicinalUses: [
      "Rich source of iron and vitamins",
      "Helps control blood sugar",
      "Reduces inflammation",
      "Supports heart health",
    ],
    goodSides: [
      "Extremely nutrient-dense superfood",
      "All parts of the tree are edible",
    ],
    badSides: [
      "May have laxative effects in large doses",
      "Can interfere with thyroid medication",
    ],
    scientificName: "Moringa oleifera",
    family: "Moringaceae",
    region: "Indian Subcontinent",
  ),
  "Akanda": PlantData(
    description:
        "Akanda, also known as Crown Flower or Calotropis gigantea, is a large shrub with medicinal uses in traditional systems. Its latex and flowers are used for various treatments.",
    medicinalUses: [
      "Treats skin diseases and wounds",
      "Relieves joint pain",
      "Used as an anti-inflammatory",
      "Helps with respiratory issues",
    ],
    goodSides: [
      "Powerful anti-inflammatory properties",
      "Easily available in tropical regions",
    ],
    badSides: [
      "Latex is toxic if consumed internally",
      "Can cause skin irritation in some people",
    ],
    scientificName: "Calotropis gigantea",
    family: "Apocynaceae",
    region: "South and Southeast Asia",
  ),
  "Arjun": PlantData(
    description:
        "Arjun (Terminalia arjuna) is a large deciduous tree known for its cardiovascular benefits. Its bark has been used in Ayurveda for heart conditions.",
    medicinalUses: [
      "Strengthens heart muscles",
      "Helps manage cholesterol",
      "Reduces blood pressure",
      "Promotes bone health",
    ],
    goodSides: ["Well-known heart tonic in Ayurveda", "Rich in antioxidants"],
    badSides: [
      "May lower blood pressure too much",
      "Not recommended during pregnancy",
    ],
    scientificName: "Terminalia arjuna",
    family: "Combretaceae",
    region: "Indian Subcontinent",
  ),
  "Ashoka": PlantData(
    description:
        "Ashoka (Saraca asoca) is a sacred tree in Hindu culture, known for its medicinal use in female reproductive health. Its bark is widely used in Ayurveda.",
    medicinalUses: [
      "Treats menstrual disorders",
      "Reduces uterine pain",
      "Helps with heavy bleeding",
      "Acts as a blood purifier",
    ],
    goodSides: [
      "Excellent for women's reproductive health",
      "Has mild sedative properties",
    ],
    badSides: ["May cause constipation", "Should be taken under guidance"],
    scientificName: "Saraca asoca",
    family: "Fabaceae",
    region: "Indian Subcontinent",
  ),
  "Aparajita": PlantData(
    description:
        "Aparajita (Clitoria ternatea), also known as Butterfly Pea, is a climbing plant with vibrant blue flowers. It is used in traditional medicine and as a natural food coloring.",
    medicinalUses: [
      "Enhances memory and brain function",
      "Reduces stress and anxiety",
      "Promotes hair growth",
      "Acts as an antioxidant",
    ],
    goodSides: [
      "Natural blue food coloring",
      "Safe for regular consumption as tea",
    ],
    badSides: [
      "May cause nausea in large amounts",
      "Can interfere with diabetes medication",
    ],
    scientificName: "Clitoria ternatea",
    family: "Fabaceae",
    region: "Southeast Asia",
  ),
  "Kalojira": PlantData(
    description:
        "Kalojira (Nigella sativa), also known as Black Cumin or Black Seed, is a flowering plant whose seeds are used as a spice and in traditional medicine for various ailments.",
    medicinalUses: [
      "Boosts immune system",
      "Helps with asthma and allergies",
      "Supports digestive health",
      "Promotes healthy skin and hair",
    ],
    goodSides: [
      "Powerful anti-inflammatory properties",
      "Can be used as a spice in cooking",
    ],
    badSides: [
      "May lower blood pressure excessively",
      "Can interact with blood thinning medications",
    ],
    scientificName: "Nigella sativa",
    family: "Ranunculaceae",
    region: "South and Southwest Asia",
  ),
  "Thankuni": PlantData(
    description:
        "Thankuni (Centella asiatica), also known as Gotu Kola or Indian Pennywort, is a small herbaceous plant used in traditional medicine for wound healing and brain health.",
    medicinalUses: [
      "Improves memory and cognition",
      "Promotes wound healing",
      "Reduces anxiety and stress",
      "Treats skin conditions",
    ],
    goodSides: ["Excellent for skin health", "Beneficial for brain function"],
    badSides: ["Can cause liver issues in high doses", "May cause drowsiness"],
    scientificName: "Centella asiatica",
    family: "Apiaceae",
    region: "Asia and Africa",
  ),
  "Pathorkuchi": PlantData(
    description:
        "Pathorkuchi (Bryophyllum pinnatum), also known as Leaf of Life or Air Plant, is a succulent plant known for its ability to grow from leaf margins. It is widely used in traditional medicine.",
    medicinalUses: [
      "Treats kidney stones",
      "Helps with respiratory issues",
      "Reduces inflammation",
      "Promotes wound healing",
    ],
    goodSides: ["Easy to propagate and grow", "Quick relief for kidney stones"],
    badSides: [
      "Can be toxic in very high doses",
      "Not recommended during pregnancy",
    ],
    scientificName: "Bryophyllum pinnatum",
    family: "Crassulaceae",
    region: "Madagascar and Tropical Africa",
  ),
  "Raktakarabi": PlantData(
    description:
        "Raktakarabi is a medicinal plant known for its blood-purifying properties. It is used in traditional medicine systems for various skin and blood disorders.",
    medicinalUses: [
      "Purifies blood",
      "Treats skin infections",
      "Helps with menstrual disorders",
      "Reduces inflammation",
    ],
    goodSides: ["Natural blood purifier", "Effective for skin conditions"],
    badSides: ["May cause digestive upset", "Should be used in moderation"],
    scientificName: "Rhododendron arboreum",
    family: "Ericaceae",
    region: "Himalayan region",
  ),
  "Hibiscus": PlantData(
    description:
        "Hibiscus is a flowering plant known for its large, colorful blooms. The flowers are used in herbal teas and traditional medicine for various health benefits.",
    medicinalUses: [
      "Helps lower blood pressure",
      "Supports liver health",
      "Rich in vitamin C",
      "Promotes hair growth",
    ],
    goodSides: [
      "Delicious as a refreshing tea",
      "Ornamental and medicinal value",
    ],
    badSides: [
      "May lower blood pressure too much",
      "Can interact with hypertension medication",
    ],
    scientificName: "Hibiscus rosa-sinensis",
    family: "Malvaceae",
    region: "East Asia",
  ),
  "Curry Leaf": PlantData(
    description:
        "Curry Leaf is a staple herb in Indian cooking, known for its aromatic flavor and numerous health benefits. The leaves are rich in antioxidants and essential nutrients.",
    medicinalUses: [
      "Aids digestion",
      "Controls diabetes",
      "Promotes hair growth",
      "Rich in iron and calcium",
    ],
    goodSides: [
      "Essential for authentic Indian cuisine",
      "Can be grown at home easily",
    ],
    badSides: [
      "May cause stomach upset in large amounts",
      "Not recommended for people with kidney stones",
    ],
    scientificName: "Murraya koenigii",
    family: "Rutaceae",
    region: "Indian Subcontinent",
  ),
  "Aishtha Nageni": PlantData(
    description:
        "Aishtha Nageni is a medicinal plant used in traditional healing practices. It is known for its therapeutic properties in treating various ailments.",
    medicinalUses: [
      "Helps with digestive issues",
      "Supports respiratory health",
      "Reduces body pain",
      "Acts as a natural tonic",
    ],
    goodSides: [
      "Natural remedy for common ailments",
      "Easily available in local areas",
    ],
    badSides: [
      "Limited scientific research available",
      "Should be used under expert guidance",
    ],
    scientificName: "To be identified",
    family: "To be identified",
    region: "South Asia",
  ),
  "Bideshi Lata": PlantData(
    description:
        "Bideshi Lata is a climbing plant known for its medicinal properties. It is used in traditional medicine for various health conditions.",
    medicinalUses: [
      "Treats skin infections",
      "Helps with joint pain",
      "Supports immune system",
      "Acts as an anti-inflammatory",
    ],
    goodSides: [
      "Natural anti-inflammatory properties",
      "Used in folk medicine for generations",
    ],
    badSides: [
      "Limited scientific studies",
      "May cause allergic reactions in some",
    ],
    scientificName: "Mikania micrantha",
    family: "Asteraceae",
    region: "South and Southeast Asia",
  ),
  "Devils Backbone": PlantData(
    description:
        "Devil's Backbone (Euphorbia tithymaloides) is a succulent plant with zigzag stems. It is used in traditional medicine for its anti-inflammatory and wound-healing properties.",
    medicinalUses: [
      "Treats skin warts and infections",
      "Reduces inflammation",
      "Helps with oral health",
      "Promotes wound healing",
    ],
    goodSides: ["Easy to grow as a houseplant", "Quick relief for skin issues"],
    badSides: ["Sap is toxic if consumed", "Can cause skin irritation"],
    scientificName: "Euphorbia tithymaloides",
    family: "Euphorbiaceae",
    region: "Tropical Americas",
  ),
  "Dipto luchi": PlantData(
    description:
        "Dipto Luchi is a medicinal plant used in traditional healing. It is known for its beneficial properties in treating various common ailments naturally.",
    medicinalUses: [
      "Supports digestive health",
      "Helps with skin conditions",
      "Boosts immunity",
      "Reduces stress",
    ],
    goodSides: ["Gentle and natural remedy", "Used in traditional medicine"],
    badSides: ["More research needed on efficacy", "Consult expert before use"],
    scientificName: "Peperomia pellucida",
    family: "Piperaceae",
    region: "South Asia",
  ),
  "Kumari Lata": PlantData(
    description:
        "Kumari Lata is a medicinal climbing plant known for its health benefits. It is used in traditional medicine systems for various therapeutic purposes.",
    medicinalUses: [
      "Promotes skin health",
      "Helps with digestive issues",
      "Boosts energy levels",
      "Supports immune function",
    ],
    goodSides: [
      "Natural health supplement",
      "Traditional remedy with proven benefits",
    ],
    badSides: ["Limited availability", "Consult before regular use"],
    scientificName: "Smilax zeylanica L",
    family: "Smilacaceae",
    region: "South Asia",
  ),
  "Nageshwar": PlantData(
    description:
        "Nageshwar (Mesua ferrea), also known as Ironwood or Ceylon Ironwood, is a tree with fragrant flowers. It is valued in traditional medicine and perfumery.",
    medicinalUses: [
      "Treats skin conditions",
      "Helps with respiratory issues",
      "Reduces joint pain",
      "Acts as a natural astringent",
    ],
    goodSides: [
      "Fragrant flowers used in perfumes",
      "Hardwood is valuable for construction",
    ],
    badSides: [
      "May cause skin sensitivity",
      "Limited medicinal research available",
    ],
    scientificName: "Mesua ferrea",
    family: "Calophyllaceae",
    region: "South and Southeast Asia",
  ),
  "Nayan Tara": PlantData(
    description:
        "Nayan Tara is a medicinal plant traditionally used for eye health and overall wellness. It is valued in folk medicine for its therapeutic properties.",
    medicinalUses: [
      "Supports eye health",
      "Reduces eye strain",
      "Helps with headaches",
      "Acts as a cooling agent",
    ],
    goodSides: ["Beneficial for eye care", "Natural cooling properties"],
    badSides: [
      "Limited scientific validation",
      "Use under professional guidance",
    ],
    scientificName: "Catharanthus roseus",
    family: "Apocynaceae",
    region: "South Asia",
  ),
};

final Map<String, String> plantNameAliases = {
  'Sojne-Moringa': 'Moringa',
  'Lojjaboti': 'Lajjabati',
  'Roktokorobi': 'Raktakarabi',
  'Kori Pata': 'Curry Leaf',
  'Kumari Lota': 'Kumari Lata',
  'Anshte Lota': 'Aishtha Nageni',
  "Devil's Backbone": 'Devils Backbone',
  'Dipto Luchi': 'Dipto luchi',
  'Mint': 'Pudina',
  'Alovera': 'Aloe Vera',
};


PlantData? getPlantByName(String? name) {
  if (name == null) return null;
  final key = plantNameAliases[name] ?? name;
  return plantDatabase[key];
}
