import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyCustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType? kry;
  final double? width;
  final double? hight;
  final int? maxLines;

  // final Function? onChange;
  // final Function validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  // final Function onTap;
  final TextEditingController? controller;
  final Color? color;
  final Color? border_color;
  String? readonly ;
  // final Color borderColor;
  // final bool obscureText;
  // final InputDecoration decoration;
  // final Function(String) validator;

  // final MaskFilter maskFilter;
  MyCustomTextField({
    @override required this.hint,
    this.width,
    // this.onChange,

    this.kry,
    // required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    // required this.onTap,
    this.controller,
    this.hight,
    this.maxLines,
    this.color,
    this.border_color,
     this.readonly,

    // required this.borderColor,
    // required this.obscureText,
    /*required this.decoration*/
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      child: TextFormField(
        readOnly: readonly =="read only"? true:false,

        // onChanged: onChange!,
        controller: controller,
        maxLines: maxLines ?? 1,
        // controller: callback,
        // autovalidate: true,
        // obscureText: obscureText,
        // validator: validator(),
        // inputFormatters: inputFormatters,
        keyboardType: kry,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
          hintText: hint,
          filled: true,
          fillColor: color ?? Color(0xFFF0F0F0),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
              borderSide: BorderSide(
                  color: border_color ?? Color(0xFFF0F0F0), width: 2.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(240, 240, 240, 100), width: 2.w)),
        ),
        // inputFormatters: [phoneFormatter],
      ),
    );
  }
}
