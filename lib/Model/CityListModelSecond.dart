import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class CityListModelSecond{
  String title;
  bool isWantDelete = false;

  CityListModelSecond(this.title,this.isWantDelete);
}

List<CityListModelSecond>modelArrayList = [];