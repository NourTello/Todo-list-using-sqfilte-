import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/modules/home.dart';
import 'package:todo_list/shared/style.dart';
import 'package:todo_list/tasksCubit/cubit.dart';

import 'bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksCubit>(
          create: (BuildContext context) => TasksCubit()..openDataBase(),
        ),      ],
      child: MaterialApp(
          theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
                bodyMedium: GoogleFonts.acme(textStyle: Theme.of(context).textTheme.bodyMedium),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor:Styles.primaryColor,
              ),
              scaffoldBackgroundColor: Color(0xffF1F5F9),
              primaryColor: Styles.primaryColor),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
  }
}


