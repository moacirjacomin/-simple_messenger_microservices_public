

import 'package:flutter/material.dart';

class AppConfig {
  const AppConfig();

  String get appName => 'Simple Messenger';

  String get defaultLocal => 'pt_BR';

  List<Languages> get languages => Languages.values;
}

enum Languages {
  ptBr(
    'pt_BR',
    'Portugues',
    Locale('pt', 'BR'),
  ),
  enUS(
    'en_US',
    'Portugues',
    Locale('en', 'US'),
  );
 

  final String acronym;
  final String name;
  final Locale locale;

  const Languages(this.acronym, this.name, this.locale);

  static Languages? findByAcronym(String acronym){
    final lang = Languages.values.where((element) => acronym.contains(element.acronym));

    if(lang.isNotEmpty){
      return lang.first;
    }

    return null;
  }
}