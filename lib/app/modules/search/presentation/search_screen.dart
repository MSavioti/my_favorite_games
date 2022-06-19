import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_games/app/modules/search/presentation/state/search_riverpod_presenter.dart';
import 'package:my_favorite_games/app/modules/search/presentation/widgets/list_tile_search_result_item.dart';
import 'package:my_favorite_games/app/shared/widgets/alert_with_icon.dart';
import 'package:my_favorite_games/app/shared/widgets/content_block.dart';
import 'package:my_favorite_games/app/shared/widgets/custom_progress_indicator.dart';
import 'package:my_favorite_games/app/shared/widgets/default_appbar.dart';
import 'package:my_favorite_games/app/shared/widgets/text_field_search.dart';

class SearchScreen extends ConsumerWidget {
  final String searchTerm;

  SearchScreen({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  late final searchPresenter = SearchRiverpodPresenter(searchTerm: searchTerm);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _goToHomeScreen() {
      Navigator.of(context).pushReplacementNamed('/');
    }

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Search results for "$searchTerm"',
        arrowBackAction: _goToHomeScreen,
      ),
      body: ContentBlock(
        child: Column(
          children: [
            SearchTextField(initialValue: searchTerm),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, child) {
                final games = ref.watch(searchPresenter.provider);

                return games.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return AlertWithIcon(
                        message: 'No results found for "$searchTerm".',
                      );
                    }

                    return Flexible(
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (_, i) {
                          return ListTileSearchResultItem(game: data[i]);
                        },
                        separatorBuilder: (_, i) {
                          return const SizedBox(height: 8.0);
                        },
                      ),
                    );
                  },
                  error: (obj, error) =>
                      AlertWithIcon(message: 'Error: "$obj".'),
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
