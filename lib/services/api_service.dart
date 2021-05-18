import 'dart:async';
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

/// Service interacting with API
/// Service interacting with API
class APIService {
  final String _url;

  /// Constructor
  APIService() : _url = GlobalConfiguration().getValue('API_URL');

  /// Send a GET request on the given entry point
  Future<dynamic> get(String entryPoint) async {
    return transformResponse(await http.get(Uri.parse(_url + entryPoint)));
  }

  // TODO: Doc
  Future<dynamic> post(String entryPoint, Object? object) async {
    return transformResponse(await http.post(Uri.parse(_url + entryPoint),
        body: jsonEncode(object)));
  }

  // TODO: Doc
  dynamic transformResponse(http.Response response) {
    if (response.headers['Content-Type'] == null ||
        !response.headers['Content-Type']!.contains('application/json')) {
      throw Exception('API response isn\'t a JSON object');
    }
    var body = jsonDecode(response.body);

    // Check status code
    if (response.statusCode != 200) {
      throw Exception(body.error);
    }
    return body.data;
  }
}