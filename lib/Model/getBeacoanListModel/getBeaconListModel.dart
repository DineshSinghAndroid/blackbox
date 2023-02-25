class GetBeaconListModel {
  String? beacon;
  String? assetName;

  GetBeaconListModel({this.beacon, this.assetName});

  GetBeaconListModel.fromJson(Map<String, dynamic> json) {
    beacon = json['beacon'];
    assetName = json['asset_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beacon'] = this.beacon;
    data['asset_name'] = this.assetName;
    return data;
  }
}
