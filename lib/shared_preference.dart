import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  bool _isDark = false;

  String getTheme() {
    return _isDark ? 'Dark' : 'Light';
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = prefs.getBool('theme') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Shared Preferences'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Theme: ${getTheme()}', textAlign: TextAlign.center),
            ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _isDark = !_isDark;
                    prefs.setBool('theme', _isDark);
                  });
                },
                child: const Text("Toggle Theme"))
          ]),
        ));
  }
}
