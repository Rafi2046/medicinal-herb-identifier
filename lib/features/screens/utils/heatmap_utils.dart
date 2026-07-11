import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;

Future<File> compositeHeatmap({
  required File originalImage,
  required String heatmapBase64,
  required String outputPath,
  double opacity = 0.6,
}) async {
  final originalBytes = await originalImage.readAsBytes();
  final original = img.decodeImage(originalBytes);
  if (original == null) throw Exception('Failed to decode original image');

  final heatmapBytes = base64Decode(heatmapBase64);
  var heatmap = img.decodeImage(heatmapBytes);
  if (heatmap == null) throw Exception('Failed to decode heatmap');

  if (heatmap.width != original.width || heatmap.height != original.height) {
    heatmap = img.copyResize(heatmap,
        width: original.width, height: original.height);
  }

  img.compositeImage(original, heatmap);

  final output = File(outputPath);
  await output.writeAsBytes(img.encodeJpg(original, quality: 95));
  return output;
}
