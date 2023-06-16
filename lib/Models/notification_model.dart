class NotificationModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  NotificationModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusText = json['statusText'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    exeTime = json['exeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusText'] = statusText;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['exeTime'] = exeTime;
    return data;
  }
}

class Data {
  List<NotificationDoc>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prevPage;
  int? nextPage;

  Data(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.page,
      this.totalPages,
      this.pagingCounter,
      this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <NotificationDoc>[];
      json['docs'].forEach((v) {
        docs!.add(NotificationDoc.fromJson(v));
      });
    }
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    page = json['page'];
    totalPages = json['totalPages'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['totalDocs'] = totalDocs;
    data['limit'] = limit;
    data['page'] = page;
    data['totalPages'] = totalPages;
    data['pagingCounter'] = pagingCounter;
    data['hasPrevPage'] = hasPrevPage;
    data['hasNextPage'] = hasNextPage;
    data['prevPage'] = prevPage;
    data['nextPage'] = nextPage;
    return data;
  }
}

class NotificationDoc {
  String? sId;
  String? type;
  String? image;
  bool? allUser;
  bool? isRead;
  String? user;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationDoc(
      {this.sId,
      this.type,
      this.image,
      this.allUser,
      this.user,
      this.title,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isRead});

  NotificationDoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    image = json['image'];
    allUser = json['allUser'];
    user = json['user'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRead = json["is_read"];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['image'] = image;
    data['allUser'] = allUser;
    data['user'] = user;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    data['is_read'] = isRead;
    return data;
  }
}
