import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Favories(),
    );
  }
}





class Favories extends StatelessWidget {
  const Favories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favoris"),),
      body: ListView(
        children:[
          Padding(
            padding:const EdgeInsets.all(8.0),
            child:Container(
              height:200,
              color: Colors.deepPurple[200],

            ),
          ),
          Padding(
            padding:const EdgeInsets.all(8.0),
            child:Container(
              height:200,
              color: Colors.deepPurple[200],

            ),
          ),
          Padding(
            padding:const EdgeInsets.all(8.0),
            child:Container(
              height:200,
              color: Colors.deepPurple[200],

            ),
          ),
        ],
      ),
    );
  }
}











