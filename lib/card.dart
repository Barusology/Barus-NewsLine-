import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Card App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        ),
        home:const CardHomePage(),
      );
    
  }
}
class CardHomePage extends StatefulWidget {
  const CardHomePage({super.key});

  @override
  State<CardHomePage> createState() => _CardHomePageState();
}

class _CardHomePageState extends State<CardHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        padding: EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          elevation: 10,
          child: Column(mainAxisSize: MainAxisSize.min,
            children:  [
              ListTile(
                title: Text("GOD IS LOVE",
                style: TextStyle(color: Colors.white,fontSize: 30),),
                subtitle: Text("Moses Bliss",style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.album,color: Colors.white,size: 50,),
                ),
              
              ButtonBar(alignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: Colors.black,
                  ),
                  onPressed: (){
                  print("Play");
                
                },
                 child: Text("Play")
                 ),
              
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.black,
                ),
                onPressed: (){
                print("Pause");

              },
               child: Text("Pause")
               ),
            ]),
        ]),
      ),
      ),
    );
  }
}