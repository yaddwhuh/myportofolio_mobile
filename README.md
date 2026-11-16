Nama : Muhammad Fayadh Azzahran

NPM : 2506586961

Kelas : PBP C

# Tugas 7

1. Widget Tree adalah struktur data, sesuai dengan namanya, yang berbentuk pohon yang merepresentasikan seluruh susunan UI dalam Flutter app. Di dalam Flutter, hampir seluruh elemen aplikasi adalah widget. Widget disusun secara nested, di mana widget luar berperan sebagai induk dan yang di dalam berperan sebagai anak. Widget induk berperan untuk mengatur tata letak dan juga mewarisi konfigurasi kepada anak-anaknya (anggap saja seperti `<div>`nya html...?)

2. MaterialApp, Scaffold, AppBar, Text, Padding, Column, Row, SizedBox, Center, Wrap, Card, Container, Material, InkWell, SnackBar, Icon, MyApp, MyHomePage, InfoCard, ItemCard

3. MaterialApp berfungsi sebagai konfigurasi material design dan manajemen kebanyakan unsur pada app; hal-hal tersebut dibutuhkan oleh kebanyakan widget bawaan Flutter (arah teks, skema warna, dll.)

4. Stateless itu immutable dan Stateful itu mutable, lalu Stateful dapat memperbarui tampilan secara dinamis dengan `setState()` dan tidak dengan Stateless. Dari perbedaan tersebut, Stateless lebih cocok digunakan untuk UI yang tidak harus berubah berdasarkan interaksi pengguna, sedangkan Stateful cocok digunakan UI yang harus bereaksi terhadap interaksi pengguna, input formulir, animasi, timer, increment, dll.

5. BuildContext adalah objek yang merepresentasikan lokasi spesifik sebuah widget di dalam widget tree. Objek ini penting karena menjadi penghubung bagi widget untuk mengakses data atau konfigurasi dari widget induk (ancestor) di atasnya tanpa harus mengoper parameter secara manual. Penggunaan di dalam `build()` yaitu untuk mengambil layanan atau konfigurasi dari atas tree seperti `Theme.of(context)`, `MediaQuery.of(context)`, atau `Navigator.of(context)`.

6. Hot reload 'menyuntikkan' perubahan kode ke Dart VM dan membangun ulang tampilan UI secara instan dengan mempertahankan state aplikasi saat ini. Sebaliknya, hot restart mengompilasi ulang seluruh kode Dart dari awal dan mereset semua state kembali ke kondisi awal aplikasi. Hot Restart diharuskan ketika kita mengubah kode di dalam main(), initState(), variabel global/static, definisi enum, atau mengubah StatelessWidget menjadi StatefulWidget (dan sebaliknya), dan Full Restart diharuskan ketika kita menambahkan dependensi atau aset baru (gambar/font) di pubspec.yaml, serta saat mengubah kode native di folder android/ atau ios/.