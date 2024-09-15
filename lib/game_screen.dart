import 'package:flutter/material.dart';
import 'player_setup_screen.dart'; // Importa se necessario

class GameScreen extends StatelessWidget {
  final List<Player> players;

  const GameScreen({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gioco Iniziato'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${players[index].name} - Stato: ${players[index].country}'),
          );
        },
      ),
    );
  }
}
