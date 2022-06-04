import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/widgets.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search > {
  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async{
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
    headers: {"Authorization": apiKEY});

    Map<String, dynamic> jsonData= jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text=widget.searchQuery;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 11, 31),
      appBar: AppBar(
        backgroundColor: Color(0xff152238),
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(22)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "search",
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      getSearchWallpapers(searchController.text);
                    },
                    child: Container(
                      child: Icon(Icons.search)),
                  )
                ],),
              ),
              SizedBox(height: 16,),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],),),
      ),
    );
  }
}