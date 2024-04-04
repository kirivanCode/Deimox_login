import 'package:flutter/material.dart';
import 'package:daimox_login/models/exercise.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  ExerciseTile({required this.exercise, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exercise.name),
      subtitle: Text(exercise.description),
      onTap: onTap,
    );
  }
}
