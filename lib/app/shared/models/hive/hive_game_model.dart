import 'package:hive/hive.dart';
import 'package:my_favorite_games/app/shared/entities/game.dart';
import 'package:my_favorite_games/app/shared/models/game_model.dart';

part 'hive_game_model.g.dart';

@HiveType(typeId: 0)
class HiveGameModel implements GameModel {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String steamAppID;

  @override
  @HiveField(2)
  final String cheapestPrice;

  @override
  @HiveField(3)
  final String externalName;

  @override
  @HiveField(4)
  final String thumbnail;

  const HiveGameModel({
    required this.id,
    required this.steamAppID,
    required this.cheapestPrice,
    required this.externalName,
    required this.thumbnail,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'gameID': id,
      'steamAppID': steamAppID,
      'cheapest': cheapestPrice,
      'external': externalName,
      'thumb': thumbnail,
    };
  }

  factory HiveGameModel.fromGame(Game game) {
    return HiveGameModel(
      id: game.id,
      steamAppID: game.steamAppID,
      cheapestPrice: game.cheapestPrice,
      externalName: game.externalName,
      thumbnail: game.thumbnail,
    );
  }
}
