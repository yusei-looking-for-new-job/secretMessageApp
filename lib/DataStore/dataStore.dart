import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//抽象クラス
abstract class ApiDataStore {
  Future<Uint8List?> embedString(Uint8List imageBytes, String string);
  Future<String?> extractString(Uint8List imageBytes);
}

abstract class MultipartRequestFactory {
  Future<StreamedResponse> createEmbedRequest(
      Uri url, Uint8List imageBytes, String string);
  Future<StreamedResponse> createExtractRequest(Uri url, Uint8List imageBytes);
}

//実装
class ImpApiDataStore implements ApiDataStore {
  final String _baseUrl = 'https://www.secret-message.site';

  //http.MultipartRequestを直接使わずに
  final MultipartRequestFactory _requestFactory;
  ImpApiDataStore(this._requestFactory);

  @override
  Future<Uint8List?> embedString(Uint8List imageBytes, String string) async {
    try {
      var url = Uri.parse('$_baseUrl/embed');
      var response =
          await _requestFactory.createEmbedRequest(url, imageBytes, string);
      //var response = await request.send().timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        return await response.stream.toBytes();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> extractString(Uint8List imageBytes) async {
    try {
      var url = Uri.parse('$_baseUrl/extract');
      var response =
          await _requestFactory.createExtractRequest(url, imageBytes);
      //var response = await request.send().timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);
        return jsonResponse['extracted_string'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class ImpMultipartRequestFactory implements MultipartRequestFactory {
  @override
  Future<StreamedResponse> createEmbedRequest(
      Uri url, Uint8List imageBytes, String string) {
    var request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile.fromBytes('image', imageBytes,
        filename: 'image.jpg'));
    request.fields['string'] = string;
    return request.send().timeout(Duration(seconds: 60));
  }

  @override
  Future<StreamedResponse> createExtractRequest(Uri url, Uint8List imageBytes) {
    var request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile.fromBytes('image', imageBytes,
        filename: 'image.png'));
    return request.send().timeout(Duration(seconds: 60));
  }
}
