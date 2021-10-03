import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_dezeer/view/homeview.dart';
import 'package:music_dezeer/viewmodel/artist/artist_cubit.dart';
import 'package:music_dezeer/viewmodel/bloc_observer.dart';
import 'package:music_dezeer/viewmodel/home/cubit/home_cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ArtistCubit(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                // systemOverlayStyle: SystemUiOverlayStyle(
                //     statusBarColor: Colors.red,
                //     systemNavigationBarColor: Colors.red,
                //     statusBarBrightness: Brightness.light),
                backwardsCompatibility: false,
                backgroundColor: Colors.grey[900],
                centerTitle: true,
                elevation: 0),
            scaffoldBackgroundColor: Colors.grey[900],
            primarySwatch: Colors.red,
          ),
          home: HomeView()),
    );
  }
}
