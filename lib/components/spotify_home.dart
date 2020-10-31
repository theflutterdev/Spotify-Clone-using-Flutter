import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/logic/home_logic.dart';

class SpotifyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final sessionObject = Provider.of<SessionManagement>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home),
                Text("Home"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text("Search"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.library_music),
                Text("Library"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person_outline),
                Text("Premium"),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                    child: ChangeNotifierProvider(
                      create: (_)=>RecentlyPlayedLogic(),
                      child: RecenlyPlayed(),
                    ),
                  )
                  // MadeforYou(),
                  // RecomendedforYou(),
                  // PopularTrending(),
                  // EditorsPicks(),
                  // GlobalReleases(),
                  // BecauseYouLike(),

                  
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}

class RecenlyPlayed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayed = Provider.of<RecentlyPlayedLogic>(context);
    if(!recentlyPlayed.funCalled){
      recentlyPlayed.getSongHistory();
    }
    
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.settings),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
            child: Text("Recently played", style: TextStyle(
              fontFamily: 'Proxima Nova Bold',
              fontSize: 30.0
            ),),
          ),
        
          !recentlyPlayed.funCalled ? Center(
            child: CircularProgressIndicator(),
          ) : Container(
            height: MediaQuery.of(context).size.height*0.30,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: recentlyPlayed.recntlyPlayedStuff.length,
              itemBuilder: (context, i){
                return Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.height*0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: recentlyPlayed.recntlyPlayedStuff[i].type == "song" ? NetworkImage(recentlyPlayed.recntlyPlayedStuff[i].thumbnail) : AssetImage(recentlyPlayed.recntlyPlayedStuff[i].thumbnail),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(recentlyPlayed.recntlyPlayedStuff[i].title, style: TextStyle(
                        fontFamily: 'Proxima Nova Bold',
                        fontSize: 18.0,
                      ),),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}