import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:mobileapp/src/generated/helloworld.pbgrpc.dart';
import 'dart:developer' as devLog;

import 'package:protobuf/protobuf.dart';

import 'main.dart';

// Initial default port
int _port = 9999;
String stateServer = "Le serveur gRPC fonctionne en arrière-plan.";
String? Response;

// Implémentation du service HelloWorldService
class HelloWorldService extends HelloWorldServiceBase {
  final Function updateState;

  // Constructor to pass the state update function
  HelloWorldService(this.updateState);

  @override
  Future<HelloResponse> sayHello(ServiceCall call, HelloRequest request) async {
    // Log message when request is received
    print('Request received: ${request.language}');

    final messages = {
      'fr': 'Flutter dit Bonjour tout le monde',
      'en': 'Flutter say Hello world',
      'ar': 'فلاتر يقول مرحبا بالعالم',
    };

    final message = messages[request.language] ?? 'Language not supported';

    stateServer = 'Request received: ${request.language}';
    Response = 'Response sent is: $message';
    print("Response : $Response");
    updateState(stateServer, Response);
    // Return the appropriate message
    return HelloResponse()..message = message;
  }
}

// Fonction pour démarrer le serveur gRPC
Future<void> startGrpcServer(Function updateState, int port) async {
  final server = Server([HelloWorldService(updateState)]);

  try {
    await server.serve(port: port);
    print('Serveur gRPC en cours d\'exécution sur le port ${server.port}...');
  } catch (e) {
    print('Erreur lors du démarrage du serveur gRPC: $e');
  }
}

void main() {
  runApp(ServerApp());
}

class ServerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gRPC Server in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _messagerequest = stateServer; // Holds the current server message
  final TextEditingController _portController = TextEditingController(text: _port.toString()); // Controller for port input

  @override
  void initState() {
    super.initState();
    // Start the gRPC server when the app is initialized (with the default port)
    startGrpcServer(updateState, _port);
  }

  // This function is used to update the UI message when a request is received
  void updateState(String newState, String resp) {
    setState(() {
      _messagerequest = newState + " \n" + resp;
    });
  }

  // This function is used to update the port number and restart the server
  void _startServerWithPort() {
    setState(() {
      _port = int.tryParse(_portController.text) ?? 9999; // Convert the input to an integer
      startGrpcServer(updateState, _port); // Restart the server with the new port
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gRPC Server'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            runApp(MyApp()); // Return to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField for the port number input
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _portController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Port Number',
                ),
              ),
            ),
            // Button to start the server with the entered port
            ElevatedButton(
              onPressed: () {
                _startServerWithPort();
                // Show a Snackbar to indicate the port has changed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('gRPC Server is now running on port $_port'),
                    duration: Duration(seconds: 2), // Duration for which the Snackbar is displayed
                  ),
                );
              },
              child: Text('Start Server with Port'),
            ),

            SizedBox(height: 20),
            // Display the message inside a box (Container)
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _messagerequest, // Display the current state message
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
