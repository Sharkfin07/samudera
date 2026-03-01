# Samudera
<img width="1920" height="1080" alt="Samudera hero image" src="https://github.com/user-attachments/assets/3781307e-40b8-4590-b32a-a786586c0eb6" />
Samudera adalah aplikasi Flutter yang menampilkan data pasar saham menggunakan AlphaVantage API. Aplikasi ini memiliki fitur eksplorasi market movers (gainers, losers, most active), berita sentimen pasar, dan detail perusahaan lengkap dengan grafik harga historis.

## Fitur

- **Explore**, Menampilkan top gainers, top losers, dan most actively traded stocks hari ini dengan segmented tab bar.
- **News**, Berita sentimen pasar dengan tag sentimen (Bullish/Bearish/Neutral), sorting (Latest/Relevance/Earliest), dan banner image.
- **Company Detail**, Informasi lengkap perusahaan (overview, sector, market cap, P/E ratio, dividend yield), harga real-time (open/high/low/close/volume), dan grafik harga 30 hari terakhir menggunakan fl_chart.
- **Developer**, Halaman profil untuk berkenalan lebih lanjut dengan developer Samudera.
- **Dark Mode**, Mendukung tema terang dan gelap secara otomatis mengikuti pengaturan sistem.

## Packages

| Package | Kegunaan |
|---|---|
| `dio` | HTTP client untuk komunikasi dengan AlphaVantage API |
| `flutter_bloc` | State management menggunakan pola Cubit |
| `fl_chart` | Visualisasi grafik harga saham (line chart) |
| `flutter_dotenv` | Memuat konfigurasi environment (.env) untuk API key |
| `flutter_svg` | Render aset SVG |
| `lottie` | Animasi loading indicator |
| `google_nav_bar` | Bottom navigation bar |
| `intl` | Formatting tanggal pada chart tooltip |
| `super_bullet_list` | Widget bullet list pada halaman developer |

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

## ggE retsaE
...ilak 3 repoleved neercs id noisrev sket nakenem ualak tegak nagnaJ
