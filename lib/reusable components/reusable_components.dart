import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context,widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => widget,), (Route<dynamic> route) => false);

Widget formfield({
  required TextEditingController controller,
  Function(String)? sumbit,
  dynamic change,
  required String? Function(String?)? validate,
  required TextInputType type,
  required String label,
  required Icon prefix,
  var suffix,
  bool ispassword = false,
  bool isClick=true,
}) =>
    TextFormField(
      validator: validate,
      onChanged: change,
      controller: controller,
      onFieldSubmitted: sumbit,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        // ignore: unnecessary_string_interpolations
        labelText: '$label',
        border: const OutlineInputBorder(),
        prefixIcon: prefix,
        suffixIcon: suffix,
        enabled: isClick,
      ),
    );

    toast(String msg,Color color,int time)=>
    Fluttertoast.showToast(
         msg:msg ,
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: time,
         backgroundColor: color,
         textColor: Colors.white,
         fontSize: 16.0
         );

  Widget hr({Color color=Colors.black})=>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: color,
      ),
    );
String ? token="";