// test/features/book_finder/domain/usecases/search_books_test.dart
import 'package:backbase_assessment/features/book_finder/domain/entities/book.dart';
import 'package:backbase_assessment/features/book_finder/domain/repositories/book_repository.dart';
import 'package:backbase_assessment/features/book_finder/domain/usecases/search_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_books_test.mocks.dart';

@GenerateMocks([BookRepository])
void main() {
  late SearchBooks usecase;
  late MockBookRepository mockRepository;

  setUp(() {
    mockRepository = MockBookRepository();
    usecase = SearchBooks(mockRepository);
  });

  const tQuery = 'flutter';
  const tPage = 1;
  final tBooks = [
    Book(
        title: 'Flutter for Beginners',
        author: 'John Doe',
        coverUrl: 'https://example.com/flutter.jpg')
  ];

  test('should return book list from repository', () async {
    when(mockRepository.searchBooks(tQuery, tPage))
        .thenAnswer((_) async => tBooks);

    final result = await usecase(tQuery, tPage);

    expect(result, tBooks);
    verify(mockRepository.searchBooks(tQuery, tPage));
    verifyNoMoreInteractions(mockRepository);
  });
}
