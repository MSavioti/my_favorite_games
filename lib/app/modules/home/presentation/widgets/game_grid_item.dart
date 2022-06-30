import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GameGridItem extends StatelessWidget {
  const GameGridItem({
    Key? key,
    required this.game,
    required this.onTap,
  }) : super(key: key);

  final Game game;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(game.thumbnail),
            ),
            Positioned(
              bottom: 4.0,
              child: SizedBox(
                child: Text(
                  game.externalName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
