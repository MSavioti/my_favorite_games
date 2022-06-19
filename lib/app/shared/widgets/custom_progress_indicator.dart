import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;

  const CustomProgressIndicator({
    this.height = 80.0,
    this.width = 80.0,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        ),
      ),
    );
  }
}
