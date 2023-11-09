class Domains {
  final int position;
  final String key;
  final String backgroundColorHex;
  final String localizedName;
  final String iconURL;

  const Domains({
    required this.iconURL,
    required this.key,
    required this.localizedName,
    required this.backgroundColorHex,
    required this.position,
  });

  static Domains fromMap(Map json) {
    return Domains(
      position: json["position"] ?? 0,
      key: json["key"] ?? "",
      iconURL: json["iconUrl"] ?? "",
      localizedName: json["name"] ?? "",
      backgroundColorHex: json["backgroundColorHex"] ?? "",
    );
  }
}
