import 'package:flutter/material.dart';
import 'package:rihla/models/destination.dart';

import '../data/destinations.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../widgets/section_title.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = "Tout";
  int _onglet = 0;
  Widget _construireAcceuil() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const HomeHeader(prenom: 'Oussama'),
        const SizedBox(height: 20),

        const SearchBox(),
        const SizedBox(height: 16),

        if (_flitrees.isNotEmpty) HeroBanner(destination: _flitrees.first),

        const SizedBox(height: 24),

        const SectionTitle(title: 'Categories'),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final c in categories)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: _categorie == c,
                    onSelected: (_) {
                      setState(() {
                        _categorie = c;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: 'Destinations populaires'),
        const SizedBox(height: 12),

        for (final destination in _flitrees)
          DestinationCard(
            key: ValueKey(destination.nom),
            destination: destination,
            isFavorite: false,
            onFavoriteToggle: () {},
          ),
      ],
    );
  }

  List<Destination> get _flitrees {
    if (_categorie == "Tout") {
      return destinations;
    }
    return destinations.where((d) => d.categorie == _categorie).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onglet == 0
            ? _construireAcceuil()
            : const Center(child: Text('Bientôt disponible')),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) {
          setState(() {
            _onglet = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
