import 'package:flutter/material.dart';
import 'package:music_dezeer/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CustomText(msg: "Profile"),
      ),
    );
  }
}
