import 'package:flutter/material.dart';
import 'europe_map_screen.dart'; // Assicurati di importare la schermata della mappa

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({Key? key}) : super(key: key);

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Giocatore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input per il nome del giocatore
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome del Giocatore'),
            ),
            const SizedBox(height: 20),
            // Pulsante per selezionare il paese dalla mappa
            ElevatedButton(
              onPressed: () async {
                // Naviga alla schermata della mappa per selezionare uno stato
                final country = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GeoJsonMap(), // Schermata con la mappa
                  ),
                );
                if (country != null) {
                  setState(() {
                    selectedCountry = country;
                  });
                }
              },
              child: Text(selectedCountry == null ? 'Seleziona Stato' : 'Stato: $selectedCountry'),
            ),
            const SizedBox(height: 20),
            // Pulsante per aggiungere il giocatore
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && selectedCountry != null) {
                  // Ritorna il nome e il paese selezionato alla schermata precedente
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'country': selectedCountry,
                  });
                }
              },
              child: const Text('Aggiungi Giocatore'),
            ),
          ],
        ),
      ),
    );
  }
}
