import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerClipper extends CustomClipper<Path> {
  Path path = Path();
  @override
  Path getClip(Size size) {
    path.lineTo(0, 120.h);
    path.quadraticBezierTo(20.h, 170.h, size.width * .3, size.height - 120.h);
    path.quadraticBezierTo(size.width * .85, size.height * .63, size.width, size.height - 42);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
