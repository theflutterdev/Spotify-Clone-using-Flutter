import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/components/auth.dart';
import 'package:spotify_clone/logic/auth_logic.dart';

class SpotifyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Spotify"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Welcome Home : "),
            RaisedButton(
              onPressed: ()async{
                if(await sessionObject.logout()){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Material(
                    child: ChangeNotifierProvider(
                      builder: (_)=>SessionManagement(),
                      child: FirebaseSession(),
                    ),
                  ),), (Route<dynamic> route)=>false);
                }else{

                }
              },
              child: Text("Log out"),
            )
          ],
        ),
      )
    );
  }
}