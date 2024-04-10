import 'package:daimox_login/reusable_widgets/reusable_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:daimox_login/screens/inicio.dart';
import 'package:daimox_login/screens/signup_screen.dart';
import 'package:daimox_login/utilis/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
//import 'package:daimox_login/utilis/color_utils.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: const Color.fromARGB(255, 0, 0, 0)),
    debugShowCheckedModeBanner: false,
    home: SignInScreen(),
  ));
}

// Función para abrir URL
void _launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'No se pudo abrir la URL: $url';
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _passwordHidden = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              hexStringToColor("000000"),
              hexStringToColor("313131"),
              hexStringToColor("161616")
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 21, 21, 21),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logoWidget("assets/images/logo2.png"),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Ingrese su cuenta',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: _emailTextController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          size: 17,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: _passwordTextController,
                      obscureText: _passwordHidden,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordHidden
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 17,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordHidden = !_passwordHidden;
                            });
                          },
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      )
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Inicio()),
                        );
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error de inicio de sesión'),
                              content: Text(
                                  'Credenciales incorrectas. Verifica tu correo y contraseña.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cerrar'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF98FF98),
                            Color(0xFF00FF00),
                            Color(0xFF50C878),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Iniciar Sesión con:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              'https://www.facebook.com'); // Lógica para abrir la URL de Facebook
                        },
                        child: Icon(FontAwesomeIcons.facebookF,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              'https://www.facebook.com'); // Lógica para abrir la URL del correo electrónico
                        },
                        child: Icon(FontAwesomeIcons.solidEnvelope,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              'https://www.facebook.com'); // Lógica para abrir la URL de Google
                        },
                        child:
                            Icon(FontAwesomeIcons.google, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
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
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          " registrarse",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
