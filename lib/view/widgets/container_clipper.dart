import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerClipper extends CustomClipper<Path> {
  Path path = Path();
  @override
  Path getClip(Size size) {
    path.lineTo(0, 133.h);
    path.quadraticBezierTo(0, 199.h, size.width * .5, size.height - 90);
    path.quadraticBezierTo(size.width * .7, size.height * .7, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
