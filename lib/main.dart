import 'package:flutter/material.dart';
import 'player_setup_screen.dart'; // Assicurati che sia importato correttamente

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Reaction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Benvenuto in World Reaction!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviga alla schermata di configurazione giocatori
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerSetupScreen(),
                  ),
                );
              },
              child: const Text('Configura Giocatori e Inizia'),
            ),
          ],
        ),
      ),
    );
  }
}
