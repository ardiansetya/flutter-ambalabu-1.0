import 'package:flutter/material.dart';

class SMSCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Center"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sms, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Hubungi SMS Center",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Kirim pesan SMS ke nomor pusat layanan kami jika Anda memiliki pertanyaan.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "0812-3456-7890",
                style: TextStyle(fontSize: 28, color: Colors.green),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Aksi kirim SMS
                },
                child: Text("Kirim SMS"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
