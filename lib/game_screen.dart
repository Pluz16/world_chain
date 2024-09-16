import 'package:flutter/material.dart';
import 'player.dart'; // Importa la classe Player dal nuovo file

class GameScreen extends StatelessWidget {
  final List<Player> players;

  const GameScreen({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gioco Iniziato'),
      ),
      body: Column(
        children: [
          const Text('Giocatori in gioco:', style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${players[index].name} - Stato: ${players[index].country}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
