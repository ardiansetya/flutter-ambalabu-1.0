import 'package:flutter/material.dart';
import 'product.dart';

class ProductDescription extends StatelessWidget {
  final Product product;

  ProductDescription({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks ke kiri
          children: [
            // Menampilkan gambar produk
            Center(
              child: Image.asset(
                product.imageUrl, // Menggunakan gambar dari assets
                fit: BoxFit.cover, // Menjaga proporsi gambar
                width: double.infinity, // Mengisi lebar penuh
                height: 200, // Tinggi gambar
              ),
            ),
            SizedBox(height: 16.0), // Jarak antara gambar dan deskripsi
            // Menampilkan deskripsi produk
            Text(
              product.description,
              style: TextStyle(fontSize: 16.0), // Ukuran teks deskripsi
            ),
          ],
        ),
      ),
    );
  }
}
