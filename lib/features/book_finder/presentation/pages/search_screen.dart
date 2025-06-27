import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import 'details_screen.dart';
import '../widgets/shimmer_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Finder')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search books...  Ex: flutter',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context
                        .read<BookBloc>()
                        .add(SearchBooksEvent(_controller.text, _page));
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookLoading) {
                  return const ShimmerList();
                } else if (state is BookLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<BookBloc>()
                          .add(SearchBooksEvent(_controller.text, _page));
                    },
                    child: ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return ListTile(
                          leading: book.coverUrl.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                  book.coverUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ))
                              : const Icon(
                                  Icons.account_circle,
                                  size: 50,
                                ),
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(book: book),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
