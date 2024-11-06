import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cartItems = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    double totalAmount = 0;

    cartItems.forEach((item) {
      totalAmount += item['product'].price * item['quantity'];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xFFFCFCFC),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFAFAFA), Color(0xFFFFFFFF)], ///adsa
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran:',
                        style: TextStyle(fontSize: 20, color: Colors.white70,fontFamily: 'JetBrainsMono',),
                      ),
                      Text(
                        'Rp $totalAmount',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JetBrainsMono',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  _buildTextField(
                    labelText: 'Nama',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    labelText: 'Nomor Kartu Kredit',
                    icon: Icons.credit_card,
                    isNumber: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Menampilkan notifikasi setelah tombol diklik
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Pembayaran Berhasil'),
                          content: Text('Terima kasih, pembayaran Anda telah diproses!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Menutup dialog dan kembali ke dashboard
                                Navigator.pop(context); // Menutup dialog
                                Navigator.pushReplacementNamed(context, '/dashboard'); // Navigasi ke dashboard
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.check_circle_outline,
                        color: Color(0xFF5A67F2)),
                    label: Text('Bayar', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF2575FC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFF5A67F2)),
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
