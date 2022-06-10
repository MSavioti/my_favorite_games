import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final Object error;

  const Failure(this.error);

  @override
  List<Object?> get props => [error];
}
