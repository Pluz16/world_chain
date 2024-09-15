import 'package:flutter/material.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creiamo una lista di stati fittizi per iniziare
    final List<String> countries = ['Italy', 'France', 'Germany', 'Spain', 'Greece'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleziona il tuo Stato'),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index]),
            onTap: () {
              // Quando selezioni un paese, possiamo navigare alla schermata di gioco (da implementare)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(selectedCountry: countries[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String selectedCountry;

  const GameScreen({Key? key, required this.selectedCountry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gioco: $selectedCountry'),
      ),
      body: Center(
        child: Text('Hai scelto $selectedCountry. Inizia a giocare!'),
      ),
    );
  }
}
