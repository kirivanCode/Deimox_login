import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final player = AudioPlayer();
  final String audioPath = 'assets/images/alarmaxd.mp3';
  TimeOfDay _selectedTime = TimeOfDay.now();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _alarmActive = false;
  Duration _remainingTime = Duration();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _initNotifications();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    await player.setAsset(audioPath);
  }

  Future<void> _initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showAlarmNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel',
      'Alarma',
      
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarmaxd'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '¡Alarma!',
      'Es hora de despertar.',
      platformChannelSpecifics,
    );
  }

  void _scheduleAlarm() {
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final timeUntilAlarm = alarmTime.difference(now);

    setState(() {
      _remainingTime = timeUntilAlarm;
      _alarmActive = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - Duration(seconds: 1);
        } else {
          timer.cancel();
          _alarmActive = false;
          _remainingTime = Duration();
          player.setLoopMode(LoopMode.one);
          player.play();
          _showAlarmNotification();
        }
      });
    });
  }

  void _stopAlarm() {
    _timer?.cancel();
    setState(() {
      _alarmActive = false;
      _remainingTime = Duration();
    });
    player.stop();
    flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración de Alarma',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/reloj.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Hora de la alarma:',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Text(
              '${_selectedTime.hour}:${_selectedTime.minute}',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 20),
            if (_alarmActive)
              Text(
                'Tiempo restante: ${_remainingTime.inHours}:${(_remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _selectedTime = selectedTime;
                      });
                    }
                  },
                  child: Text('Seleccionar Hora'),
                ),
                SizedBox(width: 20),
                if (!_alarmActive)
                  ElevatedButton(
                    onPressed: _scheduleAlarm,
                    child: Text('Activar Alarma'),
                  ),
                if (_alarmActive)
                  ElevatedButton(
                    onPressed: _stopAlarm,
                    child: Text('Detener Alarma'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
