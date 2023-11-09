class AttachmentType {
  final int id;
  final String key;
  final String locale;
  final String name;
  final String iconUrl;
  final bool active;
  final int position;

  const AttachmentType({
    required this.id,
    required this.key,
    required this.locale,
    required this.name,
    required this.iconUrl,
    required this.active,
    required this.position,
  });

  static AttachmentType fromMap(Map json) {
    return AttachmentType(
      id: json["id"] ?? 0,
      key: json["key"] ?? "",
      locale: json["locale"] ?? "",
      name: json["name"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      active: json["active"] ?? false,
      position: json["position"] ?? 0,
    );
  }
}
