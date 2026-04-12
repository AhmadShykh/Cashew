import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

bool _isSafeBasename(String name) {
  if (name.isEmpty || name.length > 220) return false;
  if (name.contains('..') ||
      name.contains('/') ||
      name.contains('\\') ||
      name.startsWith('.')) {
    return false;
  }
  return true;
}

Future<Directory> _walletAccentDirectory() async {
  final support = await getApplicationSupportDirectory();
  final dir = Directory(p.join(support.path, 'wallet_accents'));
  if (!await dir.exists()) await dir.create(recursive: true);
  return dir;
}

String _extensionFromXFile(XFile file) {
  final name = file.name;
  final dot = name.lastIndexOf('.');
  if (dot <= 0 || dot >= name.length - 1) return '.jpg';
  return name.substring(dot).toLowerCase();
}

Future<String?> copyPickedWalletAccentImage(XFile picked) async {
  final bytes = await picked.readAsBytes();
  final dir = await _walletAccentDirectory();
  final name = '${_uuid.v4()}${_extensionFromXFile(picked)}';
  if (!_isSafeBasename(name)) return null;
  final out = File(p.join(dir.path, name));
  await out.writeAsBytes(bytes, flush: true);
  return name;
}

Future<void> deleteWalletAccentStoredFile(String? fileName) async {
  if (fileName == null || !_isSafeBasename(fileName)) return;
  final dir = await _walletAccentDirectory();
  final f = File(p.join(dir.path, fileName));
  if (await f.exists()) await f.delete();
}

Future<Uint8List?> loadWalletAccentImageBytes(String? fileName) async {
  if (fileName == null || !_isSafeBasename(fileName)) return null;
  final dir = await _walletAccentDirectory();
  final f = File(p.join(dir.path, fileName));
  if (!await f.exists()) return null;
  return f.readAsBytes();
}
