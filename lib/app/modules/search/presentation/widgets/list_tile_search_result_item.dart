import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';

class ListTileSearchResultItem extends StatelessWidget {
  final Game game;

  const ListTileSearchResultItem({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Material(
        color: Colors.grey[800],
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leading: Container(
            color: Colors.grey[800],
            padding: const EdgeInsets.all(8.0),
            child: Image(
              width: 64.0,
              height: 64.0,
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                game.thumbnail,
              ),
            ),
          ),
          title: Text(
            game.externalName,
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: const Icon(
            Icons.arrow_right_outlined,
            color: Colors.white70,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/game', arguments: game);
      },
    );
  }
}
