import 'package:flutter/material.dart';
import 'package:persistence/shared_preference.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/shared-preferences': (context) => const ToggleTheme(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Persistence Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shared-preferences');
                },
                child: const Text('Go to shared preference page'))
          ],
        ),
      ),
    );
  }
}
