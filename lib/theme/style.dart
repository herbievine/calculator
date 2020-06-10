import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Styles {
  var currentTheme = 'BLUE';

  var themes = [
    {
      'name': 'PURPLE',
      'props': {
        'dark': Color(0xff2B152B),
        'light': Color(0xff5E2E5E),
        'border': Color(0xff452245)
      }
    },
    {
      'name': 'RED',
      'props': {
        'dark': Color(0xff471109),
        'light': Color(0xff781C10),
        'border': Color(0xff61160D)
      }
    },
    {
      'name': 'BLUE',
      'props': {
        'dark': Color(0xff2E4D5E),
        'light': Color(0xff43708A),
        'border': Color(0xff34576B)
      }
    },
    {
      'name': 'ORANGE',
      'props': {
        'dark': Color(0xff8C2B0B),
        'light': Color(0xffB34E0B),
        'border': Color(0xffA63805)
      }
    },
  ];

  setColorScheme(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String _currentTheme = prefs.getString('theme');

    if (_currentTheme == '') prefs.setString('theme', 'PURPLE').then((value) => _currentTheme = 'PURPLE');

    var themeToApply;

    switch (name) {
      case 'PURPLE':
        themeToApply = 'PURPLE';
        prefs.setString('theme', 'PURPLE');
        break;
      case 'RED':
        themeToApply = 'RED';
        prefs.setString('theme', 'RED');
        break;
      case 'BLUE':
        themeToApply = 'BLUE';
        prefs.setString('theme', 'BLUE');
        break;
      case 'ORANGE':
        themeToApply = 'ORANGE';
        prefs.setString('theme', 'ORANGE');
        break;
      default:
        return null;
    }

    currentTheme = themeToApply;
  }

  Future<Map> getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _currentTheme = prefs.getString('theme') ?? 'PURPLE';

    switch (_currentTheme) {
      case 'PURPLE':
        return themes[0]['props'];
        break;
      case 'RED':
        return themes[1]['props'];
        break;
      case 'BLUE':
        return themes[2]['props'];
        break;
      case 'ORANGE':
        return themes[3]['props'];
        break;
      default:
        return null;
    }
  }

  var themeData = ThemeData(
      primaryColor: Color(0xffaaaaaa),
      accentColor: Color(0xff666666),
      backgroundColor: Color(0xff222222)
  );

  TextStyle textStyle(Color color, double fontSize) => GoogleFonts.roboto(
     textStyle: TextStyle(
       fontWeight: FontWeight.bold,
       fontSize: fontSize,
       color: color,
     )
  );
}