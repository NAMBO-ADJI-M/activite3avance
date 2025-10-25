// Section de titre de la page d'accueil
import 'package:flutter/widgets.dart';

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text (
            'Bienvenue au Magazines infos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Votre Magazine numérique, votre source d\'inspirations',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(172, 37, 37, 37), // Couleur grisée
            ),
          ),
        ],
      ),
    );
  }
}

