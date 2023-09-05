import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/onboarding.dart';
import 'package:whatsapp_status_saver/providers/files_provider.dart';
import 'package:whatsapp_status_saver/services/onboarding_settings.dart';
import 'package:whatsapp_status_saver/views/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OnboardingPreference.initOnboardingPrefs();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FilesProvider(),
          )
        ],
        child: OnboardingPreference.isFirstTime()
          ? const OnboardingScreen()
          : const Home(),
      ),
    ),
  );
}
