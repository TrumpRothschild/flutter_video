class VideoCategoryModel {
  List<CategoryList>? categoryList;
  String? categoryName;
  int? id;
  bool? isSelect = false;

  VideoCategoryModel({this.categoryList, this.categoryName, this.id, this.isSelect});

  VideoCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
    categoryName = json['categoryName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    return data;
  }

}

class CategoryList {
  String? categoryName;
  int? id;
  bool? isSelect = false;

  CategoryList({this.categoryName, this.id, this.isSelect});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['categoryName'] = categoryName;
    data['id'] = this.id;
    return data;
  }
}
