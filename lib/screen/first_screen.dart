import 'package:count_down/downcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  final bool useDarmode;
  final VoidCallback toggleTheme;

  const FirstScreen(
      {super.key, required this.useDarmode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange),
        title: const Text('First Screen'),
        actions: [
          IconButton(
              icon: Icon(useDarmode ? Icons.dark_mode : Icons.light_mode),
              onPressed: toggleTheme),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            useDarmode
                ? const Text(
                    'This is the first screen',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(
                    'This is the first screen',
                    style: TextStyle(color: Colors.black),
                  ),
            const SizedBox(height: 30),
            Animate(
              child: ElevatedButton(
                onPressed: () {
                  // Navigera till andra skärmen när knappen trycks
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen()),
                  );
                },
                child: const Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.green),
                ),
              ).animate().slideX(duration: const Duration(milliseconds: 150)).shake(duration: const Duration(milliseconds: 260)),
            ),
          ],
        ),
      ),
    );
  }
}
