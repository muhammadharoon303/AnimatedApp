import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animation/main.dart';

void main() {
  testWidgets('LuxuryHotelApp smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const LuxuryHotelApp());
    await tester.pump();

    // Verify bottom navigation tabs and food menu header
    expect(find.text('Food Menu'), findsWidgets);
    expect(find.text('Hotel Suites'), findsWidgets);
    expect(find.text('Artisan Lounge'), findsWidgets);
    expect(find.text('The Grand Restaurant Menu'), findsOneWidget);
  });
}
