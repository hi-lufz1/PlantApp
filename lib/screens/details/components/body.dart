import 'package:flutter/material.dart';

import 'images_and_icons.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: <Widget>[ImagesAndIcons(size: size)]),
    );
  }
}
