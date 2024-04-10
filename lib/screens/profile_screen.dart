import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'inicio.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImage = "assets/images/xd.png";
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white, // Color del texto
            fontWeight: FontWeight.bold, // Negrita
          ),
        ),
        backgroundColor: Colors.black, // Fondo negro del AppBar
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Color de la flecha de retroceso y otros iconos del AppBar
        ),
      ),
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  backgroundImage: AssetImage(_profileImage),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _edadController,
                decoration: InputDecoration(
                  labelText: 'Edad',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                controller: _pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_profileImage == "assets/images/xd.png") {
                          _profileImage = "assets/images/ayuda.jpg";
                        } else {
                          _profileImage = "assets/images/xd.png";
                        }
                      });
                    },
                    icon: Icon(Icons.photo_camera),
                    color: Colors.white,
                    iconSize: 30.0,
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      _guardarDatosEnFirestore(
                          _nombreController.text,
                          int.parse(_edadController.text),
                          int.parse(_pesoController.text));
                    },
                    child: Text('Guardar Datos'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inicio()),
                  );
                },
                child: Text('Volver a Inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardarDatosEnFirestore(String nombre, int edad, int peso) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection('perfiles').add({
      'nombre': nombre,
      'edad': edad,
      'peso': peso,
    }).then((value) {
      print('Datos guardados en Firestore con ID: ${value.id}');
      // Navegar a la pantalla de perfil de datos
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileDataScreen(nombre: nombre, edad: edad, peso: peso),
        ),
      );
    }).catchError((error) {
      print('Error al guardar los datos: $error');
      // Muestra un diálogo de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Hubo un error al guardar los datos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}

class ProfileDataScreen extends StatelessWidget {
  final String nombre;
  final int edad;
  final int peso;

  ProfileDataScreen({required this.nombre, required this.edad, required this.peso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nombre: $nombre',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Edad: $edad años',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Peso: $peso kg',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
