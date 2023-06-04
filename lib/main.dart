import 'package:classify/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حصص المدرسة',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'open_sans',
      ),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      locale: Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
