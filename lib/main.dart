import 'package:bloc_networking/bloC/bloc_networking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => NetworkingBloc(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NetworkingBloc>(context).add(getPost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          RefreshIndicator(child: BlocBuilder<NetworkingBloc, NetworkingState>(
        builder: (context, state) {
          if (state is NetworkLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NetworkError) {
            return Container(
              width: MediaQuery.of(context).size.width ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(state.error_message),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<NetworkingBloc>(context).add(
                        getPost(),
                      );
                    },
                    child: Text("Refresh"),
                    color: Colors.green,
                  )
                ],
              ),
            );
          } else if (state is NetworkSuccess) {
            return ListView.builder(
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.post[index].title ?? "Null"),
                  subtitle: Text(state.post[index].id.toString()),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ), onRefresh: () async {
        BlocProvider.of<NetworkingBloc>(context).add(getPost());
      }),
    );
  }
}
