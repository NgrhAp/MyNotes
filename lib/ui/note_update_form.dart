import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_pahase2/ui/note_page.dart';
import '../model/note.dart';
import '../service/note_service.dart';
import 'note_detail.dart';

class NoteUpdateForm extends StatefulWidget {
  final Note note;

  const NoteUpdateForm({Key? key, required this.note}) : super(key: key);
  _NoteUpdateFormState createState() => _NoteUpdateFormState();
}

class _NoteUpdateFormState extends State<NoteUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleNoteCtrl = TextEditingController();
  final _descriptionNoteCtrl = TextEditingController();

  Future<Note> getData() async {
    Note data = await NoteService().getById(widget.note.id.toString());
    setState(() {
      _titleNoteCtrl.text = data.titleNote;
      _descriptionNoteCtrl.text = data.descriptionNote;
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
        backgroundColor: const Color(0xFFececec),
        appBar: AppBar(
          backgroundColor: const Color(0xFFececec),
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
                      "Edit",
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () async {
          Note note = Note(
            titleNote: _titleNoteCtrl.text,
            descriptionNote: _descriptionNoteCtrl.text,
          );
          String id = widget.note.id.toString();
          await NoteService().ubah(note, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NoteDetail(note: value)),
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
