import '../models/destination.dart';

/// Catégories affichées sous forme de puces (ChoiceChip).
const List<String> categories = ['Tout', 'Plage', 'Désert', 'Patrimoine'];

/// Données de démonstration (fichier fourni, à copier tel quel).
const List<Destination> destinations = [
  Destination(
    nom: 'Sidi Bou Saïd',
    region: 'Tunis',
    categorie: 'Patrimoine',
    image: 'assets/images/sidi_bou_said.png',
    note: 4.9,
    prix: 180,
    duree: '1 jour',
    description:
        'Village perché au-dessus du golfe de Tunis, célèbre pour ses maisons '
        'blanches aux portes bleues, ses ruelles fleuries et le café des Délices.',
  ),
  Destination(
    nom: 'Djerba',
    region: 'Médenine',
    categorie: 'Plage',
    image: 'assets/images/djerba.png',
    note: 4.8,
    prix: 420,
    duree: '4 jours',
    description:
        "L'île des rêves : plages de sable fin, eaux turquoise, villages "
        'traditionnels et la Djerba Explore pour toute la famille.',
  ),
  Destination(
    nom: 'Tozeur',
    region: 'Tozeur',
    categorie: 'Désert',
    image: 'assets/images/tozeur.png',
    note: 4.7,
    prix: 350,
    duree: '3 jours',
    description:
        "Porte du Sahara : palmeraie de plus de 400 000 palmiers, médina en "
        'briques ocre et couchers de soleil sur le chott El Djérid.',
  ),
  Destination(
    nom: 'El Jem',
    region: 'Mahdia',
    categorie: 'Patrimoine',
    image: 'assets/images/el_jem.png',
    note: 4.8,
    prix: 120,
    duree: '1 jour',
    description:
        "L'un des plus grands amphithéâtres romains au monde, inscrit au "
        "patrimoine mondial de l'UNESCO, et son festival de musique symphonique.",
  ),
  Destination(
    nom: 'Douz',
    region: 'Kébili',
    categorie: 'Désert',
    image: 'assets/images/douz.png',
    note: 4.6,
    prix: 390,
    duree: '3 jours',
    description:
        'Balade à dos de dromadaire, nuit sous tente et dunes à perte de vue : '
        "l'expérience saharienne par excellence.",
  ),
  Destination(
    nom: 'Hammamet',
    region: 'Nabeul',
    categorie: 'Plage',
    image: 'assets/images/hammamet.png',
    note: 4.5,
    prix: 260,
    duree: '2 jours',
    description:
        'Médina fortifiée au bord de la mer, jardins de jasmin et longues '
        'plages : la station balnéaire historique du Cap Bon.',
  ),
];
