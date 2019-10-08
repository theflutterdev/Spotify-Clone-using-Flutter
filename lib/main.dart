import 'package:flutter/material.dart';
import 'package:spotify_clone/components/auth.dart';

void main(){
  runApp(MaterialApp(
    title: 'Spotify Clone',
    theme: ThemeData(
      fontFamily: 'Proxima Nova',
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}