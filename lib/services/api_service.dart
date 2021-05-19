import 'dart:async';
import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

/// Service interacting with API
class APIService {
  final String _url;

  /// Constructor
  APIService() : _url = GlobalConfiguration().getValue('API_URL');

  /// Send a GET request on the given entry point
  Future<dynamic> get(String entryPoint) async {
    final response = await http.get(Uri.parse(_url + entryPoint));

    // Decode body
    var body = jsonDecode(response.body);

    // Check status code
    if (response.statusCode != 200) {
      throw Exception(body['error']);
    }
    return body['data'];
  }
}
