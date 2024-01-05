class Attachment {
  final String name;
  final String key;
  final String type;
  final String iconUrl;
  final String contentType;
  final String location;
  final String preview;
  final int sizeInKb;

  const Attachment({
    this.name = "",
    this.key = "",
    this.type = "",
    this.iconUrl = "",
    this.contentType = "",
    this.location = "",
    this.preview = "",
    this.sizeInKb = 0,
  });

  static Attachment fromJson(Map map) {
    return Attachment(
      name: map["name"] ?? "",
      key: map["key"] ?? "",
      type: map["type"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
      contentType: map["contentType"] ?? "",
      location: map["location"] ?? "",
      preview: map["preview"] ?? "",
      sizeInKb: map["sizeInKb"] ?? 0,
    );
  }
}
