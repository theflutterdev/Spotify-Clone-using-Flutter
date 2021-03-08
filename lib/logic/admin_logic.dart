import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Admin extends ChangeNotifier{

  String name, coverUrl;
  void addArtist(String name, String imageUrl){
    try{
      var ref = FirebaseFirestore.instance.collection("artists").doc();
      ref.set({
        "artistId": ref.id,
        "name": name,
        "artistIndex": name[0],
        "date": DateTime.now(),
        "followers": 0,
        "monthlyListerners": 0,
        "coverImageUrl": imageUrl
      }).then((doc){
        print("Perfect");
      }).catchError((e){
        print(e);
      });
    }catch(e){
      print(e.message);
    }
  }

  String catName, catImageUrl;
  void addCategory(String title, String thumbnailUrl){
    var ref = FirebaseFirestore.instance.collection("categories").doc();
    ref.set({
      "categoryId": ref.id,
      "isActive": true,
      "categoryTitle": title,
      "categoryThumbnailUrl": thumbnailUrl,
      "categoryIndex": title[0]
    }).then((E){
      print("Perfect");
    }).catchError((e){
      print(e);
    });
  }

  reloadTheState(){
    notifyListeners();
  }


  String audioName, audioUrl, performedBy, writtenBy, producedBy, source,songThumbnail;
  List<Map<String, dynamic>> lyrics = [];
  Map<String, dynamic> albumofSong;

  //For Searching
  List<DocumentSnapshot> data = [];
  List<DocumentSnapshot> qdata = [];
  List<DocumentSnapshot> catData = [];
  List<DocumentSnapshot> qcatData = [];
 
  void addSongs(String title, String audioUrl, String performedBy, String writtenBy, String producedBy, String source, String artistIdInside, String songthumbnail, List<Map<String, dynamic>> categories, List<Map<String, dynamic>> lyrics, Map<String, dynamic> albumInfo){
    var ref = FirebaseFirestore.instance.collection("songs").doc();
    print(artistIdInside);
    ref.set({
      "songId": ref.id,
      "songTitle": title,
      "songIndex": title[0],
      "songThumbnail": songthumbnail,
      "releasedTimestamp": DateTime.now(),
      "audioUrl": audioUrl,
      "performedBy": performedBy,
      "writtenBy": writtenBy,
      "producedBy": producedBy,
      "source": source,
      "numberOfPlays": 0,
      "artistId": artistIdInside,
      "categories": categories,
      "lyrics": lyrics,
      "album": albumInfo
    }).then((doc){
      print("Perfect");
    }).catchError((e){
      print(e);
    });
  }


  String albumTitle, copyrightOwnership, albumThumbnail;
  void addAlbum(String artistId ,String title, String copyrightOwnership, String albumThumbnail){
    var ref = FirebaseFirestore.instance.collection("albums").doc();
    ref.set({
      "albumId": ref.id,
      "artistId": artistId,
      "albumTitle": title,
      "albumIndex": title[0],
      "releasedTime": DateTime.now(),
      "copyrightOwnership": copyrightOwnership,
      "albumThumbnail": albumThumbnail,
    }).then((doc){
      print("Perfect!");
    }).catchError((e){
      print(e);
    });
  }
}