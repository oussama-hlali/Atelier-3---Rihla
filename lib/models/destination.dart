/// Modèle d'une destination touristique.
/// Tous les champs sont `final` : une destination ne change pas après sa création.
class Destination {
  final String nom;
  final String region;
  final String categorie; // 'Plage', 'Désert' ou 'Patrimoine'
  final String image; // chemin de l'image dans assets/
  final double note; // sur 5
  final int prix; // en dinars, par personne
  final String duree;
  final String description;

  const Destination({
    required this.nom,
    required this.region,
    required this.categorie,
    required this.image,
    required this.note,
    required this.prix,
    required this.duree,
    required this.description,
  });
}
