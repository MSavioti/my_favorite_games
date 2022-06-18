import 'package:flutter/material.dart';

class AlertWithIcon extends StatelessWidget {
  final String message;

  const AlertWithIcon({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.error),
            const SizedBox(height: 16.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
