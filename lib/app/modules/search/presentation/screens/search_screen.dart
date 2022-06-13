import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);

  final searchResultsProvider = StateProvider<List<Game>?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(),
        ],
      ),
    );
  }
}
