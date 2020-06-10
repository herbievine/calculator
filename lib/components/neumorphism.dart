import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:calculator/theme/style.dart';

class NeumorphismButton extends StatelessWidget {
  NeumorphismButton ({
    @required this.darkColor,
    @required this.lightColor,
    @required this.borderColor,
    this.textColor,
    @required this.text,
    this.double,
  });

  final darkColor;
  final lightColor;
  final borderColor;
  final textColor;
  final text;
  final double;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: double != null ? 120 + (size.width - (60 * 4) - (40 * 2)) / 3 : 60,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFFFFF).withOpacity(0.35),
            blurRadius: 2,
            offset: Offset(-.6, -.6),
          ),
          BoxShadow(
            color: Color(0xFF000000).withOpacity(1),
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            darkColor,
            lightColor
          ]
        )
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )
          )
        ),
      )
    );
  }
}

class NeumorphismTheme extends StatelessWidget {
  NeumorphismTheme ({
    @required this.primary,
    @required this.secondary,
    @required this.border
  });

  final primary;
  final secondary;
  final border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: border,
          width: 2
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFFFFF).withOpacity(0.35),
            blurRadius: 2,
            offset: Offset(-.6, -.6),
          ),
          BoxShadow(
            color: Color(0xFF000000).withOpacity(1),
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            secondary
          ]
        )
      ),
    );
  }
}