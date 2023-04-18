import 'package:flutter/material.dart';
import 'package:klinik_pahase2/model/poli.dart';
import 'package:klinik_pahase2/service/poli_service.dart';
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
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          title: const Text(
            "New Note",
            style: TextStyle(fontFamily: 'Helvetica'),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              _fieldNamaPoli(),
              const SizedBox(height: 20),
              _fieldDeskripsiPoli(),
              const SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPoli() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Title",
        labelStyle:
            const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
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
        labelStyle:
            const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
        hintStyle:
            const TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
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
      style: const TextStyle(
          fontSize: 20, color: Colors.black, fontFamily: 'Helvetica'),
      maxLines: null, // set text color to black
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Poli poli = Poli(
              namaPoli: _namaPoliCtrl.text,
              deskripsiPoli: _deskripsiPoliCtrl.text);
          await PoliService().simpan(poli).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PoliDetail(poli: value)));
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, elevation: 0),
        child: const Text(
          "Save",
        ));
  }
}
