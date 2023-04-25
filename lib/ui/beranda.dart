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
          title: const Text(
            'MyNotes',
            style: TextStyle(fontSize: 30),
          ),
          titleTextStyle: const TextStyle(fontFamily: 'Helvetica'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
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
