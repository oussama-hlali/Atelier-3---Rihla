import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: cs.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Rechercher une destination',
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ),
          Icon(Icons.tune, color: cs.primary),
        ],
      ),
    );
  }
}
