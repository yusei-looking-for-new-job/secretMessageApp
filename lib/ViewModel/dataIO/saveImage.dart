import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;

Future<void> saveEncodedImage(Uint8List encodedImageBytes,BuildContext context) async {
  if (kIsWeb) {
    // Web platform
    // 現在の日時をファイル名として使用
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Blobを作成
    html.Blob imageBlob = html.Blob([encodedImageBytes]);

    // BlobからObjectURLを生成
    String imageUrl = html.Url.createObjectUrlFromBlob(imageBlob);

    // ローカルストレージに保存
    html.window.localStorage[fileName] = imageUrl;

    html.AnchorElement anchorElement =
    new html.AnchorElement(href: imageUrl);
    anchorElement.download = 'download.png';
    anchorElement.click();
  } else {
    // Mobile platform
    // 一時ディレクトリのパスを取得
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // 現在の日時をファイル名として使用
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // 画像を保存するためのファイルパスを作成
    String filePath = '$tempPath/$fileName.png';

    // 画像ファイルを書き込み
    File imageFile = File(filePath);
    await imageFile.writeAsBytes(encodedImageBytes);

    // ギャラリーに画像を保存
    final result = await GallerySaver.saveImage(imageFile.path);

    if (result != null) {
      //print('Encoded image saved to gallery');
    } else {
      //print('Failed to save encoded image to gallery');
    }

    // 一時ファイルを削除
    await imageFile.delete();
  }
}