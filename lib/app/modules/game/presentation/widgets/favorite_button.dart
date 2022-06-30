import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/shared/flutter_icon/font_icons_icons.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onPressed,
  }) : super(key: key);

  final bool isFavorite;
  final Future Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        FontIcons.heartFull,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    );
  }
}
