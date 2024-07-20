import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '../Model/ImageModel.dart';
import '../Repository/imageRepository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'homePageViewModel.g.dart';

//画像選択
@riverpod
class SelectImageNotifire extends _$SelectImageNotifire {
  @override
  SelectImageModel build() {
    return SelectImageModel();
  }

  selectImage(Uint8List selectImage) {
    state = state.copyWith(selectImageBytes: selectImage);
  }

  clearImage() {
    state = state.copyWith(selectImageBytes: null);
  }
}

//埋め込み
@riverpod
class EmbImageNotifire extends _$EmbImageNotifire {
  @override
  EmbImageModel build() {
    return EmbImageModel();
  }

  Future<bool> embedString(String string, SelectImageModel selectImage) async {
    final repository = ref.read(imageRepositoryProvider);
    try {
      var encodedImageBytes =
          await repository.embedString(selectImage.selectImageBytes!, string);
      if (encodedImageBytes != null) {
        state = state.copyWith(embImageBytes: encodedImageBytes);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

//文字抽出
@riverpod
class ExtStringNotifire extends _$ExtStringNotifire {
  @override
  ExtStringModel build() {
    return ExtStringModel();
  }

  Future<bool> extractString(SelectImageModel selectImage) async {
    final repository = ref.read(imageRepositoryProvider);
    try {
      var extractedString =
          await repository.extractString(selectImage.selectImageBytes!);
      if (extractedString != null) {
        state = state.copyWith(extString: extractedString);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

//ローディングのステート
@riverpod
class LoadingNotifire extends _$LoadingNotifire {
  @override
  bool build() {
    return false;
  }

  /// ローディングを表示する
  void show() => state = true;

  /// ローディングを非表示にする
  void hide() => state = false;
}
