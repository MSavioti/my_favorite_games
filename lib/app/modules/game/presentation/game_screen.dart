import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/widgets/content_block.dart';
import 'package:my_favorite_games/app/shared/widgets/default_appbar.dart';

import 'package:url_launcher/url_launcher.dart' as launcher;

class GameScreen extends ConsumerStatefulWidget {
  final Game game;

  const GameScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool isFavorite = false;

  void _openSteamPage() {
    final uri = Uri.parse(Env.steamGamePageBaseUrl + widget.game.steamAppID);
    launcher.launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.game.externalName,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border_outlined,
                  color: Colors.white70,
                ),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: ContentBlock(
        child: Column(
          children: [
            SizedBox(
              height: 250.0,
              child: Row(
                children: [
                  Container(
                    height: 250.0,
                    color: Colors.grey[900],
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      width: 150.0,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(widget.game.thumbnail),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.game.externalName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        if (widget.game.steamAppID.isNotEmpty)
                          ElevatedButton(
                            child: Text('Open on Steam'),
                            onPressed: _openSteamPage,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
