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
        backgroundColor: Colors.transparent,
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(
                8.0), // Adjust the padding values as per your preference
            child: _tombolHapus(),
          ),
        ],
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
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan');
          }
          return Stack(
            children: [
              ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20), // Add horizontal padding
                          child: Text(
                            "${snapshot.data.namaPoli}",
                            style: const TextStyle(
                              fontSize: 40,
                              fontFamily: 'sfmonoBold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${snapshot.data.deskripsiPoli}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'sfmonoRegular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 30.0,
                // Apply circular shape to the Material widget
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(80),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 28,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PoliUpdateForm(poli: snapshot.data),
                          ),
                        );
                      },
                      icon: Transform.scale(
                        scale:
                            1, // Adjust the scale factor to increase or decrease the size
                        child: const Icon(
                          Icons.mode_edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _tombolHapus() {
    return IconButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          content: const Text(
            "Are you sure want to delete this note?",
            style: TextStyle(fontSize: 20, fontFamily: 'sfmonoRegular'),
          ),
          actions: [
            StreamBuilder(
              stream: getData(),
              builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                onPressed: () async {
                  await PoliService().hapus(snapshot.data).then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PoliPage()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                child: const Text(
                  "YES",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontFamily: 'sfmonoRegular',
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text(
                "NO",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontFamily: 'sfmonoRegular',
                ),
              ),
            ),
          ],
        );
        showDialog(context: context, builder: (context) => alertDialog);
      },
      icon: SvgPicture.asset(
        'assets/icons/delete.svg',
        colorFilter: const ColorFilter.mode(
          Colors.red,
          BlendMode.srcIn,
        ),
        width: 80,
        height: 80, // Replace with the path to your SVG icon
      ), // Set the desired color for the icon
    );
  }
}
