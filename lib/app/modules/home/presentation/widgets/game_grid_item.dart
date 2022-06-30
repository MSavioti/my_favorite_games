import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GameGridItem extends StatelessWidget {
  const GameGridItem({
    Key? key,
    required this.game,
    required this.onTap,
    required this.availableWidth,
  }) : super(key: key);

  final Game game;
  final Function() onTap;
  final double availableWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(game.thumbnail),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              height: 64.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.05, 0.75],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4.0,
              child: SizedBox(
                width: availableWidth,
                child: Text(
                  game.externalName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
