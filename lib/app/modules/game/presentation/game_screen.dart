import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GameScreen extends StatelessWidget {
  final Game game;

  const GameScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.externalName),
      ),
    );
  }
}
