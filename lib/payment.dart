import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Color(0xFF2575FC),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.payment,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'Pembayaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Masukkan detail pembayaran Anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'JetBrainsMono',
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Nama',
                    labelStyle: TextStyle(color: Colors.black54,fontFamily: 'JetBrainsMono',),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money, color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Total Harga',
                    labelStyle: TextStyle(color: Colors.black54,fontFamily: 'JetBrainsMono',),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF2575FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    // Logic pembayaran
                  },
                  child: Text(
                    'Bayar',
                    style: TextStyle(fontSize: 18,fontFamily: 'JetBrainsMono',),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
