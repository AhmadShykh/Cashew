import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import 'wallet_accent_storage_stub.dart'
    if (dart.library.io) 'wallet_accent_storage_io.dart' as impl;

Future<String?> copyPickedWalletAccentImage(XFile picked) =>
    impl.copyPickedWalletAccentImage(picked);

Future<void> deleteWalletAccentStoredFile(String? fileName) =>
    impl.deleteWalletAccentStoredFile(fileName);

Future<Uint8List?> loadWalletAccentImageBytes(String? fileName) =>
    impl.loadWalletAccentImageBytes(fileName);
