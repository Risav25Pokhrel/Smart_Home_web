class deviceinfo {
  List<Response>? response;
  int? code;
  String? message;

  deviceinfo({this.response, this.code, this.message});

  deviceinfo.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Response {
  int? id;
  String? deviceId;
  String? state;
  int? deviceType;
  int? mode;
  String? name;
  String? qr;
  int? room;
  bool? smartConf;
  List<String>? users;
  double? version;
  int? bmsType;
  Null? subDevices;
  Null? sharer;
  Null? otaVersion;
  Null? otaLink;
  Null? otaStatus;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  Response(
      {this.id,
      this.deviceId,
      this.state,
      this.deviceType,
      this.mode,
      this.name,
      this.qr,
      this.room,
      this.smartConf,
      this.users,
      this.version,
      this.bmsType,
      this.subDevices,
      this.sharer,
      this.otaVersion,
      this.otaLink,
      this.otaStatus,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.createdBy});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    state = json['state'];
    deviceType = json['deviceType'];
    mode = json['mode'];
    name = json['name'];
    qr = json['qr'];
    room = json['room'];
    smartConf = json['smartConf'];
    users = json['users'].cast<String>();
    version = json['version'];
    bmsType = json['bmsType'];
    subDevices = json['subDevices'];
    sharer = json['sharer'];
    otaVersion = json['otaVersion'];
    otaLink = json['otaLink'];
    otaStatus = json['otaStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['state'] = state;
    data['deviceType'] = deviceType;
    data['mode'] = mode;
    data['name'] = name;
    data['qr'] = qr;
    data['room'] = room;
    data['smartConf'] = smartConf;
    data['users'] = users;
    data['version'] = version;
    data['bmsType'] = bmsType;
    data['subDevices'] = subDevices;
    data['sharer'] = sharer;
    data['otaVersion'] = otaVersion;
    data['otaLink'] = otaLink;
    data['otaStatus'] = otaStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['createdBy'] = createdBy;
    return data;
  }
}
