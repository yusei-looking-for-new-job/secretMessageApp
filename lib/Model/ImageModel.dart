import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'ImageModel.freezed.dart';

@freezed
class SelectImageModel with _$SelectImageModel {
  const factory SelectImageModel({
    Uint8List? selectImageBytes,
  }) = _SelectImageModel;
}

@freezed
class EmbImageModel with _$EmbImageModel {
  const factory EmbImageModel({
    Uint8List? embImageBytes,
  }) = _EmbImageModel;
}

@freezed
class ExtStringModel with _$ExtStringModel {
  const factory ExtStringModel({
    String? extString,
  }) = _ExtStringModel;
}
