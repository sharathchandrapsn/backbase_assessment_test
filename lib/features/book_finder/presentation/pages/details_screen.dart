import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/book.dart';
import 'dart:math' as math;

import '../../domain/repositories/book_repository.dart';

class DetailsScreen extends StatefulWidget {
  final Book book;
  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RotationTransition(
                turns: _controller,
                child: widget.book.coverUrl.isNotEmpty
                    ? Image.network(
                        widget.book.coverUrl,
                        height: 200,
                      )
                    : const Icon(Icons.book, size: 200),
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.book.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(widget.book.author,
                style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality to save to SQLite here
                final repo = sl<BookRepository>();
                repo.saveBook(widget.book).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Book saved to library')),
                  );
                }).catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to save book: \$e')),
                  );
                });
              },
              icon: const Icon(Icons.save_alt),
              label: const Text("Save Book"),
            )
          ],
        ),
      ),
    );
  }
}
