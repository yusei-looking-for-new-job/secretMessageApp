import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stego_app/View/homePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'DataStore/dataStore.dart';
import 'Repository/imageRepository.dart';
import 'package:http/http.dart' as http;

///Mockクラスでoverrideすることでリクエストをモックできる
///単体テスト以外、UIテスト時など
//
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

void main() {
  runApp(
    ProviderScope(
      ///動作確認・テスト時にオーバライド
      // overrides: [
      //   multipartRequestFactoryProvider
      //       .overrideWithValue(MockMultipartRequestFactory()),
      // ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //多言語対応
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja', ''), //日本語
        const Locale('en', ''), //英語
      ],
      title: 'secret Message',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
