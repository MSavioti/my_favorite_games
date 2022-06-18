import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/game/presentation/game_module.dart';
import 'package:my_favorite_games/app/modules/home/presentation/home_screen.dart';
import 'package:my_favorite_games/app/modules/search/presentation/search_module.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/game': (context) => const GameModule(),
        '/search': (context) => const SearchModule(),
      },
    );
  }
}
