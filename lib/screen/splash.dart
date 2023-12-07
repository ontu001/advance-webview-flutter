import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weads/screen/home_screen.dart';

class SplasH extends StatefulWidget{
  @override
  State<SplasH> createState() => _SplasHState();
}

class _SplasHState extends State<SplasH> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text('Google',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Colors.white),),),
      ),
    );
  }
}