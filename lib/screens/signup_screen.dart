import 'package:daimox_login/reusable_widgets/reusable_widget.dart';
import 'package:daimox_login/screens/home_screen.dart';
import 'package:daimox_login/utilis/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController(); // Nuevo controlador para el nombre de usuario
  bool _passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Registro',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color:
              Colors.white, // Cambia el color de la flecha de devolver a blanco
          size: 30, // Aumenta el tamaño para hacerla más prominente
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                hexStringToColor("000000"),
                hexStringToColor("000000"),
                hexStringToColor("161616")
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              //Image.asset('assets/images/logo.png'),
              Container(
                height:
                    650, // Ajusta la altura para dejar espacio para el nuevo campo de nombre de usuario
                width: 325,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 24, 24),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    logoWidget("assets/images/logo2.png"),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 250,
                      child: TextField(
                        controller:
                            _usernameController, // Vincula el controlador de texto al campo de entrada para el nombre de usuario
                        decoration: InputDecoration(
                          labelText:
                              'Nombre de usuario', // Etiqueta para el campo de nombre de usuario
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            FontAwesomeIcons.user,
                            size: 17,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _emailController,
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
                    SizedBox(height: 20),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordHidden = !_passwordHidden;
                              });
                            },
                            child: Icon(
                              _passwordHidden
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        obscureText: _passwordHidden,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _register(); // Llama a la función _register para registrar al usuario
                      },
                      child: Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 25, 165, 69),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((userCredential) {
      // Guarda el nombre de usuario en la base de datos después de que el usuario se haya registrado exitosamente
      _saveUsername(userCredential.user!.uid);
      // Navega a la pantalla de inicio después del registro exitoso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de registro'),
            content: Text(error.toString()),
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
  }

  void _saveUsername(String userId) {
    // Implementa aquí la lógica para guardar el nombre de usuario en la base de datos
    // Por ejemplo, podrías usar Firestore para guardar el nombre de usuario
    // Aquí hay un ejemplo simplificado usando Firestore:
    // FirebaseFirestore.instance.collection('users').doc(userId).set({'username': _usernameController.text});
  }
}
