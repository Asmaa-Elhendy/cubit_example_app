import 'package:cubit_film_app/view/home.dart';
import 'package:cubit_film_app/view_model/characters_bloc/characters_cubit.dart';
import 'package:cubit_film_app/view_model/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CharactersCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch:Colors.grey,
        ),
        home: Home(),
      ),
    );
  }
}
