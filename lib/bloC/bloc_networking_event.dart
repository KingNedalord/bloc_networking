part of 'bloc_networking_bloc.dart';

@immutable
abstract class NetworkingEvent {}
class getPost extends NetworkingEvent{}
class NetworkingDelete extends NetworkingEvent{}
