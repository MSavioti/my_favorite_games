import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/game/presentation/game_screen.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GameModule extends StatelessWidget {
  const GameModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)?.settings.arguments as Game;

    return GameScreen(game: game);
  }
}
