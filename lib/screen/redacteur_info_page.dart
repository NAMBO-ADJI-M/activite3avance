import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'modifier_redacteur_page.dart';
import 'supprimer_redacteur_page.dart';

class RedacteurInfoPage extends StatelessWidget {
  const RedacteurInfoPage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations des Rédacteurs'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('redacteurs').snapshots(),
        builder: (context, snapshot) {
          // Gérer les erreurs
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue.'));
          }

          // Afficher un indicateur de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Gérer le cas où il n'y a pas de données
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucun rédacteur trouvé.'));
          }

          final redacteurs = snapshot.data!.docs;

          // Construire la liste
          return ListView.builder(
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final redacteur = redacteurs[index];
              final redacteurData = redacteur.data() as Map<String, dynamic>;
              final redacteurId = redacteur.id;

              final nom = redacteurData['nom'] ?? 'Nom non disponible';
              final specialite =
                  redacteurData['specialite'] ?? 'Spécialité non disponible';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                child: ListTile(
                  title: Text(nom,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(specialite),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModifierRedacteurPage(
                                redacteurId: redacteurId,
                                redacteurData: redacteurData,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SupprimerRedacteurPage(
                                redacteurId: redacteurId,
                                redacteurData: redacteurData,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
