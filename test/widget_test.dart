import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_ovens_secret/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const TheOvensSecretApp());
    expect(find.text('The Ovens Secret'), findsWidgets);
  });
}
