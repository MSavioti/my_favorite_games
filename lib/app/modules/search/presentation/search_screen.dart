import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class SearchScreen extends ConsumerWidget {
  final String searchTerm;

  SearchScreen({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  final searchResultsProvider = StateProvider<List<Game>?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          TextField(),
        ],
      ),
    );
  }
}
