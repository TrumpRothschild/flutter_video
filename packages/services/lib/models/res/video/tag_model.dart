import 'dart:ui';
import 'package:base/commons/utils/judge_string_utils.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:flutter/material.dart';

class TagModel {
  int? id;
  String? name;
  List<TagSubModel>? tagList;

  TagModel({this.id, this.name, this.tagList});

  TagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    String tagStr = json['tagList'];
    if (tagStr.isNotEmpty) {
      List<String> list = tagStr.split(",");
      List<TagSubModel> saveList = [];
      for (var str in list) {
        TagSubModel model = TagSubModel.fromJson(str);
        if (str.contains("_")) {
          if (model.tag == 1) {
            saveList.add(model);
          }
        } else {
          saveList.add(model);
        }
      }
      tagList = saveList;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagList'] = this.tagList;
    return data;
  }
}

class TagNewModel {
  int? id;
  String? name;
  List<TagSubModel>? tagList;

  TagNewModel({this.id, this.name, this.tagList});

  TagNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    String tagStr = json['tagList'];
    if (tagStr.isNotEmpty) {
      List<String> list = tagStr.split(",");
      List<TagSubModel> saveList = [];
      for (var str in list) {
        TagSubModel model = TagSubModel.fromJson(str);
        if (str.contains("_")) {
          if (model.tag == 1) {
            saveList.add(model);
          }
        } else {
          saveList.add(model);
        }
      }
      tagList = saveList;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagList'] = this.tagList;
    return data;
  }
}

class TagSubModel {
  bool? isSelected = false;
  String? name;
  int? tag;
  double? tagWidth;

  TagSubModel({this.isSelected, this.name, this.tagWidth});

  TagSubModel.fromJson(String jsonString) {
    if (jsonString.contains("_")) {
      List<String> list = jsonString.split("_");
      if (list.length ==2) {
        name = list[0];
        tag = int.parse(list[1]);
      } else {
        name = jsonString;
        tag = 0;
      }
      tagWidth = StringUtil.boundingTextSize(name!,TextStyle(fontSize:sp(24))).width*2+50;
    } else {
      name = jsonString;
      tag = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["isSelected"] = this.isSelected;
    return data;
  }
}
