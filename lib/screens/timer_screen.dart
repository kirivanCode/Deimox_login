import 'package:flutter/material.dart';
import 'package:daimox_login/models/exercise.dart';
import 'package:daimox_login/widgets/exercise_timer.dart';

class TimerScreen extends StatefulWidget {
  final List<Exercise> exercises;
  final int exerciseIndex;

  TimerScreen({required this.exercises, required this.exerciseIndex});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _currentExerciseIndex;
  late Exercise _currentExercise;

  @override
  void initState() {
    super.initState();
    _currentExerciseIndex = widget.exerciseIndex;
    _currentExercise = widget.exercises[_currentExerciseIndex];
  }

  void _goToNextExercise() {
    if (_currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _currentExercise = widget.exercises[_currentExerciseIndex];
      });
    }
  }

  void _goToPreviousExercise() {
    if (_currentExerciseIndex > 0) {
      setState(() {
        _currentExerciseIndex--;
        _currentExercise = widget.exercises[_currentExerciseIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pausa Activa: ${_currentExercise.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Centrar el título en la AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_currentExercise.description),
            SizedBox(height: 20),
            ExerciseTimer(
              duration: 30, // Cambia a la duración que desees
              onTimerEnd: _goToNextExercise,
              onNext: _goToNextExercise,
              onPrevious: _goToPreviousExercise,
              autoRestart: true, // Habilita el reinicio automático
            ),
          ],
        ),
      ),
    );
  }
}
