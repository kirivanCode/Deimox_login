import 'package:daimox_login/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text("cerrar sesion"),
        onPressed: (){
            FirebaseAuth.instance.signOut().then((value){
              print("Signed out");
            


          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInScreen()));
          
        } );
        }
        ),
    );
  }
}