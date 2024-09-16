import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EuropeMapScreen extends StatefulWidget {
  const EuropeMapScreen({Key? key}) : super(key: key);

  @override
  _EuropeMapScreenState createState() => _EuropeMapScreenState();
}

class _EuropeMapScreenState extends State<EuropeMapScreen> {
  // Variabile per tenere traccia dello stato selezionato
  String? selectedCountry;

  // Funzione per gestire la selezione dello stato
  void _onCountryTapped(String countryId) {
    setState(() {
      selectedCountry = countryId;
    });
    // Puoi aggiungere qui la logica per collegare lo stato selezionato al giocatore
    print('Hai selezionato $countryId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleziona uno Stato'),
      ),
      body: Center(
        child: SvgPicture.asset(
          'assets/europe_map.svg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.contain,
          semanticsLabel: 'Mappa dell\'Europa',
          // Qui puoi gestire i tocchi sulle regioni dello SVG
          allowDrawingOutsideViewBox: true,
          placeholderBuilder: (context) => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
