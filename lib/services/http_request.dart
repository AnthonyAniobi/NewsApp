import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:hackernews/models/app_errors.dart';
import 'package:http/http.dart' as http;

class HttpRequests {
  static const String baseUrl = "https://hacker-news.firebaseio.com/v0";
  static final _client = http.Client();
  static Future<Either<Error, dynamic>> get(String url) async {
    try {
      Uri uri = Uri.parse("$baseUrl/$url");
      var response = await _client.get(uri);
      if (response.statusCode != 200) {
        return Left(AppError(response.statusCode, response.body));
      }
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      // _client.close();
      return Right(decodedResponse);
    } on SocketException catch (e) {
      return Left(AppError(0, "Network error: ${e.message}"));
    } catch (e) {
      return Left(AppError(1, "Error: ${e.toString()}"));
    } finally {
      // _client.close();
    }
  }

  static shutdownClient() {
    _client.close();
  }
}
