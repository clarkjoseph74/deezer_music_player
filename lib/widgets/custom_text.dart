import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String msg;
  final Color color;
  final FontWeight fontWeight;
  final double size;
  const CustomText(
      {required this.msg,
      this.color = Colors.white,
      this.fontWeight = FontWeight.bold,
      this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Text(msg,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunito(
          fontWeight: fontWeight,
          color: color,
          fontSize: size,
        ));
  }
}
