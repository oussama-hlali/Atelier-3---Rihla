import 'package:flutter/material.dart';

import '../widgets/home_header.dart';
import '../widgets/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            HomeHeader(prenom: 'Oussama'),
            SizedBox(height: 20),
            SearchBox(),
          ],
        ),
      ),
    );
  }
}
