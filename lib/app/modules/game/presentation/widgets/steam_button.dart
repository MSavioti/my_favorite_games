import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SteamButton extends StatelessWidget {
  const SteamButton({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  void _openSteamPage() {
    final uri = Uri.parse(Env.steamGamePageBaseUrl + game.steamAppID);
    launcher.launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    if (game.steamAppID.isEmpty) {
      return const SizedBox();
    }

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.grey[900]!,
        ),
      ),
      onPressed: _openSteamPage,
      child: Image.asset('assets/images/steam_button.png'),
    );
  }
}
