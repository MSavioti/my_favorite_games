import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/game/presentation/screens/game_module.dart';
import 'package:my_favorite_games/app/modules/home/presentation/screens/home_screen.dart';
import 'package:my_favorite_games/app/modules/search/presentation/screens/search_module.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/game': (context) => const GameModule(),
        '/search': (context) => const SearchModule(),
      },
    );
  }
}
