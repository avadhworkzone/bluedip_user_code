class UploadProfilePicResModel {
  String? uploadURL;
  String? key;

  UploadProfilePicResModel({this.uploadURL, this.key});

  UploadProfilePicResModel.fromJson(Map<String, dynamic> json) {
    uploadURL = json['uploadURL'];
    key = json['Key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadURL'] = this.uploadURL;
    data['Key'] = this.key;
    return data;
  }
}
