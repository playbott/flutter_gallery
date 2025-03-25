import 'package:http/http.dart' as http;

Exception handleError(http.Response response) {
  switch (response.statusCode) {
    case 400:
      throw Exception('Bad Request: Invalid parameters');
    case 401:
      throw Exception('Unauthorized: Authentication required');
    case 403:
      throw Exception('Forbidden: Access denied');
    case 404:
      throw Exception('Not Found: endpoint unavailable');
    case 500:
      throw Exception('Server Error: Something went wrong on the server');
    default:
      throw Exception('Failed to load: HTTP ${response.statusCode}');
  }
}