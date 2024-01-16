class AddPostResModel {
  bool? status;
  String? message;
  int? postId;

  AddPostResModel({this.status, this.message, this.postId});

  AddPostResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['post_id'] = this.postId;
    return data;
  }
}
