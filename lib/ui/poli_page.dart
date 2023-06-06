import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klinik_pahase2/ui/poli_form.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';
import 'poli_item.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({Key? key}) : super(key: key);
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF9F8FD),
        child: StreamBuilder(
          stream: getList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }
            if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return const Text(
                'Data Kosong',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              );
            }

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF0C9869),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 35), // Add some vertical spacing
                            Text(
                              "Notes",
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
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, bottom: 10.0, right: 35.0),
                            child: PoliItem(
                              poli: snapshot.data[index],
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20.0,
                  right: 30.0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PoliForm()),
                          );
                        },
                        icon: Transform.scale(
                          scale:
                              2, // Adjust the scale factor to increase or decrease the size
                          child: SvgPicture.asset(
                            'assets/icons/add.svg', // Replace with the path to your SVG icon file
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF0C9869),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
