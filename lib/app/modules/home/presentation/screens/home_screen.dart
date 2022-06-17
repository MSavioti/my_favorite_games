import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/modules/home/presentation/home_presenter.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/widgets/text_field/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  // final HomePresenter presenter;

  const HomeScreen({
    Key? key,
    // required this.presenter,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    // games = await widget.presenter.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white70)),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        color: Colors.orange[900],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SearchTextField(),
            const SizedBox(height: 16.0),
            Flexible(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 4,
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < 18; i++) const Placeholder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
