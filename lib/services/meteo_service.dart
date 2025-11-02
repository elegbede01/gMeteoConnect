//import 'package:flutter/material.dart';
import 'dart:convert'; // Pour json.decode
import 'package:http/http.dart' as http;

import 'package:activiteaccesapi/Models/meteo_model.dart';

class MeteoService {
  //Remplace  et initialise la clé de l'API
  static const String apiKey = 'a740d1ce4d1eb6af615a2ecf49412ec3';

  //Fonction qui construit l’URL
  static String construisMeteoUrl(String ville) {
    return 'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$apiKey&units=metric&lang=fr';
  }

  //Fonction pour recuperer la meteo
  static Future<MeteoModel?> fetchMeteo(String ville) async {
    try {
      final response = await http.get(Uri.parse(construisMeteoUrl(ville)));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MeteoModel.fromJson(data);
      } else {
        print('Erreur API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur de connexion: $e');
      return null;
    }
  }
}
