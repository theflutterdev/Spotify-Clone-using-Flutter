import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/logic/admin_logic.dart';

class SpotifyAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                    child: ChangeNotifierProvider(
                      builder: (_)=>Admin(),
                      child: AddArtist(),
                    ),
                  )));
                },
                child: ListTile(
                  title: Text("Add a new artists"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                    child: ChangeNotifierProvider(
                      builder: (_)=>Admin(),
                      child: AddCategory(),
                    ),
                  )));
                },
                child: ListTile(
                  title: Text("Add a new Category of Music"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                    child: ChangeNotifierProvider(
                      builder: (_)=>Admin(),
                      child: AddSong(),
                    ),
                  )));
                },
                child: ListTile(
                  title: Text("Add a new Song"),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                    child: ChangeNotifierProvider(
                      builder: (_)=>Admin(),
                      child: AddAlbum(),
                    ),
                  )));
                },
                child: ListTile(
                  title: Text("Create a new Album"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AddArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Artist"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Artist Name'
                  ),
                  onChanged: (String text){
                    adminObj.name = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Cover Image URL',
                  ),
                  onChanged: (String text){
                    adminObj.coverUrl = text;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    adminObj.addArtist(adminObj.name, adminObj.coverUrl);
                  },
                  child: Text("Add Artist"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category Name'
                  ),
                  onChanged: (String text){
                    adminObj.catName = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category Image URL',
                  ),
                  onChanged: (String text){
                    adminObj.catImageUrl = text;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    adminObj.addCategory(adminObj.catName, adminObj.catImageUrl);
                  },
                  child: Text("Add Artist"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String artistId;
List<Map<String, dynamic>> categoriesOfMusic = [];

class AddSong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Song"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Song Name'
                  ),
                  onChanged: (String text){
                    adminObj.audioName = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Song Mp3 link',
                  ),
                  onChanged: (String text){
                    adminObj.audioUrl = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Song Thumnail URL',
                  ),
                  onChanged: (String text){
                    adminObj.songThumbnail = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Performed By',
                  ),
                  onChanged: (String text){
                    adminObj.performedBy = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Written By',
                  ),
                  onChanged: (String text){
                    adminObj.writtenBy = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Produced By',
                  ),
                  onChanged: (String text){
                    adminObj.producedBy = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Source',
                  ),
                  onChanged: (String text){
                    adminObj.source = text;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                      child: ChangeNotifierProvider(
                        builder: (_)=>Admin(),
                        child: SelectArtist(),
                      ),
                    )));
                  },  
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: artistId !=null ? Text(artistId) : Text("Select the Artist"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                      child: ChangeNotifierProvider(
                        builder: (_)=>Admin(),
                        child: SelectCategories(),
                      ),
                    )));
                  },  
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: categoriesOfMusic !=null ? Text(categoriesOfMusic.toString()) : Text("Select the Categories"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    adminObj.addSongs(adminObj.audioName, adminObj.audioUrl, adminObj.performedBy, adminObj.writtenBy, adminObj.producedBy, adminObj.source, artistId, categoriesOfMusic, adminObj.lyrics, adminObj.albumofSong);
                  },
                  child: Text("Add Song"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class AddAlbum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Album"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Album Title'
                  ),
                  onChanged: (String text){
                    adminObj.albumTitle = text;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Copyright Ownership'
                  ),
                  onChanged: (String text){
                    adminObj.copyrightOwnership = text;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Thumbnail URL'
                  ),
                  onChanged: (String text){
                    adminObj.albumThumbnail = text;
                  },
                ),
                
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>Material(
                      child: ChangeNotifierProvider(
                        builder: (_)=>Admin(),
                        child: SelectArtist(),
                      ),
                    )));
                  },  
                  child: Container(
                    color: Colors.cyan,
                    padding: EdgeInsets.all(10.0),
                    child: artistId !=null ? Text(artistId) : Text("Select the Artist"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    adminObj.addAlbum(artistId, adminObj.albumTitle, adminObj.copyrightOwnership, adminObj.albumThumbnail);
                  },
                  child: Text("Add Album"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



//Tools for Selecting and Searching

class SelectArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Artist"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Search'
                                    ),
                                    onChanged: (String q)async{
                                      q = q.toUpperCase();
                                      if(q.length == 1){
                                        QuerySnapshot qsnap = await Firestore.instance.collection("artists").where("artistIndex", isEqualTo: q.toUpperCase()).getDocuments();
                                        adminObj.data = qsnap.documents;
                                        adminObj.qdata = adminObj.data;
                                        adminObj.reloadTheState();
                                      }else{
                                        adminObj.qdata = [];
                                        for(int i = 0; i< adminObj.data.length; i++){
                                          //print(adminObj.data[i]['name'].toString().toUpperCase()+ ", Query is : "+q);
                                          if(adminObj.data[i]['name'].toString().toUpperCase().contains(q)){
                                            adminObj.qdata.add(adminObj.data[i]);
                                          }
                                        }
                                        adminObj.reloadTheState();
                                      }
                                    },
                                  ),
                                ),
                                adminObj.qdata != null ? adminObj.qdata.length == 0 ? Center(
                                  child: CircularProgressIndicator(),
                                ) : Container(
                                  height: 100.0,
                                  child: ListView.builder(
                                    itemCount: adminObj.qdata.length,
                                    itemBuilder: (context, i){
                                      return ListTile(
                                        title: Text(adminObj.qdata[i]['name']),
                                        subtitle: Text(adminObj.qdata[i]['artistId']),
                                        trailing: RaisedButton(
                                          color: Colors.black,
                                          onPressed: (){
                                            artistId = adminObj.qdata[i]['artistId'].toString();
                                            Navigator.pop(context);
                                          },
                                          child: Text("Select"),
                                        ),
                                      );
                                    },
                                    
                                  ),
                                ) : Text("Start Searching")
                              ],
                            ),
                          ),
    );
  }
}


class SelectCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminObj = Provider.of<Admin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Categories"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Search'
                                    ),
                                    onChanged: (String q)async{
                                      q = q.toUpperCase();
                                      if(q.length == 1){
                                        QuerySnapshot qsnap = await Firestore.instance.collection("categories").where("categoryIndex", isEqualTo: q.toUpperCase()).getDocuments();
                                        adminObj.catData = qsnap.documents;
                                        adminObj.qcatData = adminObj.catData;
                                        adminObj.reloadTheState();
                                      }else{
                                        adminObj.qcatData = [];
                                        for(int i = 0; i< adminObj.catData.length; i++){
                                          //print(adminObj.data[i]['name'].toString().toUpperCase()+ ", Query is : "+q);
                                          if(adminObj.catData[i]['name'].toString().toUpperCase().contains(q)){
                                            print("Adding some");
                                            adminObj.qcatData.add(adminObj.data[i]);
                                          }
                                        }
                                        adminObj.reloadTheState();
                                      }
                                    },
                                  ),
                                ),
                                adminObj.qcatData != null ? adminObj.qcatData.length == 0 ? Center(
                                  child: CircularProgressIndicator(),
                                ) : Container(
                                  height: 100.0,
                                  child: ListView.builder(
                                    itemCount: adminObj.qcatData.length,
                                    itemBuilder: (context, i){
                                      return ListTile(
                                        title: Text(adminObj.qcatData[i]['categoryTitle']),
                                        subtitle: Text(adminObj.qcatData[i]['categoryId']),
                                        trailing: RaisedButton(
                                          color: Colors.black,
                                          onPressed: (){
                                            categoriesOfMusic.add({
                                              "categoryId": adminObj.qcatData[i]['categoryId'],
                                            });
                                          },
                                          child: Text("Select"),
                                        ),
                                      );
                                    },
                                    
                                  ),
                                ) : Text("Start Searching")
                              ],
                            ),
                          ),
    );
  }
}