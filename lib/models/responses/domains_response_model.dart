class Domain {
  final int position;
  final String key;
  final String backgroundColorHex;
  final String localizedName;
  final String iconUrl;

  const Domain({
    required this.iconUrl,
    required this.key,
    required this.localizedName,
    required this.backgroundColorHex,
    required this.position,
  });

  static Domain fromMap(Map json) {
    return Domain(
      position: json["position"] ?? 0,
      key: json["key"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      localizedName: json["name"] ?? "",
      backgroundColorHex: json["backgroundColorHex"] ?? "",
    );
  }
}
