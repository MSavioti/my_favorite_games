import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;

  DefaultAppBar({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
      ),
      backgroundColor: Colors.grey[800],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
