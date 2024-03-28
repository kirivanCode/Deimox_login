import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.black, // Cambia el color de fondo de la barra de navegación según sea necesario
      ),
      body: Container(
        color: Colors.black, // Establece el color de fondo oscuro para toda la pantalla
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0), // Espacio en blanco entre la barra de navegación y el contenido
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/ayuda.jpg"), // Cambia la ruta de la imagen según sea necesario
            ),
            SizedBox(height: 20.0), // Espacio en blanco entre la imagen y los detalles del perfil
            Text(
              'Nombre Apellido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0), // Espacio en blanco entre el nombre y otros detalles del perfil
            Text(
              'Edad: 20 años',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Text(
              'Peso: 45 kg',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            // Agrega más detalles del perfil según sea necesario
          ],
        ),
      ),
    );
  }
}
