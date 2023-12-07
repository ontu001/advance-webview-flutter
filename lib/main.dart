import 'package:flutter/material.dart';
import 'package:weads/screen/home_screen.dart';
import 'package:weads/screen/splash.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Ads',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFe01559),
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFFe01559),
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: Colors.white
              )
          )
      ),

      home: SplasH(),
    );
  }

}

