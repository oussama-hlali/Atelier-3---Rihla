import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // pour inputFormatters

import '../models/destination.dart';
import '../models/reservation.dart';

class ReservationScreen extends StatefulWidget {
  final Destination destination;
  final int voyageurs;

  const ReservationScreen({
    super.key,
    required this.destination,
    required this.voyageurs,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();

  @override
  void dispose() {
    // TODO 1 : libérer les trois contrôleurs, puis super.dispose()
    _nomCtrl.dispose();
    _emailCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  InputDecoration _deco(String label, IconData icone, {String? aide}) {
    return InputDecoration(
      labelText: label,
      helperText: aide,
      prefixIcon: Icon(icone),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  String? _validerNom(String? v) {
    if (v == null || v.trim().isEmpty) return 'Indiquez votre nom';
    if (v.trim().length < 3) return 'Au moins 3 caractères';
    return null;
  }

  String? _validerEmail(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Indiquez votre e-mail';
    }

    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v.trim())) {
      return 'E-mail invalide (ex. : nom@mail.tn)';
    }

    return null;
  }

  String? _validerTel(String? v) {
    // TODO 3 : vide -> 'Indiquez votre téléphone'
    //          longueur différente de 8 -> '8 chiffres attendus'
    if (v == null || v.trim().isEmpty) {
      return 'Indiquez votre téléphone';
    }
    if (!RegExp(r'^\d{8}$').hasMatch(v.trim())) {
      return '8 chiffres attendus';
    }
    return null;
  }

  void _valider() {
    if (!_formKey.currentState!.validate()) return;
    // Provisoire : sera remplacé au palier 5
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Formulaire valide')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Réserver')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO 4 : récapitulatif (image 64 x 64, nom, durée, voyageurs)
              Card(
                elevation: 0,
                color: theme.colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          widget.destination.image,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.destination.nom,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              // À ADAPTER : `duree` = le nom réel dans ta classe Destination
                              '${widget.destination.duree} jours · ${widget.voyageurs} voyageur(s)',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // CHANGED: titre de section, comme sur la maquette
              Text(
                'Vos coordonnées',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomCtrl,
                decoration: _deco('Nom complet', Icons.person_outline),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: _validerNom,
              ),
              const SizedBox(height: 16),
              // TODO 5 : champ E-mail (clavier emailAddress)
              // TODO 6 : champ Téléphone (clavier phone, chiffres seulement,
              //          8 maximum, texte d'aide '8 chiffres, sans indicatif')

              TextFormField(
                controller: _emailCtrl,
                decoration: _deco('E-mail', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validerEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telCtrl,
                decoration: _deco(
                  'Téléphone',
                  Icons.phone_outlined,
                  aide: '8 chiffres, sans indicatif',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                validator: _validerTel,
              ),
            ],
          ),
        ),
      ),
      // TODO 7 : bottomNavigationBar avec un FilledButton.icon « Confirmer »
      //          qui appelle _valider (inspirez-vous de la barre du détail)

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _valider,
            icon: const Icon(Icons.check),
            label: const Text('Confirmer'),
          ),
        ),
      ),
    );
  }
}
