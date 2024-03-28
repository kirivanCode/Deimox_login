import 'dart:async';
import 'package:flutter/material.dart';

class ExerciseTimer extends StatefulWidget {
  final int duration;
  final VoidCallback onTimerEnd;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool autoRestart;

  ExerciseTimer({
    required this.duration,
    required this.onTimerEnd,
    required this.onNext,
    required this.onPrevious,
    this.autoRestart = false, // Valor por defecto es false
  });

  @override
  _ExerciseTimerState createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  late int _seconds;
  late bool _isRunning;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration;
    _isRunning = true;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        _isRunning = false;
        widget.onTimerEnd();
        if (widget.autoRestart) {
          _restartTimer();
        }
      } else if (_isRunning) {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  void _pauseOrResume() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _reset() {
    setState(() {
      _seconds = widget.duration;
      _isRunning = true;
    });
  }

  void _restartTimer() {
    _reset();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, size: 40),
              onPressed: widget.onPrevious,
            ),
            SizedBox(width: 20),
            Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.arrow_forward, size: 40),
              onPressed: widget.onNext,
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 40),
              onPressed: _pauseOrResume,
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.replay, size: 40),
              onPressed: _reset,
            ),
          ],
        ),
      ],
    );
  }
}
