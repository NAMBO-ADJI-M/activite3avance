// Section avec icônes de contact
import 'package:flutter/material.dart';

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Répartition équitable
        children: [
          Column(
            children: [
              Icon(Icons.phone, size: 50, color: Colors.amber), // Icône téléphone
              SizedBox(height: 10),
              Text('TEL', style: TextStyle(fontSize: 16, color: Colors.amber)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.email, size: 50, color: Colors.amber), // Icône email
              SizedBox(height: 10),
              Text('EMAIL', style: TextStyle(fontSize: 16, color: Colors.amber)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.share, size: 50, color: Colors.amber), // Icône partage
              SizedBox(height: 10),
              Text ('PARTAGE', style: TextStyle(fontSize: 16, color: Colors.amber)),
            ],
          ),
        ],
      ),
    );
  }
}
