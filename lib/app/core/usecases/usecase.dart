import 'package:dartz/dartz.dart';
import 'package:my_favorite_games/app/core/error/failure/failure.dart';

abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}
