import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';
import 'register.dart';
import 'update_user.dart';
import 'cart.dart';
import 'checkout.dart';
import 'welcome.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Rute awal adalah splash screen
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/dashboard': (context) => Dashboard(),
        '/register': (context) => Register(),
        '/update-user': (context) => UpdateUser(),
        '/cart': (context) =>
            Cart(cartItems: []), // Inisialisasi dengan keranjang kosong
        '/checkout': (context) => Checkout(),
      },

    );
  }
}
