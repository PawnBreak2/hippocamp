class CreatePost {
  final String title;
  final String description;
  final String categoryKey;
  final List<String> contacts;
  final List<String> businessPartners;
  final String latitude;
  final String longitude;
  final String address;
  final bool important;
  final bool canceled;
  final bool uncertain;
  final bool sensitiveInfo;
  final String type;
  final String visualization;
  final String rating;
  final String from;
  final String to;
  final String interval;
  final String date;
  final String at;
  final String within;
  final bool morning;
  final bool afternoon;
  final bool evening;
  final bool wholeDay;
  final List<SinglePartyTransaction>? singlePartyTransactions;
  final MultiPartyTransaction? multiPartyTransaction;
  final List<Attachments> attachments;
  final bool notificationsActive;
  final String notificationsUnit;
  final String businessPartnerBranch;

  const CreatePost({
    required this.title,
    required this.description,
    required this.categoryKey,
    required this.contacts,
    required this.businessPartners,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.important,
    required this.canceled,
    required this.uncertain,
    required this.sensitiveInfo,
    required this.type,
    required this.visualization,
    required this.rating,
    required this.from,
    required this.to,
    required this.interval,
    required this.date,
    required this.at,
    required this.within,
    required this.morning,
    required this.afternoon,
    required this.evening,
    required this.wholeDay,
    this.singlePartyTransactions,
    this.multiPartyTransaction,
    required this.attachments,
    required this.notificationsActive,
    required this.notificationsUnit,
    required this.businessPartnerBranch,
  });

  static CreatePost fromJson(Map map) {
    return CreatePost(
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      categoryKey: map["categoryKey"] ?? "",
      contacts: map["contacts"] ?? [],
      businessPartners: map["partner"] ?? "",
      latitude: map["latitude"] ?? "",
      longitude: map["longitude"] ?? "",
      address: map["address"] ?? "",
      important: map["important"] ?? false,
      canceled: map["canceled"] ?? false,
      uncertain: map["uncertain"] ?? false,
      sensitiveInfo: map["sensitiveInfo"] ?? false,
      type: map["type"] ?? "",
      visualization: map["visualization"] ?? "",
      rating: map["rating"] ?? "",
      from: map["from"],
      to: map["to"],
      interval: map["interval"],
      date: map["date"] ?? "",
      at: map["at"],
      within: map["within"],
      morning: map["morning"] ?? false,
      afternoon: map["afternoon"] ?? false,
      evening: map["evening"] ?? false,
      wholeDay: map["wholeDay"] ?? false,
      singlePartyTransactions: map["singlePartyTransaction"] != null
          ? (map["singlePartyTransaction"] as List)
              .map((e) => SinglePartyTransaction.fromJson(e))
              .toList()
          : null,
      multiPartyTransaction:
          map["multiPartyTransaction"] ?? MultiPartyTransaction().toJson(),
      attachments: map["attachments"] ?? Attachments().toJson(),
      notificationsActive: map["notificationsActive"] ?? false,
      notificationsUnit: map["notificationsUnit"] ?? "",
      businessPartnerBranch: map["partnerBranch"] ?? "",
    );
  }

  Map toJson() {
    final Map<String, dynamic> map = {
      "title": title,
      "description": description,
      "categoryKey": categoryKey,
      "contacts": contacts.isEmpty ? null : contacts,
      "partners": businessPartners.isEmpty ? null : businessPartners,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "important": important,
      "canceled": canceled,
      "uncertain": uncertain,
      "sensitiveInfo": sensitiveInfo,
      "type": type,
      "visualization": visualization,
      "rating": rating,
      "from": from,
      "to": to,
      "interval": interval,
      "date": date,
      "at": at,
      "within": within,
      "morning": morning,
      "afternoon": afternoon,
      "evening": evening,
      "wholeDay": wholeDay,
      "singlePartyTransactions":
          singlePartyTransactions?.map((e) => e.toJson()).toList(),
      "multiPartyTransaction": multiPartyTransaction?.toJson(),
      "attachments": attachments.isEmpty
          ? null
          : attachments.map((e) => e.toJson()).toList(),
      "notificationsActive": notificationsActive,
      "notificationsUnit": notificationsUnit,
      "partnerBranch": businessPartnerBranch,
    };

    map.removeWhere(
      (key, value) => value == null || (value is String && value.isEmpty),
    );

    return map;
  }
}

class SinglePartyTransaction {
  final double amount;
  final bool planned;
  final bool taxRelevant;
  final bool ordinary;
  final bool variable;
  final String date;
  final String type;
  final String walletKey;

  const SinglePartyTransaction({
    this.amount = 0,
    this.planned = false,
    this.taxRelevant = false,
    this.ordinary = false,
    this.variable = false,
    this.date = "",
    this.type = "",
    this.walletKey = "",
  });

  static SinglePartyTransaction fromJson(Map map) {
    return SinglePartyTransaction(
      amount: map["amount"] ?? 0,
      planned: map["planned"] ?? true,
      taxRelevant: map["taxRelevant"] ?? true,
      ordinary: map["ordinary"] ?? true,
      variable: map["variable"] ?? true,
      date: map["date"] ?? "",
      type: map["type"] ?? "",
      walletKey: map["walletKey"] ?? "",
    );
  }

  Map toJson() {
    final map = {
      "amount": amount,
      "planned": planned,
      "taxRelevant": taxRelevant,
      "ordinary": ordinary,
      "variable": variable,
      "date": date,
      "type": type,
      "walletKey": walletKey,
    };
    map.removeWhere((key, value) => (value is String && value.isEmpty));

    return map;
  }
}

class MultiPartyTransaction {
  final double amountIn;
  final double amountOut;
  final String date;
  final String type;
  final String categoryKey;
  final String fromWalletKey;
  final String toWalletKey;

  const MultiPartyTransaction({
    this.amountIn = 0,
    this.amountOut = 0,
    this.date = "",
    this.type = "",
    this.categoryKey = "",
    this.fromWalletKey = "",
    this.toWalletKey = "",
  });

  static MultiPartyTransaction fromJson(Map map) {
    return MultiPartyTransaction(
      amountIn: map["amountIn"] ?? 0,
      amountOut: map["amountOut"] ?? 0,
      date: map["date"] ?? "",
      type: map["type"] ?? "",
      categoryKey: map["categoryKey"] ?? "",
      fromWalletKey: map["fromWalletKey"] ?? "",
      toWalletKey: map["toWalletKey"] ?? "",
    );
  }

  Map toJson() {
    return {
      "amountIn": amountIn,
      "amountOut": amountOut,
      "date": date,
      "type": type,
      "Category key": categoryKey,
      "fromWalletKey": fromWalletKey,
      "toWalletKey": toWalletKey,
    };
  }
}

class Attachments {
  final String name;
  final String contentType;
  final String content;
  final String type;

  const Attachments({
    this.name = "",
    this.contentType = "",
    this.content = "",
    this.type = "",
  });

  static Attachments fromJson(Map map) {
    return Attachments(
      name: map["name"] ?? "",
      content: map["content"] ?? "",
      contentType: map["contentType"] ?? "",
      type: map["type"] ?? "",
    );
  }

  Map toJson() {
    return {
      "name": name,
      "contentType": contentType,
      "content": content,
      "type": type,
    };
  }
}
