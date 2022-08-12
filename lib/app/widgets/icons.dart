import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/core/values/color.dart';

class ToDoIcons{
  static Map<String, Icon> taskIcons(){
    return{
      personal : Icon(Icons.person,color: ToDoColor.iconColors[personal]),
      work :  Icon(Icons.business_center, color: ToDoColor.iconColors[work]),
      movie :  Icon(Icons.live_tv, color: ToDoColor.iconColors[movie],),
      sport :  Icon(Icons.pool, color: ToDoColor.iconColors[sport],),
      travel :   Icon(Icons.travel_explore, color: ToDoColor.iconColors[travel],),
      shop :  Icon(Icons.shopping_bag, color: ToDoColor.iconColors[shop],),
      game : Icon(Icons.gamepad, color: ToDoColor.iconColors[game],)
    };
    // [
    //   const Icon(Icons.person,color: ToDoColor.purple,),
    //   const Icon(Icons.business_center, color: ToDoColor.pink,),
    //   const Icon(Icons.live_tv, color: ToDoColor.green,),
    //   const Icon(Icons.pool, color: ToDoColor.yellow,),
    //   const Icon(Icons.travel_explore, color: ToDoColor.deepPink,),
    //   const Icon(Icons.shopping_bag, color: ToDoColor.lightBlue,)
    // ];
  }
}