import 'package:daimox_login/reusable_widgets/reusable_widget.dart';
import 'package:daimox_login/screens/home_screen.dart';
import 'package:daimox_login/utilis/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  const Text('Registro de Usuario',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
        ),
        
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("000000")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0), //soulucionar
          child: Column(
            children: <Widget>[

              const SizedBox(
              height: 20,
              ),
              reusableTextField("Ponga un usuario", Icons.person_2_outlined, false, 
              _userNameTextController),
                const SizedBox(
              height: 20,
              ),
              reusableTextField("Ponga su email", Icons.person_2_outlined, false, 
              _emailTextController),
                const SizedBox(
              height: 20,
              ),
              reusableTextField("Ponga su contraseña", Icons.person_2_outlined, false, 
              _passwordTextController),
                const SizedBox(
              height: 20,
              ),
              signInSignUpButton(context, false, () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text)
                  .then((value){
                    print("create new acount");
                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=> HomeScreen()));
              }).onError((error, stackTrace){
                    print("error ${error.toString()}");
              });           
             })// Aquí puedes agregar tus campos de registro y lógica de regist         
          ]
          ),
    ))),
    );

  }
}