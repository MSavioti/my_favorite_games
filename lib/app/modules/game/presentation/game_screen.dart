import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/infrastructure/environment/env.dart';
import 'package:my_favorite_games/app/modules/game/presentation/state/game_riverpod_presenter.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/widgets/content_block.dart';
import 'package:my_favorite_games/app/shared/widgets/default_appbar.dart';

import 'package:url_launcher/url_launcher.dart' as launcher;

class GameScreen extends ConsumerStatefulWidget {
  final Game game;
  final GameRiverpodPresenter presenter;

  const GameScreen({
    Key? key,
    required this.game,
    required this.presenter,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool hasThrownError = false;
  bool hasInitializedValue = false;

  void _openSteamPage() {
    final uri = Uri.parse(Env.steamGamePageBaseUrl + widget.game.steamAppID);
    launcher.launchUrl(uri);
  }

  void _showSnackbar(BuildContext context, bool isFavorite) {
    final adaptativeMessage = isFavorite ? 'added to' : 'removed from';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          'The game ${widget.game.externalName} was $adaptativeMessage favorites.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.game.externalName,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Consumer(
              builder: (context, ref, child) {
                final isFavoriteProvider =
                    ref.watch(widget.presenter.isFavoriteProvider);
                final favoriteButtonProvider =
                    ref.watch(widget.presenter.favoriteButtonProvider);

                isFavoriteProvider.maybeWhen(
                  data: (data) {
                    if (!hasInitializedValue) {
                      hasInitializedValue = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(widget
                                .presenter.favoriteButtonProvider.notifier)
                            .update((_) => data);
                      });
                    }
                  },
                  error: (_, __) {
                    hasThrownError = true;
                  },
                  orElse: () {},
                );

                if (hasThrownError) {
                  return const Icon(Icons.error);
                }

                if (!hasInitializedValue) {
                  return const CircularProgressIndicator();
                }

                return IconButton(
                  icon: Icon(
                    favoriteButtonProvider
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: Colors.white70,
                  ),
                  onPressed: () async {
                    ref
                        .read(widget.presenter.favoriteButtonProvider.notifier)
                        .update((state) => !state);
                    final isFavorite =
                        ref.read(widget.presenter.favoriteButtonProvider);
                    _showSnackbar(context, isFavorite);

                    await widget.presenter.toggleFavoriteUseCase(widget.game);
                  },
                );
              },
            ),
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
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[900]!,
                              ),
                            ),
                            onPressed: _openSteamPage,
                            child:
                                Image.asset('assets/images/steam_button.png'),
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
