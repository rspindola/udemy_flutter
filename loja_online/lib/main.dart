import 'package:flutter/material.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Loja FLutter",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
