import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';
import 'package:flutter/cupertino.dart';

class PoliItem extends StatelessWidget {
  final Poli poli;

  const PoliItem({Key? key, required this.poli, required TextStyle textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          elevation: 3, // Adjust the elevation value as needed
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              top: 8.0,
            ),
            child: CupertinoListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poli.namaPoli,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'sfmonoBold',
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0), // Adjust the padding value as needed
                    child: Text(
                      poli.deskripsiPoli,
                      style: const TextStyle(
                        fontFamily: 'sfmonoLight',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
