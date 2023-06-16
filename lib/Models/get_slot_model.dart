class GetSlotModel {
  int? status;
  String? statusText;
  String? message;
  Data? data;
  int? exeTime;

  GetSlotModel(
      {this.status, this.statusText, this.message, this.data, this.exeTime});

  GetSlotModel.fromJson(Map<String, dynamic> json) {
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
  List<Slots>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Slots>[];
      json['data'].forEach((v) {
        data!.add(Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  String? sId;
  String? psychologist;
  List<FreeTimes>? freeTimes;
  List<FreeTimes>? paidSlots;
  List<FreeTimes>? freeSlots;
  List<FreeTimes>? paidTimes;
  String? day;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Slots(
      {this.sId,
      this.psychologist,
      this.freeTimes,
      this.paidSlots,
      this.freeSlots,
      this.paidTimes,
      this.day,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Slots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    psychologist = json['psychologist'];
    freeTimes = json["freeTimes"] == null
        ? null
        : (json["freeTimes"] as List)
            .map((e) => FreeTimes.fromJson(e))
            .toList();
    paidSlots = json["paidSlots"] == null
        ? null
        : (json["paidSlots"] as List)
            .map((e) => FreeTimes.fromJson(e))
            .toList();
    freeSlots = json["freeSlots"] == null
        ? null
        : (json["freeSlots"] as List)
            .map((e) => FreeTimes.fromJson(e))
            .toList();
    paidTimes = json["paidTimes"] == null
        ? null
        : (json["paidTimes"] as List)
            .map((e) => FreeTimes.fromJson(e))
            .toList();
    day = json['day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['psychologist'] = psychologist;
    if (freeTimes != null) {
      data['freeTimes'] = freeTimes!.map((v) => v.toJson()).toList();
    }
    if (paidSlots != null) {
      data['paidSlots'] = paidSlots!.map((v) => v.toJson()).toList();
    }
    if (freeSlots != null) {
      data['freeSlots'] = freeSlots!.map((v) => v.toJson()).toList();
    }
    if (paidTimes != null) {
      data['paidTimes'] = paidTimes!.map((v) => v.toJson()).toList();
    }
    data['day'] = day;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class FreeTimes {
  String? sId;
  String? from;
  String? to;

  FreeTimes({this.sId, this.from, this.to});

  FreeTimes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
