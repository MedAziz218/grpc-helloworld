import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:mobileapp/src/generated/helloworld.pbgrpc.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final TextEditingController _ipController = TextEditingController(text: '192.168.1.68'); // Default value
  final TextEditingController _portController = TextEditingController(text: '9999'); // Default value
  String _responseMessage = '';
  String _selectedLanguage = 'fr'; // Default selected language
  final List<String> _languages = ['fr', 'en', 'ar']; // Available languages

  Future<void> _sendRequest() async {
    final String ipAddress = _ipController.text;
    final int port = int.tryParse(_portController.text) ?? 9999; // Default to 9999 if parsing fails

    final channel = ClientChannel(
      ipAddress,
      port: port,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    final stub = HelloWorldServiceClient(channel);
    final request = HelloRequest()..language = _selectedLanguage;

    try {
      final response = await stub.sayHello(request);
      setState(() {
        _responseMessage = response.message; // Update response message
      });
    } catch (e) {
      setState(() {
        _responseMessage = 'Error: $e'; // Handle errors
      });
    } finally {
      await channel.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gRPC Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'Enter IP Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Port',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              decoration: InputDecoration(
                labelText: 'Select Language',
                border: OutlineInputBorder(),
              ),
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!; // Update selected language
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendRequest,
              child: Text('Send Request'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Response: $_responseMessage',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
