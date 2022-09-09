import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors_resources.dart';

class MyCustomPassword extends StatefulWidget {
  final String hint;
  final TextInputType? kry;
  final double? width;
  // final Function? onChange;
  // final Function validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  // final Function onTap;
  final TextEditingController? controller;
  // final Color borderColor;
  // final bool obscureText;
  // final InputDecoration decoration;
  // final Function(String) validator;

  // final MaskFilter maskFilter;
  MyCustomPassword({
    @override required this.hint,
    this.width,
    // this.onChange,
    this.kry,
    // required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    // required this.onTap,
    this.controller,
    // required this.borderColor,
    // required this.obscureText,
    /*required this.decoration*/
  });

  @override
  _MyCustomPasswordState createState() => _MyCustomPasswordState();
}

class _MyCustomPasswordState extends State<MyCustomPassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
        prefixIcon: Icon(Icons.lock, color: appMainColor),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText == true ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        fillColor: const Color(0xFFF0F0F0),
        filled: true,
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            borderSide: BorderSide(color: Color(0xFFF0F0F0), width: 2.w)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            borderSide: BorderSide(
                color: Color.fromRGBO(240, 240, 240, 100), width: 2)),
      ),
    );
  }
}
