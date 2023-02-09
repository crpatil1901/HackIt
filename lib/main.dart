import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_it/screens/home_screen.dart';
import 'package:hack_it/theme/color_scheme.dart';
import 'package:hack_it/screens/login_register_screen.dart';
import 'package:hack_it/view_models/login_vm.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ListenableProvider<LoginViewModel>(create: (context) => LoginViewModel(),),
      ],
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontFamily: "SpaceMono")
            )
          ),
          home: FirebaseAuth.instance.currentUser == null ? LoginRegisterPage() : HomeScreen(),
        ),
      )
    );
  }
}