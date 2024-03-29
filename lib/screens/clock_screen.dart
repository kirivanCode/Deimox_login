import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _alarmActive = false;
  final player = AudioPlayer();
  final String audioPath = 'assets/images/alarmaxd.mp3'; // Ruta del archivo de audio

  void _toggleAlarm() {
    setState(() {
      _alarmActive = !_alarmActive;
      if (_alarmActive) {
        // Reproducir el sonido de la alarma
        player.play(audioPath as Source);
      } else {
        // Detener la reproducción del sonido
        player.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de Alarma'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hora de la alarma:',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (pickedTime != null && pickedTime != _selectedTime) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Text(
                _selectedTime.format(context),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Alarma activa:',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Switch(
                  value: _alarmActive,
                  onChanged: (value) {
                    _toggleAlarm(); // Cambiar el estado de la alarma
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
