class ModelDeviceRegister {
  String? qrcode;
  String? username;
  String? password;
  String? assetName;
  String? message;

  ModelDeviceRegister(
      {this.qrcode, this.username, this.password, this.assetName,this.message});

  ModelDeviceRegister.fromJson(Map<String, dynamic> json) {
    qrcode = json['qrcode'];
    username = json['username'];
    password = json['password'];
    assetName = json['asset_name'];
    message = json['message'] ?? "No Message";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrcode'] = this.qrcode;
    data['username'] = this.username;
    data['password'] = this.password;
    data['asset_name'] = this.assetName;
    data['message'] = this.message ?? "No Message";
    return data;
  }
}
