import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/models/models.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
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

class EpairApp extends StatelessWidget {
  const EpairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePair - Electronics Repair',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  AppMode _appMode = AppMode.customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Brand bar at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 4,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.epairRed,
                    AppColors.epairNavy,
                    AppColors.epairYellow,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildModeContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildModeContent() {
    switch (_appMode) {
      case AppMode.customer:
        return CustomerApp(
          onAppModeChanged: (mode) => setState(() => _appMode = mode),
        );
      case AppMode.partner:
        return PartnerPanel(
          onAppModeChanged: (mode) => setState(() => _appMode = mode),
        );
      case AppMode.admin:
        return AdminScaffold(
          onReturnToCustomer: () =>
              setState(() => _appMode = AppMode.customer),
        );
    }
  }
}