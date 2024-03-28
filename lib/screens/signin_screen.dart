import 'package:daimox_login/reusable_widgets/reusable_widget.dart';
import 'package:daimox_login/screens/home_screen.dart';
import 'package:daimox_login/screens/signup_screen.dart';
import 'package:daimox_login/utilis/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
TextEditingController _passwordTextController = TextEditingController();
TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("000000"),
              hexStringToColor("313131"),
              hexStringToColor("161616")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),

              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/logo.png"),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Ingrese el usuario", Icons.person_2_outlined, false, 
                  _emailTextController),
                  SizedBox(
                    height: 22,
                  ),
                  reusableTextField("Ingrese la contraseña", Icons.lock_outline, true, 
                    _passwordTextController),
                  SizedBox(
                    height: 22,
                  ),
                  signInSignUpButton(context, true, () {
                      FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: _emailTextController.text, password: _passwordTextController.text)
                    .then((value){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())) ;
                    
                  }).onError((error, stackTrace){
                    print("Error ${error.toString()}");
                  });
                  }),
                 signUpOption()
                ],
                ),
              
              ),
            
              ),

      ),
    );
  }

 Row signUpOption() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "No tienes una cuenta?",
        style: TextStyle(color: Colors.white70),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        },
        child: Text(
          " registrarse",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}


}





