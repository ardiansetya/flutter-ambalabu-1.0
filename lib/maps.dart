import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi Kami"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 100, color: Colors.red),
              SizedBox(height: 20),
              Text(
                "Temukan Lokasi Kami",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Gunakan aplikasi maps untuk menemukan lokasi kantor kami yang terdekat.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Aksi buka peta
                },
                child: Text("Buka di Maps"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
