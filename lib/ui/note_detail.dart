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
        actions: [
          Padding(
            padding: const EdgeInsets.all(
                8.0), 
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
                              horizontal: 20), 
                          child: Text(
                            "${snapshot.data.titleNote}",
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
                        "${snapshot.data.descriptionNote}",
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
                        offset: const Offset(0, 3),
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
                                NoteUpdateForm(note: snapshot.data),
                          ),
                        );
                      },
                      icon: Transform.scale(
                        scale:
                            1,
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
