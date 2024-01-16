class AddSubMenuItemsReqModel {
  String? action;
  String? menuSubCategoryId;
  List<SubMenuItem>? subMenuItem;

  AddSubMenuItemsReqModel(
      {this.action, this.menuSubCategoryId, this.subMenuItem});

  AddSubMenuItemsReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    menuSubCategoryId = json['menu_sub_category_id'];
    if (json['sub_menu_item'] != null) {
      subMenuItem = <SubMenuItem>[];
      json['sub_menu_item'].forEach((v) {
        subMenuItem!.add(new SubMenuItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    if (this.subMenuItem != null) {
      data['sub_menu_item'] = this.subMenuItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubMenuItem {
  String? id;
  String? type;
  String? name;
  String? price;

  SubMenuItem({this.id, this.type, this.name, this.price});

  SubMenuItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
