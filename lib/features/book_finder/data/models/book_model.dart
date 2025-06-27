import '../../domain/entities/book.dart';

class BookModel extends Book {
  BookModel({required String title, required String author, required String coverUrl})
      : super(title: title, author: author, coverUrl: coverUrl);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final coverId = json['cover_i']?.toString();
    return BookModel(
      title: json['title'] ?? 'No Title',
      author: (json['author_name'] as List?)?.first ?? 'Unknown Author',
      coverUrl: coverId != null ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg' : '',
    );
  }
}
