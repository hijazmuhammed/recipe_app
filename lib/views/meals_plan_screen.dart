import 'package:flutter/material.dart';

class MealsPlanScreen extends StatefulWidget {
  const MealsPlanScreen({super.key});

  @override
  State<MealsPlanScreen> createState() => _MealsPlanScreenState();
}

class _MealsPlanScreenState extends State<MealsPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Cook yourself',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),),
    );
  }
}