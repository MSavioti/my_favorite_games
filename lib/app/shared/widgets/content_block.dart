import 'package:flutter/material.dart';

class ContentBlock extends StatelessWidget {
  final Widget child;

  const ContentBlock({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[900],
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
