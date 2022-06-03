import 'package:my_favorite_games/app/modules/search/domain/entities/game.dart';

class GameModel extends Game {
  const GameModel({
    required super.id,
    required super.steamAppID,
    required super.cheapestPrice,
    required super.externalName,
    required super.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'gameID': id,
      'steamAppID': steamAppID,
      'cheapest': cheapestPrice,
      'external': externalName,
      'thumb': thumbnail,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> dataMap) {
    return GameModel(
      id: dataMap['gameID'] ?? '',
      steamAppID: dataMap['steamAppID'] ?? '',
      cheapestPrice: dataMap['cheapest'] ?? '',
      externalName: dataMap['external'] ?? '',
      thumbnail: dataMap['thumb'] ?? '',
    );
  }

  factory GameModel.dummy() {
    return const GameModel(
      id: '0',
      steamAppID: '0',
      cheapestPrice: '0.00',
      externalName: 'Game Name',
      thumbnail: 'https://site/image.jpg',
    );
  }
}
