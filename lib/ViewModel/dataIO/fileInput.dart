import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:collection/collection.dart';

bool _isImageHeader(Uint8List bytes) {
  // 一般的な画像フォーマットのマジックナンバーをチェック
  const jpegHeader = [0xFF, 0xD8, 0xFF];
  const pngHeader = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A];
  const gifHeader = [0x47, 0x49, 0x46, 0x38];

  if (bytes.length < 12) return false;

  if (bytes.take(3).toList().equals(jpegHeader)) return true;
  if (bytes.take(8).toList().equals(pngHeader)) return true;
  if (bytes.take(4).toList().equals(gifHeader)) return true;

  // HEIC/HEIF ファイルのチェック
  // 'ftyp' シグネチャを探す（通常、ファイルの先頭から4バイト目以降に現れる）
  //format-hex "C:\Users\DELL\Desktop\coution.heic"コマンドで確認できる
  for (int i = 4; i < bytes.length - 3; i++) {
    if (bytes[i] == 0x66 &&
        bytes[i + 1] == 0x74 &&
        bytes[i + 2] == 0x79 &&
        bytes[i + 3] == 0x70) {
      return true;
    }
  }

  return false;
}

Future<Uint8List?> selectFromGalleryImage() async {
  final imagePicker = ImagePicker();
  try {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? mimeType = lookupMimeType(pickedFile.path);
      String? extension = pickedFile.name.split('.').last.toLowerCase();

      // MIMEタイプとファイル名の拡張子をチェック
      //ブラウザによってこっちの処理は機能しない
      if (mimeType == null || !mimeType.startsWith('image/')) {
        if (!['jpg', 'jpeg', 'png', 'gif', 'bmp', 'heic', 'heif']
            .contains(extension)) {
          return null;
        }
      }
      Uint8List imageBytes = await pickedFile.readAsBytes();
      //ファイルのマジックナンバーを確認してはじく
      if (imageBytes.length > 11 && !_isImageHeader(imageBytes)) {
        return null;
      }

      return imageBytes;
    } else {
      // ユーザーが選択をキャンセルした場合
      return null;
    }
  } catch (e) {
    return null;
  }
}
