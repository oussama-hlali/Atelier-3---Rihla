import 'destination.dart';

class Reservation {
  final String? id;
  final Destination destination;
  final String nom;
  final String email;
  final String telephone;
  final DateTime dateDepart;
  final int voyageurs;
  final String formule; // 'Essentiel' ou 'Confort'
  const Reservation({
    this.id,
    required this.destination,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.dateDepart,
    required this.voyageurs,
    required this.formule,
  });
  // Formule Confort : +30 % sur le prix par personne.
  int get prixParPersonne => formule == 'Confort'
      ? (destination.prix * 1.3).round()
      : destination.prix;

  int get total => prixParPersonne * voyageurs;

  Map<String, dynamic> toJson() {
    return {
      'destinationId': destination.id, // l'id suffit
      'nom': nom,
      // TODO 1 : email, telephone, voyageurs, formule, total
      'email': email,
      'telephone': telephone,
      'voyageurs': voyageurs,
      'formule': formule,
      'total': total,
      // TODO 2 : dateDepart -> texte avec toIso8601String()
      'dateDepart': dateDepart.toIso8601String(),
    };
  }
}
