import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Function()? arrowBackAction;
  final List<Widget>? actions;
  final bool hideArrowBack;

  @override
  final Size preferredSize;

  DefaultAppBar({
    Key? key,
    required this.title,
    this.arrowBackAction,
    this.actions,
    this.hideArrowBack = false,
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
      leading: hideArrowBack
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: arrowBackAction ?? () => Navigator.of(context).pop(),
            ),
      automaticallyImplyLeading: true,
      actions: actions,
    );
  }
}
