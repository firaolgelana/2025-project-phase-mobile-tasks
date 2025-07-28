import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  const CacheFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
