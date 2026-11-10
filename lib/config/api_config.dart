import 'package:flutter/foundation.dart';

/// TP5 — Adresse du serveur json-server.
///
/// « localhost » désigne la machine sur laquelle tourne l'application :
///  - Chrome / Windows : c'est votre PC, donc localhost fonctionne.
///  - Émulateur Android : c'est l'émulateur lui-même ! Le PC est joignable
///    par l'adresse spéciale 10.0.2.2.
///  - Téléphone réel (même Wi-Fi) : utiliser l'adresse IP du PC
///    (ex. http://192.168.1.20:3000) et lancer
///    `npx json-server db.json --host 0.0.0.0`.
class ApiConfig {
  static const int port = 3000;

  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:$port';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:$port';
    }
    return 'http://localhost:$port';
  }

  /// Durée maximale d'attente d'une réponse.
  static const Duration timeout = Duration(seconds: 8);
}
