import 'package:flutter/material.dart';

import 'Serverpage.dart' as server;
import 'clientpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client-Server App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to client page or perform client-specific logic
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientPage()),
                );
                print('Client button pressed');
              },
              child: Text('Client'),
            ),
            SizedBox(height: 20), // Adds space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to server page or perform server-specific logic
                print('Server button pressed');
                server.main();
              },
              child: Text('Server'),
            ),
          ],
        ),
      ),
    );
  }
}
