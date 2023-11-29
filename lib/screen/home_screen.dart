import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var playerData = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String res = await rootBundle.loadString('lib/json/player_data.json');
    final data = jsonDecode(res);
    data.sort((a, b) {
      if (a['level'] == 'Basic' && b['level'] != 'Basic') {
        return -1;
      } else if (a['level'] != 'Basic' && b['level'] == 'Basic') {
        return 1;
      } else if (a['level'] == 'Intermediate' && b['level'] == 'Advanced') {
        return -1;
      } else if (a['level'] == 'Advanced' && b['level'] == 'Intermediate') {
        return 1;
      }
      String nameA = a['name'] ?? '';
      String nameB = b['name'] ?? '';
      return nameA.compareTo(nameB);
    });
    setState(() {
      playerData = data;
    });
  }

  // sortData(var data) {
  //   List list = [];
  //   for (dynamic i in data) {
  //     print(i);
  //     if (i['level'] == 'Basic') {
  //       list.add(i);
  //     }
  //   }
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'P L A Y E R S',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: playerData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playerData.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    padding: const EdgeInsets.all(10),
                    color: Colors.deepPurple[400],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          playerData[index]['name'],
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          playerData[index]['level'],
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
