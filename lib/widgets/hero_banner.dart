import 'package:flutter/material.dart';

import '../models/destination.dart';

class HeroBanner extends StatelessWidget {
  final Destination destination;

  const HeroBanner({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),

      child: SizedBox(
        height: 200,

        child: Stack(
          fit: StackFit.expand,

          children: [
            // Couche 1 : l'image

            Image.asset(destination.image, fit: BoxFit.cover),

            // Couche 2 : dégradé pour la lisibilité du texte blanc
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,

                  end: Alignment.bottomCenter,

                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),

            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      destination.note.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // TODO 1 : Positioned(top: 16, right: 16) contenant un badge blanc

            //          arrondi : étoile ambre + note de la destination
            Positioned(
              left: 20,
              right: 130,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DESTINATION DU MOIS',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    destination.nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 14,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          destination.region,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // TODO 2 : Positioned(left: 20, right: 130, bottom: 20) contenant

            //          une Column : 'DESTINATION DU MOIS', le nom, la région
            Positioned(
              right: 12,
              bottom: 20,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Découverte de ${destination.nom}')),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF007C80),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Découvrir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
