import 'package:flutter/material.dart';
import 'package:mvvm/screen/rgstrr.dart';
import 'package:mvvm/screen/login.dart';
import 'package:mvvm/screen/home.dart';
import 'package:provider/provider.dart';

import 'model/cmnvwmdl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommonViewModel>(
        create: (context) => CommonViewModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
        ));
  }
}
