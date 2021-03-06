import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/modules/game/presentation/state/game_riverpod_presenter.dart';
import 'package:my_favorite_games/app/modules/game/presentation/widgets/favorite_button.dart';
import 'package:my_favorite_games/app/modules/game/presentation/widgets/steam_button.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/widgets/content_block.dart';
import 'package:my_favorite_games/app/shared/widgets/default_appbar.dart';

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
                final isFavoriteAsyncValue =
                    ref.watch(widget.presenter.isFavoriteProvider);

                isFavoriteAsyncValue.maybeWhen(
                  data: (data) {
                    if (!hasInitializedValue) {
                      hasInitializedValue = true;
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

                return FavoriteButton(
                  isFavorite: isFavoriteAsyncValue.value ?? false,
                  onPressed: () async {
                    final isFavorite =
                        ref.read(widget.presenter.isFavoriteProvider).value;
                    _showSnackbar(context, isFavorite ?? false);

                    await widget.presenter.toggleFavoriteUseCase(widget.game);
                    ref.refresh(widget.presenter.isFavoriteProvider);
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
                        SteamButton(game: widget.game),
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
