abstract class BookEvent {}
class SearchBooksEvent extends BookEvent {
  final String query;
  final int page;
  SearchBooksEvent(this.query, this.page);
}