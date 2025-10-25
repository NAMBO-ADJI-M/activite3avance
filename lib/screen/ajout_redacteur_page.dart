import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AjoutRedacteurPage extends StatefulWidget {
  const AjoutRedacteurPage({super.key});

  @override
  State<AjoutRedacteurPage> createState() => _AjoutRedacteurPageState();
}

class _AjoutRedacteurPageState extends State<AjoutRedacteurPage> {
  // 🔧 Contrôleurs et clé de formulaire
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();

  // 🎨 Style du bouton
  final ButtonStyle styleBouton = ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Rédacteur'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Ferme le clavier
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _nomController,
                  label: 'Nom du rédacteur',
                  validatorMessage: 'Veuillez entrer un nom',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _specialiteController,
                  label: 'Spécialité du rédacteur',
                  validatorMessage: 'Veuillez entrer une spécialité',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: styleBouton,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _ajouterRedacteur();
                    }
                  },
                  child: const Text('Ajouter le rédacteur'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧩 Widget champ de texte réutilisable
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorMessage,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? validatorMessage : null,
    );
  }

  // 📤 Ajout du rédacteur dans Firestore
  Future<void> _ajouterRedacteur() async {
    final nom = _nomController.text.trim();
    final specialite = _specialiteController.text.trim();

    if (nom.isEmpty || specialite.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs');
      return;
    }

    try {
      final existant = await FirebaseFirestore.instance
          .collection('redacteurs')
          .where('nom', isEqualTo: nom)
          .get();

      if (!mounted) return;

      if (existant.docs.isNotEmpty) {
        _showSnackBar('Le rédacteur "$nom" existe déjà');
        return;
      }

      await FirebaseFirestore.instance.collection('redacteurs').add({
        'nom': nom,
        'specialite': specialite,
      });

      if (!mounted) return;
      _afficherSuccesDialog();
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Erreur lors de l’ajout : $e');
    }
  }

  // ✅ Boîte de dialogue de succès
  void _afficherSuccesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajout réussi'),
        content: const Text('Le rédacteur a été ajouté avec succès.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialog
              Navigator.of(context).pop(); // Retour à la page précédente
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // 🔔 Affichage d’un message SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }
}
