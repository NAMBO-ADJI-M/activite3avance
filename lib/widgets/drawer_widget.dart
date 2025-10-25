import 'package:flutter/material.dart';

// Widget personnalisé pour le menu latéral (Drawer)
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Supprime les marges par défaut
        children: [
          // En-tête du Drawer avec fond rose
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(
              child: Text(
                'Menu principal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          // Lien vers la page d'ajout de rédacteur
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Ajouter un Rédacteur'),
            onTap: () {
              Navigator.pushNamed(context, '/Ajouter un Rédacteur');
            },
          ),

          // Lien vers la page d'informations des rédacteurs
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Informations des rédacteurs'),
            onTap: () {
              Navigator.pushNamed(context, '/Informations Rédacteur');
            },
          ),

          // Option de déconnexion (à implémenter plus tard)
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context); // Ferme le Drawer
              
            },
          ),
        ],
      ),
    );
  }
}
