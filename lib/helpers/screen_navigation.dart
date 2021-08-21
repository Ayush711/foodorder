import 'package:flutter/material.dart';
void changescreen(
  BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

}
void changescreenReplacment(
    BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));

}