import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupprimerRedacteurPage extends StatelessWidget {
  final String redacteurId;
  final String nomRedacteur;

  const SupprimerRedacteurPage({
    super.key,
    required this.redacteurId,
    required this.nomRedacteur,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleBoutonSuppression = ElevatedButton.styleFrom(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation de suppression'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Êtes-vous sûr de vouloir supprimer le rédacteur "$nomRedacteur" ?',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: styleBoutonSuppression,
              onPressed: () => _supprimerRedacteur(context),
              child: const Text('Supprimer le rédacteur'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _supprimerRedacteur(BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('redacteurs')
        .doc(redacteurId)
        .delete();

    if (context.mounted) {
      _afficherSuccesDialog(context);
    }
       } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la suppression : $e')),
      );
    }
  }
}


  void _afficherSuccesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Suppression réussie'),
        content: const Text('Le rédacteur a été supprimé avec succès.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme la boîte de dialogue
              Navigator.of(context).pop(); // Retour à la page précédente
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
