import 'package:flutter/material.dart';

class PosSearchBox extends StatelessWidget {
  const PosSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1f2029),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.white54),
          SizedBox(width: 10),
          Text(
            'Buscar en el menú aquí...',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
