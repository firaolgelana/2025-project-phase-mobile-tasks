import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClientHelper {
  final http.Client client;

  ApiClientHelper(this.client);

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };

  Future<http.Response> get(String url) {
    return client.get(Uri.parse(url), headers: _headers);
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) {
    return client.post(
      Uri.parse(url),
      headers: _headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) {
    return client.put(
      Uri.parse(url),
      headers: _headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> delete(String url) {
    return client.delete(Uri.parse(url), headers: _headers);
  }
}
