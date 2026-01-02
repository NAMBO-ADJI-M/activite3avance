import 'screen/ajout_redacteur_page.dart';
import 'screen/redacteur_info_page.dart';
import 'package:flutter/material.dart'; // Widgets Flutter
import 'package:firebase_core/firebase_core.dart' as firebase_core; // Initialisation Firebase

// Widgets personnalisés
import 'widgets/drawer_widget.dart';
import 'widgets/partie_icone.dart';
import 'widgets/partie_rubrique.dart';
import 'widgets/partie_texte.dart';
import 'widgets/partie_titre.dart';

// Écrans de navigation
//import 'screens/ajout_redacteur_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp(); // Initialisation Firebase
  runApp(const MonAppli());
}

// Widget racine
class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazines',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PageAccueil(),
        '/Ajouter un Rédacteur': (context) => const AjoutRedacteurPage(),
        '/Informations Rédacteur': (context) => RedacteurInfoPage(), // const retiré ici
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily:
            'poppins', // Assure-toi que la police est bien déclarée dans pubspec.yaml
      ),
    );
  }
}

// Page d'accueil
class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Magazines Infos',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: 'Rechercher',
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/magazines.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const PartieTitre(),
            const PartieTexte(),
            const PartieIcone(),
            const PartieRubrique(),
          ],
        ),
      ),
    );
  }
}
