import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

String calculatePassword(String pin, String keyword){
  // input checking
  if(pin.length != 4){
    return 'Invalid pin';
  } else if(int.tryParse(pin) == null){
    return 'Invalid pin';
  } else if(int.parse(pin) < 0){
    return 'Stop trying to break my app (no negative pins!)';
  } else if(pin.substring(3,4) == ' '){
    return 'Invalid pin';
  } else if(keyword.isEmpty){
    return 'Invalid keyword';
  }

  var bytes1 = utf8.encode(pin+keyword);  // data being hashed
  var digest1 = sha512.convert(bytes1);
  String raw_password = digest1.toString();

  // calculate shift distance. where should password begin? length of keyword.
  int shift_distance = keyword.length;

  // if keyword is 7 characters long, start at index 7 go to index 17 (always 10 long)
  String password = raw_password.substring(shift_distance, shift_distance+10);

  // break pin into 4 numbers. first, second, third, fourth
  int pin_first = int.parse(pin.substring(0,1));
  //int pin_second = int.parse(pin.substring(1,2));
  //int pin_third = int.parse(pin.substring(2,3));
  int pin_fourth = int.parse(pin.substring(3,4));

  // first character of string version of sha512 (index 0)
  // get second character of string (index 1)
  // convert both into ascii so theyre in number form
  int sha_first_ascii = raw_password.codeUnitAt(0);
  int sha_second_ascii = raw_password.codeUnitAt(1);

  if(sha_first_ascii >= 9){
    sha_first_ascii = sha_first_ascii % 10;
  }
  if(sha_second_ascii >= 9){
    sha_second_ascii = sha_second_ascii % 10;
  }

  // SUM1 = take the sum of the ascii of first index 0 and the 1st digit from the pin
  // this should be a value from 0 to 18.
  // SUM2 = take ascii value of second digit, sum it with the 4th digit of the pin
  int sum1 = sha_first_ascii + pin_first;
  int sum2 = sha_first_ascii + pin_fourth;

  List<String> special = ["!", "#", "\$", "%", "&", "*", "+", "-", "{", "/", ":", ";", "<", "=", ">", "?",
   			"@", "~", "}" ];
  List<String> caps = [ "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S",
   			"T", "U" ];

  // go into caps array, and pull out the index that is at SUM1 index.
  // go into special array, pull out index SUM2
  String capital_letter = caps[sum1];
  String special_char = special[sum2];

  // add the capital letter to the location to the right of the first ascii value (of index 0).
  // so, if it was index 7 , then stick it at index 8 but don't replace index 8. should make password 1 character longer
  // do same thing with second ascii value, with special character
  password = password.substring(0, sha_first_ascii) + capital_letter + password.substring(sha_first_ascii);
  password = password.substring(0, sha_second_ascii) + special_char + password.substring(sha_second_ascii);

  return password;
}