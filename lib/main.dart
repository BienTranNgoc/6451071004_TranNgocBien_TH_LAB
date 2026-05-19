import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps/app.dart';
import 'controller/auth_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const JobspotApp(),
    ), 
  );
}
