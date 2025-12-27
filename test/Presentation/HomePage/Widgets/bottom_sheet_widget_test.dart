import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qauth/main.dart';

void main() {
  testWidgets("Testing if all fields are present", (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byKey(Key('fab_btn')));
    await tester.pump();
    expect(find.byKey(Key('title_field')), findsOneWidget);
    expect(find.byKey(Key('key_field')), findsOneWidget);
    expect(find.byKey(Key('issuer_field')), findsOneWidget);
    await tester.tap(find.byKey(Key('add_btn')), warnIfMissed: false);
    await tester.pump();
  });
}
