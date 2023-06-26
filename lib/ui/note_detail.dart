import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../service/note_service.dart';
import 'note_page.dart';
import 'note_update_form.dart';
import '../model/note.dart';

class NoteDetail extends StatefulWidget {
  final Note note;

  const NoteDetail({Key? key, required this.note}) : super(key: key);
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  Stream<Note> getData() async* {
    Note data = await NoteService().getById(widget.note.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 40,
            height: 40,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotePage(),
                ));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${snapshot.data.titleNote}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'sfmonoBold',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${snapshot.data.descriptionNote}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'roboto',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 30.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteUpdateForm(note: snapshot.data),
                        ),
                      );
                    },
                    icon: Transform.scale(
                      scale: 1,
                      child: const Icon(
                        Icons.mode_edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
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
            style: TextStyle(fontSize: 20, fontFamily: 'roboto'),
          ),
          actions: [
            StreamBuilder(
              stream: getData(),
              builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                onPressed: () async {
                  await NoteService().hapus(snapshot.data).then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const NotePage()),
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
                    fontFamily: 'roboto',
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
                  fontFamily: 'roboto',
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
          Colors.white,
          BlendMode.srcIn,
        ),
        width: 80,
        height: 80, // Replace with the path to your SVG icon
      ), // Set the desired color for the icon
    );
  }
}
