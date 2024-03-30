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
  late List<int> _originalDurations;
  late ExerciseTimer _exerciseTimer;

  @override
  void initState() {
    super.initState();
    _currentExerciseIndex = widget.exerciseIndex;
    _currentExercise = widget.exercises[_currentExerciseIndex];
    _originalDurations = List.filled(
        widget.exercises.length, 30); 
    _exerciseTimer = ExerciseTimer(
      duration: _originalDurations[_currentExerciseIndex],
      onTimerEnd: _goToNextExercise,
      onNext: _goToNextExercise,
      onPrevious: _goToPreviousExercise,
      autoRestart: true,
    );
  }

  void _goToNextExercise() {
    if (_currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _currentExercise = widget.exercises[_currentExerciseIndex];
        _resetTimer(_originalDurations[
            _currentExerciseIndex]); 
      });
    }
  }

  void _goToPreviousExercise() {
    if (_currentExerciseIndex > 0) {
      setState(() {
        _currentExerciseIndex--;
        _currentExercise = widget.exercises[_currentExerciseIndex];
        _resetTimer(_originalDurations[
            _currentExerciseIndex]); 
      });
    }
  }

  void _resetTimer(int duration) {
    _exerciseTimer = ExerciseTimer(
      key:
          UniqueKey(), 
      duration: duration,
      onTimerEnd: _goToNextExercise,
      onNext: _goToNextExercise,
      onPrevious: _goToPreviousExercise,
      autoRestart: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pausa Activa: ${_currentExercise.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_currentExercise.description),
            SizedBox(height: 20),
            _exerciseTimer,
          ],
        ),
      ),
    );
  }
}
