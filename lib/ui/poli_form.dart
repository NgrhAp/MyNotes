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
        ),
        body: Stack(
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
                    children: const [
                      SizedBox(height: 5), // Add some vertical spacing
                      Text(
                        "Add New",
                        style: TextStyle(
                          fontSize: 60,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'sfmonoBold',
                        ),
                      ),
                      SizedBox(height: 20),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Title",
          labelStyle: TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoRegular'),
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        controller: _namaPoliCtrl,
        cursorColor: Colors.blueGrey,
        maxLines: null,
        style: const TextStyle(fontSize: 20, fontFamily: 'sfmonoRegular'),
      ),
    );
  }

  _fieldDeskripsiPoli() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Description",
          labelStyle: TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoRegular'),
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        controller: _deskripsiPoliCtrl,
        cursorColor: Colors.blueGrey,
        maxLines: null,
        style: const TextStyle(fontSize: 20, fontFamily: 'sfmonoRegular'),
      ),
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
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
