import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GridFavoriteGames extends StatelessWidget {
  final List<Game> games;

  const GridFavoriteGames({
    Key? key,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 3 / 4,
        shrinkWrap: true,
        children: [
          for (int i = 0; i < games.length; i++)
            InkWell(
              child: Container(
                color: Colors.grey[900],
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(games[i].thumbnail),
                    ),
                    Positioned(
                      bottom: 4.0,
                      child: SizedBox(
                        child: Text(
                          games[i].externalName,
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
              onTap: () => Navigator.of(context).pushNamed(
                '/game',
                arguments: games[i],
              ),
            ),
        ],
      ),
    );
  }
}
