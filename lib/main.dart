import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'apps/app.dart';
import 'core/di/service_locator.dart';
import 'features/auth/presentation/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  ServiceLocator.setup();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => ServiceLocator.authProviderInstance,
        ),
      ],
      child: const JobspotApp(),
    ), 
  );
}
