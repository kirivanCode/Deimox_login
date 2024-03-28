import 'package:daimox_login/screens/profile_screen.dart';
import 'package:daimox_login/screens/signin_screen.dart';
import 'package:daimox_login/screens/inicio.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCbVwnLtJSl1APBknLRmjSKJpw8YKVBQ2E",
        authDomain: "deimox2-63fc8.firebaseapp.com",
        projectId: "deimox2-63fc8",
        storageBucket: "deimox2-63fc8.appspot.com",
        messagingSenderId: "117652544241",
        appId: "1:117652544241:android:0874bd79dac36ae84d2750",
      ),
    );
    runApp(MyApp());
  } catch (e) {
    print('Error al inicializar Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const SignInScreen(),
      home: Inicio(),
      //home: ProfileScreen(),
    );
  }
}
