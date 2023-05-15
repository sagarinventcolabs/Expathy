class LanguageListModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  LanguageListModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  LanguageListModel.fromJson(Map<String, dynamic> json) {
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
  List<Data1>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data1 {
  bool? isStatus;
  bool? isDeleted;
  String? id;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data1(
      {this.isStatus,
      this.isDeleted,
      this.id,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.v});

  Data1.fromJson(Map<String, dynamic> json) {
    isStatus = json["is_status"];
    isDeleted = json["is_deleted"];
    id = json["_id"];
    name = json["name"];
    value = json["value"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_status"] = isStatus;
    _data["is_deleted"] = isDeleted;
    _data["_id"] = id;
    _data["name"] = name;
    _data["value"] = value;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
