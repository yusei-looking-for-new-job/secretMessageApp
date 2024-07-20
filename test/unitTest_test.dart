import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:stego_app/DataStore/dataStore.dart';
import 'package:stego_app/Model/ImageModel.dart';
import 'package:stego_app/Repository/imageRepository.dart';
import 'package:stego_app/ViewModel/homePageViewModel.dart';

import 'package:http/http.dart' as http;

//テスト用のモッククラス
class FakeApiService implements ApiDataStore {
  @override
  Future<Uint8List?> embedString(Uint8List imageBytes, String string) async {
    return Uint8List.fromList([1, 2, 3]);
  }

  @override
  Future<String?> extractString(Uint8List imageBytes) async {
    return 'test';
  }
}

class MockMultipartRequestFactory implements MultipartRequestFactory {
  @override
  Future<http.StreamedResponse> createEmbedRequest(
      Uri url, Uint8List imageBytes, String string) async {
    // テスト用のモックレスポンスを作成
    final mockResponseBytes = Uint8List.fromList([4, 5, 6]);
    final mockResponse = http.StreamedResponse(
      Stream.value(mockResponseBytes),
      200,
      contentLength: mockResponseBytes.length,
    );
    return mockResponse;
  }

  @override
  Future<http.StreamedResponse> createExtractRequest(
      Uri url, Uint8List imageBytes) async {
    final responseBody = '{"extracted_string": "test extracted"}';
    final mockResponse =
        http.StreamedResponse(Stream.value(responseBody.codeUnits), 200);

    return mockResponse;
  }
}

class ErrorMockMultipartRequestFactory implements MultipartRequestFactory {
  @override
  Future<http.StreamedResponse> createEmbedRequest(
      Uri url, Uint8List imageBytes, String string) async {
    // テスト用のモックレスポンスを作成
    final mockResponseBytes = Uint8List.fromList([4, 5, 6]);
    final mockResponse = http.StreamedResponse(
      Stream.value(mockResponseBytes),
      401,
    );
    return mockResponse;
  }

  @override
  Future<http.StreamedResponse> createExtractRequest(
      Uri url, Uint8List imageBytes) async {
    final responseBody = '{"extracted_string": ""}';
    final mockResponse =
        http.StreamedResponse(Stream.value(responseBody.codeUnits), 401);

    return mockResponse;
  }
}

class TimeOutMockMultipartRequestFactory implements MultipartRequestFactory {
  @override
  Future<http.StreamedResponse> createEmbedRequest(
      Uri url, Uint8List imageBytes, String string) async {
    // テスト用のモックレスポンスを作成
    return Future.error(TimeoutException('Request timed out'));
  }

  @override
  Future<http.StreamedResponse> createExtractRequest(
      Uri url, Uint8List imageBytes) async {
    return Future.error(TimeoutException('Request timed out'));
  }
}

void main() {
  group('SelectImageNotifier', () {
    test('ut-1初期状態確認', () {
      final container = ProviderContainer();
      final selectImageNotifier =
          container.read(selectImageNotifireProvider.notifier);
      expect(selectImageNotifier.state.selectImageBytes, null);
    });

    test('ut-2画像選択', () {
      final container = ProviderContainer();
      final selectImageNotifier =
          container.read(selectImageNotifireProvider.notifier);
      final imageBytes = Uint8List.fromList([1, 2, 3, 54]);
      selectImageNotifier.selectImage(imageBytes);
      expect(selectImageNotifier.state.selectImageBytes, imageBytes);
    });

    test('ut-3画像クリア', () {
      final container = ProviderContainer();
      final selectImageNotifier =
          container.read(selectImageNotifireProvider.notifier);
      selectImageNotifier.clearImage();
      expect(selectImageNotifier.state.selectImageBytes, null);
    });
  });

  group('EmbImageNotifier', () {
    test('ut-4初期状態確認', () {
      final container = ProviderContainer();
      final embImageNotifier =
          container.read(embImageNotifireProvider.notifier);
      expect(embImageNotifier.state.embImageBytes, null);
    });

    test('ut-5文字列埋め込み成功', () async {
      final container = ProviderContainer(overrides: [
        apiServiceProvider.overrideWithValue(FakeApiService()),
      ]);
      final embImageNotifier =
          container.read(embImageNotifireProvider.notifier);
      final selectImageModel =
          SelectImageModel(selectImageBytes: Uint8List.fromList([1, 2, 3]));
      final result =
          await embImageNotifier.embedString('test', selectImageModel);
      expect(result, true);
      expect(embImageNotifier.state.embImageBytes, isNotNull);
    });

    test('ut-6文字列埋め込み失敗', () async {
      final container = ProviderContainer(overrides: [
        apiServiceProvider.overrideWithValue(FakeApiService()),
      ]);
      final embImageNotifier =
          container.read(embImageNotifireProvider.notifier);
      final selectImageModel = SelectImageModel();
      final result =
          await embImageNotifier.embedString('test', selectImageModel);
      expect(result, false);
    });
  });

  group('ExtStringNotifier', () {
    test('ut-7初期状態確認', () {
      final container = ProviderContainer();
      final extStringNotifier =
          container.read(extStringNotifireProvider.notifier);
      expect(extStringNotifier.state.extString, null);
    });

    test('ut-8文字列抽出成功', () async {
      final container = ProviderContainer(overrides: [
        apiServiceProvider.overrideWithValue(FakeApiService()),
      ]);
      final extStringNotifier =
          container.read(extStringNotifireProvider.notifier);
      final selectImageModel =
          SelectImageModel(selectImageBytes: Uint8List.fromList([1, 2, 3]));
      final result = await extStringNotifier.extractString(selectImageModel);
      expect(result, true);
      expect(extStringNotifier.state.extString, isNotEmpty);
    });

    test('ut-9文字列抽出失敗', () async {
      final container = ProviderContainer(overrides: [
        apiServiceProvider.overrideWithValue(FakeApiService()),
      ]);
      final extStringNotifier =
          container.read(extStringNotifireProvider.notifier);
      final selectImageModel = SelectImageModel();
      final result = await extStringNotifier.extractString(selectImageModel);
      expect(result, false);
    });
  });

  group('LoadingNotifier', () {
    test('ut-10初期状態確認', () {
      final container = ProviderContainer();
      final loadingNotifier = container.read(loadingNotifireProvider.notifier);
      expect(loadingNotifier.state, false);
    });

    test('ut-11ローディング表示', () {
      final container = ProviderContainer();
      final loadingNotifier = container.read(loadingNotifireProvider.notifier);
      loadingNotifier.show();
      expect(loadingNotifier.state, true);
    });

    test('ut-12ローディング非表示', () {
      final container = ProviderContainer();
      final loadingNotifier = container.read(loadingNotifireProvider.notifier);
      loadingNotifier.hide();
      expect(loadingNotifier.state, false);
    });
  });

  group('ImpApiService', () {
    test('ut-17文字列埋め込み成功', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(MockMultipartRequestFactory()),
      ]);
      final embStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await embStringNotifier.embedString(selectImage, 'test');

      expect(result, [4, 5, 6]);
    });

    test('ut-18文字列埋め込み失敗', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(ErrorMockMultipartRequestFactory()),
      ]);
      final embStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await embStringNotifier.embedString(selectImage, 'test');

      expect(result, null);
    });

    test('ut-19文字列抽出成功', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(MockMultipartRequestFactory()),
      ]);
      final extStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await extStringNotifier.extractString(selectImage);

      expect(result, 'test extracted');
    });
    //
    test('ut-20文字列抽出失敗', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(ErrorMockMultipartRequestFactory()),
      ]);
      final extStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await extStringNotifier.extractString(selectImage);

      expect(result, null);
    });

    test('ut-21埋め込みタイムアウト', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(TimeOutMockMultipartRequestFactory()),
      ]);
      final embStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await embStringNotifier.embedString(selectImage, 'test');

      expect(result, null);
    });

    test('ut-22抽出タイムアウト', () async {
      final container = ProviderContainer(overrides: [
        //apiServiceProvider.overrideWithValue(FakeApiService()),
        multipartRequestFactoryProvider
            .overrideWithValue(TimeOutMockMultipartRequestFactory()),
      ]);
      final extStringNotifier = container.read(imageRepositoryProvider);

      final Uint8List selectImage = Uint8List.fromList([1, 2, 3]);

      final result = await extStringNotifier.extractString(selectImage);

      expect(result, null);
    });
  });
}
