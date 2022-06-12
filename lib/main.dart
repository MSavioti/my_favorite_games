import 'package:flutter/material.dart';
import 'package:my_favorite_games/app/app.dart';
import 'package:my_favorite_games/app/infrastructure/dependency_injection/service_locator.dart';

void main() async {
  await initializeServiceLocator();
  runApp(const App());
}
