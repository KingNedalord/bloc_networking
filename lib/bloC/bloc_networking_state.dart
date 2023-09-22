part of 'bloc_networking_bloc.dart';

@immutable
abstract class NetworkingState {}

class NetworkingInitial extends NetworkingState {}
class NetworkLoading extends NetworkingState {}
class NetworkError extends NetworkingState {
  final String error_message;

  NetworkError(this.error_message);
}
class NetworkSuccess extends NetworkingState {

  final List<Post> post;

  NetworkSuccess(this.post);
}

