import 'package:flutter/material.dart';
import 'package:interiorx/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'routes.dart';
import 'theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InteriorX',
          theme: AppTheme.lightTheme(context),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ));
  }
}
