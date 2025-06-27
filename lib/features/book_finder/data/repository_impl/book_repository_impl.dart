import 'package:sqflite/sqflite.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final Database database;

  BookRepositoryImpl(this.remoteDataSource, this.database);

  @override
  Future<List<Book>> searchBooks(String query, int page) => remoteDataSource.searchBooks(query, page);

  @override
  Future<void> saveBook(Book book) async {
    await database.insert('books', {
      'title': book.title,
      'author': book.author,
      'coverUrl': book.coverUrl,
    });
  }

  @override
  Future<List<Book>> getSavedBooks() async {
    final maps = await database.query('books');
    return maps.map((map) => Book(
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['coverUrl'] as String,
    )).toList();
  }
}
