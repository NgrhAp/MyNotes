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
        padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F8FD),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: CupertinoColors.systemGrey, // Replace with your desired border color
              width: 2, // Adjust the border width as needed
            ),
          ),
          child: CupertinoListTile(
            title: Text(
              poli.namaPoli,
              style: const TextStyle(
                fontWeight: FontWeight.w200, // Adjust the font weight as needed
                fontFamily: 'Helvetica', // Replace with your desired font family
              ),
            ),
          ),
        ),
      ),
    );
  }
}
