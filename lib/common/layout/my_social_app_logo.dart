import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySocialAppLogo extends StatelessWidget {
  final double height;
  final double width;
  final TextStyle logoTextStyle;
  final TextStyle applicationNameStyle;

  const MySocialAppLogo({
    Key key,
    this.height: 300,
    this.width: 300,
    this.logoTextStyle: const TextStyle(
      fontSize: 200,
    ),
    this.applicationNameStyle: const TextStyle(
      fontSize: 40,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    top: -40,
                    child: Text(
                      'M',
                      style: GoogleFonts.monoton(fontSize: 150),
                    ),
                  ),
                  Positioned(
                    left: 100,
                    child: Text(
                      'S',
                      style: GoogleFonts.monoton(fontSize: 150),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    right: 0,
                    child: Text(
                      'A',
                      style: GoogleFonts.monoton(fontSize: 150),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'My Social App',
              style: GoogleFonts.getFont('Monoton', fontSize: 35),
            ),
          )
        ],
      ),
    );
  }
}
