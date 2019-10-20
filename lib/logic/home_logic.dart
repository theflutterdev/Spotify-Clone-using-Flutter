import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class RecentlyPlayedStuff{
  String id;
  String type;
  DateTime lastPlayed;
  String thumbnail;
  String title;

  RecentlyPlayedStuff({this.id, this.type, this.lastPlayed, this.thumbnail, this.title});
}

class RecentlyPlayedLogic extends ChangeNotifier{
  
  bool funCalled = false;

  List<RecentlyPlayedStuff> recntlyPlayedStuff = [];
  void getSongHistory()async{
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    print("Getting Data");
    QuerySnapshot qsnap = await Firestore.instance.collection("users").document(firebaseUser.uid).collection("songHistory").getDocuments();
    List<DocumentSnapshot> data = qsnap.documents;
    recntlyPlayedStuff = [];
    for(int i=0; i<data.length; i++){
      print("Id "+data[i]['songId']);
      await Firestore.instance.collection("songs").document(data[i]['songId']).get().then((documentSnapshot){
        recntlyPlayedStuff.add(
          RecentlyPlayedStuff(
            id: data[i]['songId'],
            lastPlayed: data[i]['lastPlayed'],
            thumbnail: documentSnapshot.data['songThumbnail'],
            type: 'song',
            title: documentSnapshot.data['songTitle'],
          )
        );
      });
    
    }
    getPlaylistHis();
  }

  void getPlaylistHis()async{
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qsnap = await Firestore.instance.collection("users").document(firebaseUser.uid).collection("playlistHistory").getDocuments();
    List<DocumentSnapshot> data = qsnap.documents;
    for(int i=0; i<data.length; i++){
      await Firestore.instance.collection("users").document(data[i]['playlistUserId']).collection("userCreatedPlayLists").document(data[i]['playListId']).get().then((documentSnapshot){
        recntlyPlayedStuff.add(RecentlyPlayedStuff(
          id: data[i]['playListId'],
          thumbnail: './images/spotify_smaller.png',
          lastPlayed: data[i]['lastPlayed'],
          type: 'playlist',
          title: documentSnapshot['playlistName']
        ));
      });
    }
    funCalled = true;
    notifyListeners();
  }

}