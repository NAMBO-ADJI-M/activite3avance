// Section de texte explicatif
import 'package:flutter/material.dart';

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Text(
        'Magazines Infos est bien plus qu\'une simple magazine d\'informations. C\'est votre passerelle vers le monde, une source inestimable de connaissances et d\'actualités soigneusement selectionnés pour vous éclairer sur les enjeux mondiaux,la culture, la science, la et voir même le divertissement(les jeux). ',
      ),
    );
  }
}
