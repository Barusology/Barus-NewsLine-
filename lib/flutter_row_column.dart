import 'package:flutter/material.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Row Column",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
        ),
      
      home:FlutterRowColumnHomePage(),

    );
  }
}

class FlutterRowColumnHomePage extends StatefulWidget {
  const FlutterRowColumnHomePage({super.key});

  @override
  State<FlutterRowColumnHomePage> createState() => _NewAppHomePageState();
}

class _NewAppHomePageState extends State<FlutterRowColumnHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Row Column",
        style: TextStyle(fontWeight: FontWeight.bold,
        backgroundColor:Colors.white,
      ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const[
              Text("Flutter Row and Columb"),
              Text("Flutter Row and Columb"),
              Text("Flutter Row and Columb"),
              Text("Flutter Row and Columb"),
            ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("IM THE COLUMN")
          ],
        ),
      ),
    );
    
  
} 
}