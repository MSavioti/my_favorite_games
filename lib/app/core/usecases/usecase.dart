import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
