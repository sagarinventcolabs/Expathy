class FirstQuestionModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  FirstQuestionModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  FirstQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusText = json["statusText"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    exeTime = json["exeTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["statusText"] = statusText;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["exeTime"] = exeTime;
    return _data;
  }
}

class Data {
  List<String>? options;
  bool? isStatus;
  bool? isDeleted;
  String? id;
  String? language;
  String? question;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data(
      {this.options,
      this.isStatus,
      this.isDeleted,
      this.id,
      this.language,
      this.question,
      this.createdAt,
      this.updatedAt,
      this.v});

  Data.fromJson(Map<String, dynamic> json) {
    options =
        json["options"] == null ? null : List<String>.from(json["options"]);
    isStatus = json["is_status"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    language = json["language"];
    question = json["question"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (options != null) {
      _data["options"] = options;
    }
    _data["is_status"] = isStatus;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
    _data["language"] = language;
    _data["question"] = question;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
