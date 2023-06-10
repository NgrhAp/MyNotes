import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_pahase2/ui/poli_page.dart';
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
                        "Edit",
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
    return TextField(
      decoration: InputDecoration(
        labelText: "Title",
        labelStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoLight'),
        hintStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoLight'),
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
        labelStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoLight'),
        hintStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'sfmonoLight'),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () async {
          Poli poli = Poli(
            namaPoli: _namaPoliCtrl.text,
            deskripsiPoli: _deskripsiPoliCtrl.text,
          );
          String id = widget.poli.id.toString();
          await PoliService().ubah(poli, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PoliDetail(poli: value)),
            );
          });
        },
        icon: Transform.scale(
          scale: 2,
          child: SvgPicture.asset(
            'assets/icons/save.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
