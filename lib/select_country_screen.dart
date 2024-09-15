import 'package:flutter/material.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista di stati fittizi per iniziare
    final List<String> countries = [
      'Italy',
      'France',
      'Germany',
      'Spain',
      'Greece'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleziona Stato'),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index]),
            onTap: () {
              // Quando uno stato è selezionato, ritorna il nome del paese
              Navigator.pop(context, countries[index]);
            },
          );
        },
      ),
    );
  }
}
