class Store {
  late final String code;
  late final String name;
  late final String addr;
  late final String type;
  late final double lat;
  late final double lng;
  late final String stockAt;
  late final String remainStat;
  late final String createdAt;
  late double km;

  Store(
      {required this.code,
       required this.name,
       required this.addr,
       required this.type,
       required this.lat,
       required this.lng,
       required this.stockAt,
       required this.remainStat,
       required this.createdAt});

  Store.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    addr = json['addr'] ?? '';
    type = json['type'] ?? '';
    lat = json['lat'] ?? 0.0;
    lng = json['lng'] ?? 0.0;
    stockAt = json['stock_at'] ?? '';
    remainStat = json['remain_stat'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['addr'] = this.addr;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['stock_at'] = this.stockAt;
    data['remain_stat'] = this.remainStat;
    data['created_at'] = this.createdAt;
    return data;
  }
}
