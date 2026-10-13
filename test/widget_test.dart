import 'package:flutter_test/flutter_test.dart';
import 'package:rihla/main.dart';

void main() {
  testWidgets('Rihla affiche son écran d’accueil', (WidgetTester tester) async {
    await tester.pumpWidget(const RihlaApp());

    expect(find.text('Rihla arrive bientôt…'), findsOneWidget);
  });
}
