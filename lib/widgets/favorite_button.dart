import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  // TODO 1 : état local du favori
  bool _favori = false;

  void _basculer() {
    // TODO 2 : inverser l'état
    setState(() {
      _favori = !_favori;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_favori ? 'Ajouté aux favoris' : 'Retiré des favoris'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO 3 : bouton avec retour visuel
    return IconButton(
      onPressed: _basculer,
      icon: Icon(
        _favori ? Icons.favorite : Icons.favorite_border,
        color: _favori ? Colors.red : Colors.grey,
      ),
    );
  }
}
