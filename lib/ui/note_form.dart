import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_pahase2/model/note.dart';
import 'package:klinik_pahase2/service/note_service.dart';
import 'package:klinik_pahase2/ui/note_page.dart';
import 'note_detail.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({Key? key}) : super(key: key);
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleNoteCtrl = TextEditingController();
  final _descriptionNoteCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFececec),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
              width: 40,
              height: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotePage(),
                  ));
            },
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 5), // Add some vertical spacing
                    Text(
                      "Add New",
                      style: TextStyle(
                        fontSize: 60,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'roboto',
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _fieldTitleNote(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _fieldDescriptionNote(),
                ),
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            )
          ],
        ));
  }

  _fieldTitleNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Title",
          labelStyle: TextStyle(color: Colors.blueGrey, fontFamily: 'roboto'),
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        controller: _titleNoteCtrl,
        cursorColor: Colors.blueGrey,
        maxLines: null,
        style: const TextStyle(fontSize: 20, fontFamily: 'roboto'),
      ),
    );
  }

  _fieldDescriptionNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Description",
          labelStyle: TextStyle(color: Colors.blueGrey, fontFamily: 'roboto'),
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        controller: _descriptionNoteCtrl,
        cursorColor: Colors.blueGrey,
        maxLines: null,
        style: const TextStyle(fontSize: 20, fontFamily: 'roboto'),
      ),
    );
  }

  _tombolSimpan() {
    return IconButton(
      onPressed: () async {
        Note note = Note(
          titleNote: _titleNoteCtrl.text,
          descriptionNote: _descriptionNoteCtrl.text,
        );
        await NoteService().simpan(note).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NoteDetail(note: value)),
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
