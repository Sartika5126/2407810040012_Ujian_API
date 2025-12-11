import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sartika_2407810040012_ujian_api/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context)=>RegisterPage(),

      },
      initialRoute: "/",
    );
  }
}

