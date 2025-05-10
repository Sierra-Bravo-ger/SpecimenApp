import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/app_theme.dart';
import 'core/database/hive_helper.dart';
import 'data/repositories/test_repository.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  // Stellen Sie sicher, dass Flutter-Bindings initialisiert sind
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setzen Sie die bevorzugte Orientierung auf Hochformat nur für mobile Plattformen
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  // Initialisieren Sie Hive für die lokale Datenspeicherung
  // Hive.initFlutter() wird bereits in HiveHelper().init() aufgerufen
  await HiveHelper().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Stellen Sie das TestRepository für die gesamte App zur Verfügung
        Provider<TestRepository>(
          create: (_) => TestRepository(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light, // Standardmäßig helles Theme verwenden
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('de', 'DE'), // Deutsch
          Locale('en', 'US'), // Englisch
        ],
        locale: const Locale('de', 'DE'), // Standardsprache: Deutsch
        home: const HomeScreen(),
      ),
    );
  }
}
