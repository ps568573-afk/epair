import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/models/models.dart';
import 'features/customer/customer_app.dart';
import 'features/partner/partner_panel.dart';
import 'features/admin/admin_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EpairApp());
}

class EpairApp extends StatefulWidget {
  const EpairApp({super.key});

  @override
  State<EpairApp> createState() => _EpairAppState();
}

class _EpairAppState extends State<EpairApp> {
  AppMode _appMode = AppMode.customer;

  void _changeMode(AppMode mode) {
    setState(() {
      _appMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_appMode) {
      case AppMode.customer:
        currentScreen = CustomerApp(
          onAppModeChanged: _changeMode,
        );
        break;

      case AppMode.partner:
        currentScreen = const PartnerPanel();
        break;

      case AppMode.admin:
        currentScreen = AdminScaffold(
          onReturnToCustomer: () => _changeMode(AppMode.customer),
        );
        break;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ePair',
      home: currentScreen,
    );
  }
}