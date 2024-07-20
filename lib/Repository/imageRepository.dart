import 'dart:typed_data';

import '../DataStore/dataStore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//テスト時にmultipartRequestFactoryProviderをoverrideしてhttp通信をモック化する
final multipartRequestFactoryProvider = Provider<MultipartRequestFactory>(
  (ref) {
    return ImpMultipartRequestFactory();
  },
);

final apiServiceProvider = Provider<ApiDataStore>(
  (ref) {
    final requestFactory = ref.watch(multipartRequestFactoryProvider);
    return ImpApiDataStore(requestFactory);
  },
);

final imageRepositoryProvider = Provider<ImageRepository>(
  (ref) {
    final apiService = ref.watch(apiServiceProvider);
    return ImageRepository(apiService: apiService);
  },
);

class ImageRepository {
  ImageRepository({required this.apiService});

  final ApiDataStore apiService;

  Future<Uint8List?> embedString(Uint8List imageBytes, String string) async {
    return await apiService.embedString(imageBytes, string);
  }

  Future<String?> extractString(Uint8List imageBytes) async {
    return await apiService.extractString(imageBytes);
  }
}
