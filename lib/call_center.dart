import 'package:flutter/material.dart';

class CallCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Center"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                "Hubungi Call Center",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Jika Anda membutuhkan bantuan, hubungi kami di nomor call center di bawah ini:",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "0800-123-456",
                style: TextStyle(fontSize: 28, color: Colors.blue),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Aksi panggilan
                },
                child: Text("Panggil Sekarang"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
