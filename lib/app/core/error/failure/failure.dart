abstract class Failure {
  final Object error;

  const Failure(this.error);

  @override
  bool operator ==(Object other) => other is Failure && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
