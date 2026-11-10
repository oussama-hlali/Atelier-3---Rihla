import 'package:flutter/material.dart';

import '../models/avis.dart';
import '../models/destination.dart';

class AvisScreen extends StatefulWidget {
  final Destination destination;

  const AvisScreen({super.key, required this.destination});

  @override
  State<AvisScreen> createState() => _AvisScreenState();
}

class _AvisScreenState extends State<AvisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _prenomCtrl = TextEditingController();
  final _commentaireCtrl = TextEditingController();
  int _note = 0;
  bool _noteManquante = false;
  @override
  void dispose() {
    _prenomCtrl.dispose();
    _commentaireCtrl.dispose();
    super.dispose();
  }

  String? _validerPrenom(String? v) {
    if (v == null || v.trim().length < 2) return 'Au moins 2 caractères';
    return null;
  }

  String? _validerCommentaire(String? v) {
    if (v == null || v.trim().length < 20) return 'Au moins 20 caractères';
    return null;
  }

  void _publier() {
    final formOk = _formKey.currentState!.validate();
    final noteOk = _note > 0;
    setState(() => _noteManquante = !noteOk);
    if (!formOk || !noteOk) return;

    Navigator.pop(
      context,
      Avis(
        auteur: _prenomCtrl.text.trim(),
        note: _note,
        commentaire: _commentaireCtrl.text.trim(),
      ),
    );
  }

  Widget _etoiles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        return IconButton(
          tooltip: '${i + 1} étoile${i == 0 ? '' : 's'}',
          onPressed: () => setState(() {
            _note = i + 1;
            _noteManquante = false;
          }),
          icon: Icon(
            i < _note ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 36,
          ),
        );
      }),
    );
  }

  InputDecoration _deco(String label, {IconData? icone}) {
    return InputDecoration(
      labelText: label,
      alignLabelWithHint: true,
      prefixIcon: icone == null ? null : Icon(icone),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Avis sur ${widget.destination.nom}')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Votre note',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _etoiles(),
              if (_noteManquante)
                Text(
                  'Choisissez une note',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.error, fontSize: 12),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prenomCtrl,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: _deco('Votre prénom', icone: Icons.person_outline),
                validator: _validerPrenom,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentaireCtrl,
                maxLines: 4,
                maxLength: 300, // affiche le compteur x/300
                decoration: _deco('Votre commentaire'),
                validator: _validerCommentaire,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _publier,
                style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
                icon: const Icon(Icons.send),
                label: const Text('Publier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
