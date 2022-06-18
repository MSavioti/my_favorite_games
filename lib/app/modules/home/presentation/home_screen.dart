import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/modules/home/presentation/state/home_riverpod_presenter.dart';
import 'package:my_favorite_games/app/modules/home/presentation/widgets/grid_favorited_games.dart';
import 'package:my_favorite_games/app/shared/widgets/alert_with_icon.dart';
import 'package:my_favorite_games/app/shared/widgets/text_field_search.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeProvider = HomeRiverpodPresenter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'My Favorite Games',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        color: Colors.orange[900],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SearchTextField(),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, child) {
                final games = ref.watch(homeProvider.provider);

                return games.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const AlertWithIcon(
                        message: 'No favorites added yet.',
                      );
                    }

                    return Flexible(
                      child: GridFavoriteGames(games: data),
                    );
                  },
                  error: (obj, error) {
                    return AlertWithIcon(message: obj.toString());
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
