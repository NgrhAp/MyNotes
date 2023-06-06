import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../service/poli_service.dart';
import 'poli_page.dart';
import 'poli_update_form.dart';
import '../model/poli.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({Key? key, required this.poli}) : super(key: key);
  _PoliDetailState createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  Stream<Poli> getData() async* {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C9869),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg', // Replace with your SVG icon path
            width: 40, // Set the desired width for the icon
            height: 40, // Set the desired height for the icon
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PoliPage(),
                ));
          },
        ),
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "${snapshot.data.namaPoli}",
                  style: const TextStyle(
                      fontSize: 30, fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${snapshot.data.deskripsiPoli}",
                    style: const TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolHapus()],
              )
            ],
          );
        },
      ),
    );
  }


  _tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text("Are you sure want to delete this note?",
              style: TextStyle(fontSize: 20, fontFamily: 'Helvetica')),
          actions: [
            StreamBuilder(
                stream: getData(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                      onPressed: () async {
                        await PoliService().hapus(snapshot.data).then((value) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => const PoliPage()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0),
                      child: const Text(
                        "YES",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontFamily: 'Helvetica'),
                      ),
                    )),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
              child: const Text("NO",
                  style: TextStyle(
                      color: Colors.blueGrey, fontSize: 16, fontFamily: 'Helvetica')),
            )
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.red),
          elevation: 0),
      child: const Text("DELETE",
          style: TextStyle(color: Colors.red, fontFamily: 'Helvetica')),
    );
  }
}
