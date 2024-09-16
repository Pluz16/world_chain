import 'package:flutter/material.dart';
import 'select_country_screen.dart'; // Importiamo la schermata per selezionare il paese

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome del Giocatore'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final country = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCountryScreen(),
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
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && selectedCountry != null) {
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
