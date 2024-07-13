import 'package:flutter/material.dart';
import 'user_page.dart';
import 'user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int status = 0; // 0 for ListView, 1 for GridView
  Future<List<Character>>? futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Rick and Morty Characters'),
        actions: [
          IconButton(
            icon: status == 0
                ? const Icon(
                    Icons.grid_view,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                status = status == 0 ? 1 : 0;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Character>>(
        future: futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            return status == 0 ? buildListView(snapshot.data!) : buildGridView(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget buildListView(List<Character> characters) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        var character = characters[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(character: character),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: ListTile(
              leading: Image.network(character.image),
              title: Text(character.name),
              subtitle: Text(character.status),
              trailing: const Icon(Icons.bookmark_border, color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView(List<Character> characters) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        var character = characters[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(character: character),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(character.image, height: 250, fit: BoxFit.cover),
                ),
                const SizedBox(height: 6),
                ListTile(
                  title: Text(character.name),
                  subtitle: Text(character.status),
                  trailing: const Icon(Icons.bookmark_border, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Deskripsi extends StatelessWidget {
  final Map<String, dynamic> data;

  const Deskripsi({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data['image'],
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['deskripsi'],
                    style: const TextStyle(
                      fontSize: 16,
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
