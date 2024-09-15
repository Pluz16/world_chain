import 'package:flutter/material.dart';
import 'select_country_screen.dart'; // Importiamo la schermata che implementeremo per la selezione del paese

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key}) : super(key: key);

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
                // Naviga alla schermata di selezione del paese
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCountryScreen(),
                  ),
                );
              },
              child: const Text('Seleziona Stato e Inizia'),
            ),
          ],
        ),
      ),
    );
  }
}
