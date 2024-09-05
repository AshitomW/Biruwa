import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendFile(File file) async {
  try {
    final url = Uri.parse("http://192.168.1.106:8000/predict");
    final request = http.MultipartRequest("POST", url);

    request.files.add(
      await http.MultipartFile.fromPath("file", file.path),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    // Attempt to parse the response body
    return jsonDecode(responseBody);
  } catch (e) {
    // Return an error object if something goes wrong
    return {
      'statusCode': -1, // Custom status for unexpected errors
      'error': 'Unexpected error occurred',
      'details': e.toString(),
    };
  }
}
