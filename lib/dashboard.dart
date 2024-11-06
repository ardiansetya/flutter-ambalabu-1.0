import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'product_list.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showProductList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xFFF3F4F6), // Warna latar belakang yang lembut
      body: Center(
        child: showProductList
            ? ProductList() // Menampilkan daftar produk
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.storefront,
                      color: Color(0xFF4A90E2),
                      size: 80,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Selamat Datang di Ambalabu Store!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Temukan berbagai produk makanan ringan dan buat pengalaman belanja Anda lebih menyenangkan!',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showProductList = true; // Menampilkan daftar produk
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A90E2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Lihat Produk',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
