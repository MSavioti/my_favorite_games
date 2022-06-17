import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/home/presentation/screens/home_screen.dart';
import 'package:my_favorite_games/app/modules/search/presentation/screens/search_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
