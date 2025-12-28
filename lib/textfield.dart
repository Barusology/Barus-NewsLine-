import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // renamed from TextField
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Text App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const TextFieldHomePage(),
    );
  }
}

class TextFieldHomePage extends StatefulWidget {
  const TextFieldHomePage({super.key});

  @override
  State<TextFieldHomePage> createState() => _TextFieldHomePageState();
}

class _TextFieldHomePageState extends State<TextFieldHomePage> {
  //username controller
  final TextEditingController _usernameController =TextEditingController();
  //password controller
  final TextEditingController _passwordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TEXT WIDGET",
          style: TextStyle(fontSize: 20,
           backgroundColor: Colors.cyanAccent
           ),
        ),
      ),
      body:  Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.black),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                labelText: "User Name",
                hintText: "Enter User Name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.black),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                labelText: "Password",
                hintText: "Enter Password",
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed:(){
                var username = _usernameController.text;
                var password = _passwordController.text;
                print("username" + username + "password" + password);
              },
              child: Text("Login"),
          ),
          ),
          
        ],
      ),
    );
  }
}
