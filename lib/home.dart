import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Home Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.white,
          onPrimary: Colors.green,
        )
      ),
       home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              print("Share");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print("Search");
            }
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}