import 'package:flutter/material.dart';
import 'package:flutflix/screen/login.dart';
import 'package:flutflix/screen/register.dart';
import 'package:flutflix/screen/home_screen.dart';
import 'package:flutflix/screen/profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Tambahkan ini untuk SpinKit

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Hilangkan banner debug
    initialRoute: '/splash', // Atur SplashScreen sebagai halaman awal
    routes: {
      '/splash': (context) => SplashScreen(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => RegisterPage(),
      '/home': (context) {
        final userToken = ModalRoute.of(context)?.settings.arguments as String?;
        return HomeScreen(userToken: userToken ?? '');
      },
      '/profile': (context) => ProfilePage()
    },
  ));
}

class AppColors {
  static const Color primary = Colors.deepPurple;
  static const Color secondary = Colors.deepPurple;
  static const Color background = Color.fromARGB(255, 54, 54, 54);
  static const Color text = Colors.deepPurple;
  static const Color accent = Colors.deepPurple;
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay untuk berpindah ke halaman login
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // Warna latar belakang SplashScreen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Aplikasi
            Image.asset(
              'lib/assets/flutflix.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 30),
            // Nama Aplikasi
            Text(
              'Film Mewah',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Loading Animation
            SpinKitWave(
              color: Colors.blue, // Ganti warna sesuai tema aplikasi
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
