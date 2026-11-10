import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../widgets/favorite_button.dart';
import 'reservation_screen.dart';
import '../models/reservation.dart';
import '../models/avis.dart';
import 'avis_screen.dart';

class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _voyageurs = 2;
  final List<Avis> _avis = [];

  Future<void> _reserver() async {
    final reservation = await Navigator.push<Reservation>(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationScreen(
          destination: widget.destination,
          voyageurs: _voyageurs,
        ),
      ),
    );

    if (reservation == null) return;

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Réservation confirmée'),

        content: Text(
          '${reservation.nom}, votre voyage à '
          '${reservation.destination.nom} est réservé.\n\n'
          'Voyageurs : ${reservation.voyageurs}\n'
          'Formule : ${reservation.formule}\n'
          'Total : ${reservation.total} DT\n\n'
          'Une confirmation sera envoyée à ${reservation.email}.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Parfait'),
          ),
        ],
      ),
    );
  }

  Future<void> _laisserAvis() async {
    final avis = await Navigator.push<Avis>(
      context,
      MaterialPageRoute(
        builder: (context) => AvisScreen(destination: widget.destination),
      ),
    );
    if (avis == null) return;
    if (!mounted) return;
    setState(() => _avis.insert(0, avis));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Merci pour votre avis !')));
  }

  Widget _etoilesAvis(int note) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < note ? Icons.star : Icons.star_border,
          size: 16,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _carteAvis(Avis a) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  child: Text(a.auteur[0].toUpperCase()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    a.auteur,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _etoilesAvis(a.note),
              ],
            ),
            const SizedBox(height: 8),
            Text(a.commentaire),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 340,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'image-${destination.nom}',
                      child: Image.asset(destination.image, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          tooltip: 'Retour',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: FavoriteButton(),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                destination.nom,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.place, size: 16),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(destination.region)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: cs.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                destination.note.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _infoTile(
                            icon: Icons.access_time,
                            titre: 'Durée',
                            valeur: '4 jours',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _infoTile(
                            icon: Icons.category_outlined,
                            titre: 'Type',
                            valeur: destination.categorie,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _infoTile(
                            icon: Icons.groups_outlined,
                            titre: 'Groupe',
                            valeur: 'Max 12',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'À propos',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      destination.description,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Voyageurs',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton.outlined(
                          onPressed: _voyageurs > 1
                              ? () {
                                  setState(() {
                                    _voyageurs--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 12),
                        Text('$_voyageurs', style: theme.textTheme.titleMedium),
                        const SizedBox(width: 12),
                        IconButton.outlined(
                          onPressed: () {
                            setState(() {
                              _voyageurs++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Avis (${_avis.length})',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _laisserAvis,
                          icon: const Icon(Icons.rate_review_outlined),
                          label: const Text('Laisser un avis'),
                        ),
                      ],
                    ),
                    if (_avis.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Soyez le premier à donner votre avis.'),
                      )
                    else
                      ..._avis.map(_carteAvis),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: cs.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: theme.textTheme.bodySmall),
                    Text(
                      '${destination.prix * _voyageurs} DT',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: _reserver,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
                  child: const Text('Réserver'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String titre,
    required String valeur,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 82),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 5),
          Text(titre, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 3),
          Text(
            valeur,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
