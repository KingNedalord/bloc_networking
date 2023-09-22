import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../post/post.dart';

part 'bloc_networking_event.dart';
part 'bloc_networking_state.dart';

class NetworkingBloc extends Bloc<NetworkingEvent, NetworkingState> {
  NetworkingBloc() : super(NetworkingInitial()) {
    on<NetworkingEvent>((event, emit) {});
    on<getPost>((event, emit) async {
      Dio dio = Dio();
      emit(NetworkLoading());
      try{
        var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
        if (response.statusCode == 200){
          emit(NetworkSuccess(listFromJson(response.data)));
        }else{
          emit(NetworkError("Undefined error"));
        }
      }on DioException catch(e){
        emit(NetworkError("Undefined error"));
      }
    });
    on<NetworkingDelete>((event, emit) {});

  }
}
