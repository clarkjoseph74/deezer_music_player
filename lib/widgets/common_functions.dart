import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigateTo({required BuildContext context, required Widget widget}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}
