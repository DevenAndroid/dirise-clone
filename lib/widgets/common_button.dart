import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colour.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool? expandedValue;
  final Color? textColor;

  const CustomOutlineButton(
      {Key? key, required this.title, this.onPressed, this.backgroundColor, this.textColor, this.expandedValue = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 56,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.buttonColor,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              )),
          onPressed: onPressed,
          child: expandedValue == true
              ? SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(color: const Color(0xFFFFFFFF), fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.poppins(color: const Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w500),
                )),
    );
  }
}
