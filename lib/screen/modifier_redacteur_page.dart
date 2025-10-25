import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModifierRedacteurPage extends StatefulWidget {
  final String redacteurId;
  final Map<String, dynamic> redacteurData;

  const ModifierRedacteurPage({
    super.key,
    required this.redacteurId,
    required this.redacteurData,
  });

  @override
  State<ModifierRedacteurPage> createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nomController;
  late TextEditingController _specialiteController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.redacteurData['nom']);
    _specialiteController = TextEditingController(text: widget.redacteurData['specialite']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le Rédacteur'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: 'Nom du rédacteur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _specialiteController,
              decoration: const InputDecoration(
                labelText: 'Spécialité',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: _enregistrerModifications,
              child: const Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _enregistrerModifications() async {
    final String nouveauNom = _nomController.text.trim();
    final String nouvelleSpecialite = _specialiteController.text.trim();

    final Map<String, dynamic> modifications = {
      'nom': nouveauNom,
      'specialite': nouvelleSpecialite,
    };

    try {
      await _firestore.collection('redacteurs').doc(widget.redacteurId).update(modifications);
      _afficherSuccesDialog();
    } catch (e) {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la modification : $e')),
      );
    }
  }

  void _afficherSuccesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modification réussie'),
        content: const Text('Les informations du rédacteur ont été mises à jour.'),
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

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }
}
