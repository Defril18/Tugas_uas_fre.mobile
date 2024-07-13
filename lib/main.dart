import 'package:flutter/material.dart';
import 'home_page.dart';

// Fungsi utama yang menjalankan aplikasi Flutter
void main() {
  runApp(MyApp());
}

// MyApp adalah widget utama aplikasi ini
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget yang mengatur banyak hal untuk aplikasi
    return MaterialApp(
      // Judul aplikasi
      title: 'Rick and Morty Characters',
      // Tema aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Warna utama aplikasi
      ),
      // Halaman utama yang ditampilkan saat aplikasi diluncurkan
      home: HomePage(),
    );
  }
}
