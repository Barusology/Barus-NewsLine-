import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';



void main(){
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Text App",
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        primarySwatch: Colors.blueGrey
       ),
         home:TextWigetHomePage(),
    );
  }
}
class TextWigetHomePage extends StatefulWidget {
  const TextWigetHomePage({super.key});

  @override
  State<TextWigetHomePage> createState() => _TextWigetHomePageState();
}

class _TextWigetHomePageState extends State<TextWigetHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEXT WIDGET",
        style: TextStyle(fontSize: 20,backgroundColor: Colors.cyanAccent),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            height: 200,
            child: Center(
              child: Text("Welcome To TextWidget",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing:2,wordSpacing: 3,
              ),
              ),
            
            
            ),
          ),
          RichText(text: TextSpan(
            text: "Dont have an account?",
            style: TextStyle (color:Colors.black,
            fontSize: 10),
            children:[
              TextSpan(text: "Sign Up",
              style: TextStyle(color: Colors.green,
              fontSize: 10,
              fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
              ..onTap =(){
                print("Sign Up");
              }
              
              )

            ]
          )
          )
        ],
      ),
      
    );
  }
}

