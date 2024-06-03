import 'package:flutter/material.dart';

import 'Pages/Language_Translation.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator Application',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslation(),
    );
  }
}
