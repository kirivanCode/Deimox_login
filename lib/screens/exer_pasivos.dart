import 'package:daimox_login/models/exercise.dart';
import 'package:daimox_login/screens/signin_screen.dart';
import 'package:daimox_login/screens/timer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final List<Exercise> exercises = [
    Exercise(name: 'Yoga de ojos', description: 'Descripción...', imagePath: "assets/images/yogaojos.png"),
    Exercise(name: 'Meditación', description: 'Descripción...', imagePath: "assets/images/yoga.png"),
    Exercise(name: 'Cerrar los ojos', description: 'Descripción...', imagePath: "assets/images/closeojos.png"),
    Exercise(name: 'Musica relajante', description: 'Descripción...', imagePath: "assets/images/musicrelax.png"),
    // Agregar más ejercicios según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicios de Pausas Pasivas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              });
            },
          ),
        ],
         iconTheme: IconThemeData(
          color: Colors.white, // Cambia el color de la flecha de devolver a blanco
          size: 30, // Aumenta el tamaño para hacerla más prominente
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    exercises[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    exercises[index].description,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimerScreen(
                          exercises: exercises,
                          exerciseIndex: index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}