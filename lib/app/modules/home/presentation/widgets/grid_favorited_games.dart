import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/home/presentation/widgets/game_grid_item.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class GridFavoriteGames extends StatelessWidget {
  final List<Game> games;
  final Function() onRefresh;
  final int columnsCount = 3;
  final double padding = 16.0;
  final double gridItemAspectRatio = 3 / 4;

  const GridFavoriteGames({
    Key? key,
    required this.games,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridItemWidth = screenWidth * 0.33 - padding * 4;

    return Flexible(
      child: GridView.count(
        crossAxisCount: columnsCount,
        crossAxisSpacing: padding,
        mainAxisSpacing: padding,
        childAspectRatio: gridItemAspectRatio,
        shrinkWrap: true,
        children: [
          for (int i = 0; i < games.length; i++)
            GameGridItem(
              game: games[i],
              availableWidth: gridItemWidth,
              onTap: () async => await Navigator.of(context)
                  .pushNamed(
                    '/game',
                    arguments: games[i],
                  )
                  .then((_) => onRefresh()),
            ),
        ],
      ),
    );
  }
}
