import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';
import '../../../../core/constants.dart';

class BookRemoteDataSource {
  Future<List<BookModel>> searchBooks(String query, int page) async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/search.json?q=$query&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['docs'] as List).map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
