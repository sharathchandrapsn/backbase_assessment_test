import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/search_books.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final SearchBooks searchBooks;

  BookBloc(this.searchBooks) : super(BookInitial()) {
    on<SearchBooksEvent>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await searchBooks(event.query, event.page);
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}
