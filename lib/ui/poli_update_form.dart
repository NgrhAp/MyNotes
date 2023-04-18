import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';
import 'poli_detail.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);
  _PoliUpdateFormState createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();
  final _deskripsiPoliCtrl = TextEditingController();

  Future<Poli> getData() async {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    setState(() {
      _namaPoliCtrl.text = data.namaPoli;
      _deskripsiPoliCtrl.text = data.deskripsiPoli;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            "Edit",
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
      controller: _namaPoliCtrl,
      cursorColor: Colors.blueGrey,
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
      maxLines: null,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Poli poli = Poli(
            namaPoli: _namaPoliCtrl.text,
            deskripsiPoli: _deskripsiPoliCtrl.text);
        String id = widget.poli.id.toString();
        await PoliService().ubah(poli, id).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PoliDetail(poli: value)));
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      child: const Text(
        "Save Changes",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
