import 'package:flutter/material.dart';
import 'package:unityai/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UnityAI',
        theme: ThemeData(
          useMaterial3: true,
          drawerTheme: DrawerThemeData(
            backgroundColor: Colors.grey[300],
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 71, 71, 71),
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
            color: Colors.grey[300],
          ),
          scaffoldBackgroundColor: Colors.grey[300],
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
