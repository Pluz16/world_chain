import 'package:flutter/material.dart';
import 'add_player_screen.dart'; // Importiamo la schermata per aggiungere giocatori
import 'game_screen.dart'; // Importiamo la schermata di gioco

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  _PlayerSetupScreenState createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  List<Player> players = [];

  int maxPlayers = 4;

  void addPlayer(String name, String country) {
    if (players.length < maxPlayers) {
      setState(() {
        players.add(Player(name: name, country: country));
      });
    }
  }

  void startGame() {
    if (players.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(players: players),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurazione Giocatori'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${players[index].name} - ${players[index].country}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final newPlayer = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPlayerScreen(),
                ),
              );
              if (newPlayer != null) {
                addPlayer(newPlayer['name'], newPlayer['country']);
              }
            },
            child: const Text('Aggiungi Giocatore'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: startGame,
            child: const Text('Inizia il Gioco'),
          ),
        ],
      ),
    );
  }
}

class Player {
  final String name;
  final String country;

  Player({required this.name, required this.country});
}
