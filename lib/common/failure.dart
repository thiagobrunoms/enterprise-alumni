abstract class Failure {
  String errorMessage;

  Failure({required this.errorMessage});

  @override
  String toString() => 'Failure: $errorMessage';
}
