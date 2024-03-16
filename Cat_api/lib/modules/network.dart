import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modules/cat.dart';
import '../modules/common.dart';
import './endPoint.dart';

class Network {
  static List<Breed> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Breed> breeds = list.map((model) => Breed.fromJson(model)).toList();
    return breeds;
  }

  static Future<List<Breed>> getCatImages(
      {int limit = 10, String? breed}) async {
    List<Breed> myListBreeds = [];
    final url = Uri.parse(
        "https://api.thecatapi.com/v1/images/search?limit=$limit&${breed != null ? 'breed=$breed' : ''}");
    final response =
        await http.get(url, headers: {"x-api-key": Common().apiKey});

    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else {
      debugPrint('Lỗi kết nối 2:');
      throw Exception("Can't get post");
    }
  }

  Future<dynamic> getListBreeds({
    Map<String, dynamic> params = const {},
  }) async {
    String content = '';
    List<Breed> myListBreeds = [];

    content = (params.keys
            .map((key) => '$key=${Uri.encodeQueryComponent(params[key])}'))
        .join('&');

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': utf8.encode(content).length.toString(),
      'x-api-key': Common().apiKey,
    };

    try {
      debugPrint('-> ${Common().baseUrl + EndPoints().breeds}?$content');
      await http
          .get(
        headers: headers,
        Uri.parse('${Common().baseUrl + EndPoints().breeds}?$content'),
      )
          .then((response) {
        if (response.statusCode == 200) {
          List jsonList =
              jsonDecode(response.body.replaceAll('\'', '')) as List;
          myListBreeds = jsonList
              .map((jsonElement) => Breed.fromJson(jsonElement))
              .toList();
        } else {
          myListBreeds = [];
          debugPrint('Loi ket noi:');
          debugPrint(response.statusCode.toString());
        }
      });
    } catch (e) {
      debugPrint('Loi ket noi:');
      debugPrint(e.toString());
      return [];
    }
  }

  Future<dynamic> getDetailCat({
    id = '',
  }) async {
    String content = '';
    CatBreedsImage? catDetail;

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': utf8.encode(content).length.toString(),
      'x-api-key': Common().apiKey,
    };

    try {
      debugPrint('-> ${Common().baseUrlDetail + id}?$content');
      await http
          .get(
        headers: headers,
        Uri.parse('${Common().baseUrlDetail + id}?$content'),
      )
          .then((response) {
        if (response.statusCode == 200) {
          var catDetailResponse = CatBreedsImage.fromJson(
              jsonDecode(response.body.replaceAll('\'', '')));
          catDetail = catDetailResponse;
        } else {
          catDetail = null;
          debugPrint('Lỗi kết nối:');
          debugPrint(response.statusCode.toString());
        }
      });
    } catch (e) {
      debugPrint('Lỗi kết nối:');
      debugPrint(e.toString());
      return null;
    }
    return catDetail;
  }
}
