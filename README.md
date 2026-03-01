# Samudera
<img width="1920" height="1080" alt="Samudera hero image" src="https://github.com/user-attachments/assets/3781307e-40b8-4590-b32a-a786586c0eb6" />
Samudera adalah aplikasi Flutter yang menampilkan data pasar saham menggunakan AlphaVantage API. Aplikasi ini memiliki fitur eksplorasi market movers (gainers, losers, most active), berita sentimen pasar, dan detail perusahaan lengkap dengan grafik harga historis.

## Lessons Learned (275 Kata)

Selama pengembangan aplikasi Samudera, saya banyak belajar tentang manajemen state menggunakan pola Cubit dari `flutter_bloc`. Sebelumnya saya lebih familiar dengan Riverpod dan BLoC, jadi mencoba Cubit memberi perspektif baru. Saya memilih Cubit karena implementasinya lebih straightforward dan minim boilerplate, sehingga cocok untuk proyek kecil seperti Samudera. 

Salah satu tantangan terbesar yang saya hadapi adalah rate limiting pada API AlphaVantage. Pada free tier, API hanya mengizinkan 25 request per hari dan membatasi satu request per detik. Saya sudah kehilangan hitung berapa kali harus berganti device dan men-generate API key baru hanya untuk keperluan testing. Hal ini membuat saya tidak bisa memanggil beberapa endpoint secara paralel untuk screen detail company. Untuk mengatasinya, saya menerapkan beberapa strategi: guard fetch untuk melewati request jika data sudah tersedia, lazy loading berdasarkan tab aktif agar hanya data yang dibutuhkan yang diambil, serta request sequential dengan jeda sekitar 1,2 detik agar tetap sesuai dengan batasan API. Pendekatan ini membantu menjaga aplikasi tetap responsif sekaligus hemat kuota request. Akan tetapi, sebagai pengorbanannya, screen detail company butuh waktu minimal 3,6 detik untuk di-load.

Saya juga sempat menghadapi masalah null safety pada response API. Ketika rate limit tercapai, API mengembalikan response yang berbeda dari struktur data yang diharapkan, yang sempat menyebabkan aplikasi crash. Dari situ, saya belajar pentingnya validasi response sebelum parsing. Saya menambahkan pengecekan null dan verifikasi struktur data pada layer repository agar aplikasi dapat menangani kondisi tak terduga dengan lebih aman.

Proses development Samudera makin memperkuat sentimen saya bahwa memastikan fitur sekadar "bisa digunakan" tidak cukup, aplikasi sebaiknya dirancang agar sedekat mungkin dengan standar industri dan tidak hanya user-friendly, tetapi juga developer-friendly agar tetap stabil dan skalabel meskipun ada keterbatasan dari layanan eksternal. 

## Demo Video

https://github.com/user-attachments/assets/6f20b44a-d4f4-4c8c-aeba-1ecc19ec9c01

## Referensi

- [AlphaVantage API Documentation](https://www.alphavantage.co/documentation/)
- [fl_chart — line_chart_sample2.dart](https://github.com/imaNNeo/fl_chart/blob/main/example/lib/presentation/samples/line/line_chart_sample2.dart)
- [flutter_bloc Documentation](https://bloclibrary.dev/)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Flutter Material 3 Guidelines](https://m3.material.io/)
