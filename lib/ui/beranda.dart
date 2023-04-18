import 'package:flutter/material.dart';
import '../widget/sidebar.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('MyNotes'),
          titleTextStyle: const TextStyle(fontFamily: 'Helvetica'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My \nNotes",
                style: TextStyle(
                  fontSize: 80,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Each note that you've created is proof\nthat you've worked and produced something meaningful",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [],
            )
          ],
        ));
  }
}
