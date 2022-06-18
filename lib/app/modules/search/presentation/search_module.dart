import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/search/presentation/search_screen.dart';

class SearchModule extends StatelessWidget {
  const SearchModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchTerm = ModalRoute.of(context)?.settings.arguments as String;

    return SearchScreen(searchTerm: searchTerm);
  }
}
