import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/views/image_view.dart';


Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    //mainAxisSize : MainAxisSize.min,
    children: <Widget>[
      Text(
        "myc",
        style: TextStyle(color: Colors.white, fontFamily: 'Overpass'),
      ),
      Text(
        "Walls",
        style: TextStyle(color: Colors.cyan, fontFamily: 'Overpass'),
      )
    ],
  );
}

Widget wallpapersList({required List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpapers){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ImageView(imgUrl: wallpapers.src!.portrait,
                )
                ));
            },
            child: Hero(
              tag: wallpapers.src!.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(wallpapers.src!.portrait, fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}