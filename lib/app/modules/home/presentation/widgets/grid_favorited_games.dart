import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/home/presentation/widgets/game_grid_item.dart';
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
            GameGridItem(
              game: games[i],
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
