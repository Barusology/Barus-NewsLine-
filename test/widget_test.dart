import 'package:flutter_test/flutter_test.dart';

import 'package:barus_newsline/main.dart';

void main() {
  testWidgets('App renders title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Barus NewsLine'), findsOneWidget);
  });
}
