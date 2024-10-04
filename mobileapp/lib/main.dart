import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'src/generated/helloworld.pbgrpc.dart';
import 'dart:developer' as devLog;



// Implémentation du service HelloWorldService
class HelloWorldService extends HelloWorldServiceBase {
  // Méthode qui gère la requête gRPC SayHello
  @override
  Future<HelloResponse> sayHello(ServiceCall call, HelloRequest request) async {
    // Dictionnaire des messages dans différentes langues
    final messages = {
      'fr': 'Bonjour tout le monde from mobile application',
      'en': 'Hello world from mobile ',
      'ar': 'مرحبا بالعالم',
    };

    // Récupérer la langue demandée et renvoyer le message correspondant
    final message = messages[request.language] ?? 'Language not supported';

    // Retourner la réponse avec le message approprié
    return HelloResponse()..message = message;
  }
}

// Fonction pour démarrer le serveur gRPC
Future<void> startGrpcServer() async {
  // Créer le serveur gRPC
  final server = Server([HelloWorldService()]);

  // Démarrer le serveur sur le port 9999
  try {
    await server.serve(port: 9999);
    print('Serveur gRPC en cours d\'exécution sur le port ${server.port}...');
  } catch (e) {
    print('Erreur lors du démarrage rdu serveur gRPC: $e');
  }
}

void main() {
  // Démarrer le serveur gRPC en arrière-plan
  startGrpcServer();

  // Démarrer l'application Flutterr
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gRPC Server in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gRPC Server'),
      ),
      body: Center(
        child: Text('Le serveur gRPC fonctionne en arrière-plan.'),
      ),
    );
  }
}
