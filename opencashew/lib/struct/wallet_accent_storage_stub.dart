import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<String?> saveWalletAccentImageBytes(
  Uint8List bytes, {
  String extension = '.jpg',
}) async =>
    null;

Future<Uint8List> readPickedImageBytes(XFile picked) => picked.readAsBytes();

Future<String?> copyPickedWalletAccentImage(XFile picked) async => null;

Future<void> deleteWalletAccentStoredFile(String? fileName) async {}

Future<Uint8List?> loadWalletAccentImageBytes(String? fileName) async =>
    null;
