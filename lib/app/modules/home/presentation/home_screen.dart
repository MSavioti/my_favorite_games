import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/modules/home/presentation/state/home_riverpod_presenter.dart';
import 'package:my_favorite_games/app/modules/home/presentation/widgets/grid_favorited_games.dart';
import 'package:my_favorite_games/app/shared/widgets/alert_with_icon.dart';
import 'package:my_favorite_games/app/shared/widgets/content_block.dart';
import 'package:my_favorite_games/app/shared/widgets/custom_progress_indicator.dart';
import 'package:my_favorite_games/app/shared/widgets/default_appbar.dart';
import 'package:my_favorite_games/app/shared/widgets/text_field_search.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeProvider = HomeRiverpodPresenter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        title: 'My Favorite Games',
        hideArrowBack: true,
      ),
      body: ContentBlock(
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

                    return GridFavoriteGames(games: data);
                  },
                  error: (obj, error) {
                    return AlertWithIcon(message: obj.toString());
                  },
                  loading: () {
                    return const CustomProgressIndicator();
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
