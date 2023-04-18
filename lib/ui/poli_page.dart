import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';
import 'poli_detail.dart';
import 'poli_form.dart';
import 'poli_item.dart';
import '../widget/sidebar.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({Key? key}) : super(key: key);
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            "My Notes",
            style:
                TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PoliForm()));
              },
            )
          ],
        ),
        body: Container(
            color: Colors.grey, // set the background color to blue
            child: StreamBuilder(
              stream: getList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                }
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
                if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return const Text(
                    'Data Kosong',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PoliItem(
                      poli: snapshot.data[index],
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica'),
                    );
                  },
                );
              },
            )));
  }
}
