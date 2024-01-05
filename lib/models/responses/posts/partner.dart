class Partner {
  final String key;
  final String name;
  final String iconUrl;

  const Partner({
    required this.key,
    required this.name,
    required this.iconUrl,
  });

  static Partner fromMap(Map map) {
    return Partner(
      key: map["key"] ?? "",
      name: map["name"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
    );
  }
}
