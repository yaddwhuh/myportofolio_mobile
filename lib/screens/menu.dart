import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506586961";
  final String nama = "Muhammad Fayadh Azzahran";
  final String kelas = "PBP C";

  final List<ItemHomepage> items = [
    ItemHomepage(
      "View Projects",
      Icons.folder,
      Color.fromARGB(255, 91, 130, 158),
    ),
    ItemHomepage(
      "View Experiences",
      Icons.fact_check,
      Color.fromARGB(255, 103, 119, 152),
    ),
    ItemHomepage(
      "View Achievements",
      Icons.emoji_events,
      Color.fromARGB(255, 97, 79, 134),
    ),
    ItemHomepage(
      "Add Item",
      Icons.add_circle,
      Color.fromARGB(255, 114, 63, 77),
    ),
    ItemHomepage("Logout", Icons.logout, Color.fromARGB(255, 136, 92, 56)),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      // Body halaman utama dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      alignment:
                          WrapAlignment.center, // Centers buttons in each row
                      spacing: 10,
                      runSpacing: 10,
                      children: items.map((ItemHomepage item) {
                        return SizedBox(
                          width: 125, // Keeps button sizes uniform like a grid
                          height: 125,
                          child: ItemCard(item),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Memberikan efek bayangan kartu elevasi 2 unit.
      elevation: 2.0,
      child: Container(
        // Menyesuaikan lebar kartu dengan proporsi layar (dibagi 3.5).
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // Menyusun teks title dan content secara vertikal.
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color buttonColor;

  ItemHomepage(this.name, this.icon, this.buttonColor);
}
