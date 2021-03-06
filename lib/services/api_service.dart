import 'dart:async';
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

/// Service interacting with API
class APIService {
  final String url;

  /// Constructor
  APIService() : url = GlobalConfiguration().getValue('API_URL');

  /// Send a GET request on the given entry point
  Future<dynamic> get(String entryPoint) async {
    return extractData(await http.get(Uri.parse(url + entryPoint)));
  }

  /// Send a POST request on the given entry point with the payload
  Future<dynamic> post(String entryPoint, Object? payload) async {
    return extractData(await http.post(Uri.parse(url + entryPoint),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'}));
  }

  /// Extract data from the given HTTP response
  dynamic extractData(http.Response response) {
    var body = jsonDecode(response.body);

    // Check status code
    if (response.statusCode != 200) {
      throw Exception(body['error']);
    }
    return body['data'];
  }
}
