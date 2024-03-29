import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _alarmActive = false;

  // Sonido de alarma
  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de Alarma'),
        backgroundColor: Colors.black, // Color de fondo oscuro
      ),
      backgroundColor: Colors.black, // Color de fondo oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hora de la alarma:',
              style: TextStyle(fontSize: 20.0, color: Colors.white), // Color de texto blanco
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
                  style: TextStyle(fontSize: 20.0, color: Colors.white), // Color de texto blanco
                ),
                Switch(
                  value: _alarmActive,
                  onChanged: (value) {
                    setState(() {
                      _alarmActive = value;
                      if (_alarmActive) {
                        //_setAlarm();
                      } else {
                        //_cancelAlarm();
                      }
                    });
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
