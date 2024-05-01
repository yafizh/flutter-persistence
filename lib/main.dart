import 'package:flutter/material.dart';
import 'package:persistence/note_page.dart';
import 'package:persistence/shared_preference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/shared-preferences': (context) => const ToggleTheme(),
      '/sqlite': (context) => const NotePage()
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shared-preferences');
                },
                child: const Text('Go to shared preference page')),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sqlite');
                },
                child: const Text('Go to sqlite page')),
          ],
        ),
      ),
    );
  }
}
