class UploadProfilePicReqModel {
  String? folder;
  String? fileName;
  String? contentType;

  UploadProfilePicReqModel({this.folder, this.fileName, this.contentType});

  UploadProfilePicReqModel.fromJson(Map<String, dynamic> json) {
    folder = json['folder'];
    fileName = json['file_name'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['folder'] = this.folder;
    data['file_name'] = this.fileName;
    data['contentType'] = this.contentType;
    return data;
  }
}
