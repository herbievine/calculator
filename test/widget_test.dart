// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:calculator/main.dart';

void main() {
  group('String', () {
    test('String.split() splits the string on the delimiter', () {
      var string = 'foo,bar,baz';
      expect(string.split(','), equals(['foo', 'bar', 'baz']));
    });
  
    test('String.trim() removes surrounding whitespace', () {
      var string = '  foo ';
      expect(string.trim(), equals('foo'));
    });

    test('Testing string splitting and merging', () {
      List<String> strings = [
        'tHIS is SomE TeXT',
        'More TEXT HERE',
        'AND more here',
        '23'
      ];

      List<String> expected = [
        'This is some text',
        'More text here',
        'And more here',
        '23'
      ];

      var counter = 0;

      for (var i in strings) {
        var firstLetter = i.toString().split('')[0].toUpperCase();;
        var afterFirstLetter = i.toString().substring(1, i.length).toLowerCase();

        var newString = '$firstLetter$afterFirstLetter';

        expect(newString, equals(expected[counter]));
        counter++;
      }
    });
  });


  group('List / Object', () {
    test('Testing object in array', () {
      List<Map<String, dynamic>> themes = [
        {'red': 17},
        {'blue': 32},
        {'green': 25},
        {'yellow': [92]}
      ];
  
      expect(themes[0]['red'], equals(17));
      expect(themes[2]['green'], equals(25));
      expect(themes[3]['yellow'][0], equals(92));
    });
  });
}
