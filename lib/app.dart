import 'package:flutter/material.dart';
import 'package:activiteaccesapi/pages/previsioninterface.dart';

//import 'package:http/http.dart';

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application Météo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PrevisionInterface(title: 'Application Météo'),
    );
  }
}
