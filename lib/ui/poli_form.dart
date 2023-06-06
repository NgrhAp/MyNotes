import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_pahase2/model/poli.dart';
import 'package:klinik_pahase2/service/poli_service.dart';
import 'package:klinik_pahase2/ui/poli_page.dart';
import 'poli_detail.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  final _deskripsiPoliCtrl = TextEditingController();

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
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0C9869),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 5), // Add some vertical spacing
                      Text(
                        "Add New",
                        style: TextStyle(
                          fontSize: 60,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFFF9F8FD),
                          fontFamily: 'Helvetica',
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _fieldNamaPoli(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _fieldDeskripsiPoli(),
                ),
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            )
          ],
        ));
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Title",
        labelStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
        hintStyle: const TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      controller: _namaPoliCtrl,
      cursorColor: Colors.blueGrey,
      style: const TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
    );
  }

  _fieldDeskripsiPoli() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Description",
        labelStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
        hintStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      controller: _deskripsiPoliCtrl,
      cursorColor: Colors.blueGrey,
      style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Helvetica'),
      maxLines: null, // set text color to black
    );
  }

  _tombolSimpan() {
    return IconButton(
      onPressed: () async {
        Poli poli = Poli(
          namaPoli: _namaPoliCtrl.text,
          deskripsiPoli: _deskripsiPoliCtrl.text,
        );
        await PoliService().simpan(poli).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PoliDetail(poli: value)),
          );
        });
      },
      icon: Transform.scale(
        scale: 2, // Adjust the scale factor to increase or decrease the size
        child: SvgPicture.asset(
          'assets/icons/save.svg', // Replace with the path to your SVG icon file
          colorFilter: const ColorFilter.mode(
            Color(0xFF0C9869),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
