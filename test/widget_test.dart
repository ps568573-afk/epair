import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epairsuyash/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const EpairApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
