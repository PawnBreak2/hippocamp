import 'package:flutter/material.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';

class PostResponse {
  final List<Post> posts;
  final bool end;

  const PostResponse({required this.posts, required this.end});
}

class Post {
  final String title;
  final String key;
  final String description;
  final int attachmentCount;
  final PostCategory category;
  final MultiPartyTransaction? multiPartyTransaction;
  final String latitude;
  final String longitude;
  final String address;
  final bool important;
  final bool canceled;
  final bool uncertain;
  final bool sensitiveInfo;
  final String type;
  final String rating;
  final String from;
  final String to;
  final String interval;
  final String date;
  final String holiday;
  final String at;
  final String within;
  final String notificationsUnit;
  final bool morning;
  final bool afternoon;
  final bool evening;
  final bool wholeDay;
  final bool notificationsActive;
  final List stories;
  final List<Partner> businessPartners;
  final List<SinglePartyTransactionPost> singlePartyTransactions;
  final List<Attachment> attachments;

  const Post({
    required this.title,
    required this.key,
    required this.description,
    required this.attachmentCount,
    required this.category,
    required this.multiPartyTransaction,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.important,
    required this.canceled,
    required this.uncertain,
    required this.sensitiveInfo,
    required this.type,
    required this.rating,
    required this.from,
    required this.to,
    required this.interval,
    required this.date,
    required this.holiday,
    required this.at,
    required this.within,
    required this.notificationsUnit,
    required this.morning,
    required this.afternoon,
    required this.evening,
    required this.wholeDay,
    required this.notificationsActive,
    required this.stories,
    required this.businessPartners,
    required this.singlePartyTransactions,
    required this.attachments,
  });

  Post copyWith({
    String? title,
    String? key,
    String? description,
    int? attachmentCount,
    PostCategory? category,
    MultiPartyTransaction? multiPartyTransaction,
    String? latitude,
    String? longitude,
    String? address,
    bool? important,
    bool? canceled,
    bool? uncertain,
    bool? sensitiveInfo,
    String? type,
    String? rating,
    String? from,
    String? to,
    String? interval,
    String? date,
    String? holiday,
    String? at,
    String? within,
    String? notificationsUnit,
    bool? morning,
    bool? afternoon,
    bool? evening,
    bool? wholeDay,
    bool? notificationsActive,
    List<dynamic>? stories,
    List<Partner>? businessPartners,
    List<SinglePartyTransactionPost>? singlePartyTransactions,
    List<Attachment>? attachments,
  }) {
    return Post(
      title: title ?? this.title,
      key: key ?? this.key,
      description: description ?? this.description,
      attachmentCount: attachmentCount ?? this.attachmentCount,
      category: category ?? this.category,
      multiPartyTransaction:
          multiPartyTransaction ?? this.multiPartyTransaction,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      important: important ?? this.important,
      canceled: canceled ?? this.canceled,
      uncertain: uncertain ?? this.uncertain,
      sensitiveInfo: sensitiveInfo ?? this.sensitiveInfo,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      from: from ?? this.from,
      to: to ?? this.to,
      interval: interval ?? this.interval,
      date: date ?? this.date,
      holiday: holiday ?? this.holiday,
      at: at ?? this.at,
      within: within ?? this.within,
      notificationsUnit: notificationsUnit ?? this.notificationsUnit,
      morning: morning ?? this.morning,
      afternoon: afternoon ?? this.afternoon,
      evening: evening ?? this.evening,
      wholeDay: wholeDay ?? this.wholeDay,
      notificationsActive: notificationsActive ?? this.notificationsActive,
      stories: stories ?? this.stories,
      businessPartners: businessPartners ?? this.businessPartners,
      singlePartyTransactions:
          singlePartyTransactions ?? this.singlePartyTransactions,
      attachments: attachments ?? this.attachments,
    );
  }

  static Post fromMap(Map json) {
    return Post(
      title: json["title"] ?? "",
      key: json["key"] ?? "",
      description: json["description"] ?? "",
      attachmentCount: json["attachmentCount"] ?? 0,
      category: PostCategory.fromMap(json["category"] ?? {}),
      businessPartners: json["businessPartners"] != null
          ? (json["businessPartners"] as List)
              .map((e) => Partner.fromMap(e))
              .toList()
          : [],
      multiPartyTransaction:
          MultiPartyTransaction.fromMap(json["multiPartyTransaction"]),
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      address: json["address"] ?? "",
      important: json["important"] ?? false,
      canceled: json["canceled"] ?? false,
      uncertain: json["uncertain"] ?? false,
      sensitiveInfo: json["sensitiveInfo"] ?? false,
      type: json["type"] ?? "",
      rating: json["rating"] ?? "",
      from: json["from"] ?? "",
      to: json["to"] ?? "",
      interval: json["interval"] ?? "",
      date: json["date"] ?? "",
      holiday: json["holiday"] ?? "",
      at: json["at"] ?? "",
      within: json["within"] ?? "",
      notificationsUnit: json["notificationsUnit"] ?? "",
      morning: json["morning"] ?? false,
      afternoon: json["afternoon"] ?? false,
      evening: json["evening"] ?? false,
      wholeDay: json["wholeDay"] ?? false,
      notificationsActive: json["notificationsActive"] ?? false,
      stories: json["stories"] ?? [],
      singlePartyTransactions: json["singlePartyTransactions"] != null
          ? (json["singlePartyTransactions"] as List)
              .map((e) => SinglePartyTransactionPost.fromMap(e))
              .toList()
          : [],
      attachments: json["attachments"] != null
          ? (json["attachments"] as List)
              .map((e) => Attachment.fromJson(e))
              .toList()
          : [],
    );
  }

  DateTime get dateTimeFromString => date.dateFromString;

  String get timePost => from.isEmpty || from.length < 3
      ? "00:00"
      : from.substring(0, from.length - 3);

  double get totalAmountSpentInDouble {
    double amount = 0;
    if (multiPartyTransaction != null) return multiPartyTransaction!.amountOut;

    for (var i in singlePartyTransactions) {
      if (i.isInflowOrOutflow)
        amount += i.amount;
      else
        amount -= i.amount;
    }

    return amount;
  }

  Color get colorAmountSpent {
    if (totalAmountSpentInDouble == 0) return Color.fromRGBO(0, 84, 147, 1);

    return totalAmountSpentInDouble > 0 ? Colors.green : Colors.red;
  }

  String get totalAmountSpent {
    if (singlePartyTransactions.isEmpty && multiPartyTransaction == null)
      return "";

    final currency = singlePartyTransactions.isNotEmpty
        ? singlePartyTransactions.first.currencySymbol
        : multiPartyTransaction!.amountInCurrencySymbol;

    return totalAmountSpentInDouble.abs().toStringAsFixed(2).thousandsFormat +
        currency;
  }
}

class MultiPartyTransaction {
  final double amountIn;
  final double amountOut;
  final String amountInCurrencyCode;
  final String amountInCurrencySymbol;
  final String amountOutCurrencyCode;
  final String amountOutCurrencySymbol;
  final String date;
  final String type;
  final String fromWallet;
  final String fromWalletName;
  final String fromWalletTypeIconUrl;
  final String toWallet;
  final String toWalletName;
  final String toWalletTypeIconUrl;

  const MultiPartyTransaction({
    required this.amountIn,
    required this.amountOut,
    required this.amountInCurrencyCode,
    required this.amountInCurrencySymbol,
    required this.amountOutCurrencyCode,
    required this.amountOutCurrencySymbol,
    required this.date,
    required this.type,
    required this.fromWallet,
    required this.fromWalletName,
    required this.fromWalletTypeIconUrl,
    required this.toWallet,
    required this.toWalletName,
    required this.toWalletTypeIconUrl,
  });

  static MultiPartyTransaction? fromMap(Map? json) {
    if (json == null) return null;

    return MultiPartyTransaction(
      amountIn: json["amountIn"] ?? 0,
      amountOut: json["amountOut"] ?? 0,
      amountInCurrencyCode: json["amountInCurrencyCode"] ?? "",
      amountInCurrencySymbol: json["amountInCurrencySymbol"] ?? "",
      amountOutCurrencyCode: json["amountOutCurrencyCode"] ?? "",
      amountOutCurrencySymbol: json["amountOutCurrencySymbol"] ?? "",
      date: json["date"] ?? "",
      type: json["type"] ?? "",
      fromWallet: json["fromWallet"] ?? "",
      fromWalletName: json["fromWalletName"] ?? "",
      fromWalletTypeIconUrl: json["fromWalletTypeIconUrl"] ?? "",
      toWallet: json["toWallet"] ?? "",
      toWalletName: json["toWalletName"] ?? "",
      toWalletTypeIconUrl: json["toWalletTypeIconUrl"] ?? "",
    );
  }
}

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

class SinglePartyTransactionPost {
  final String key;
  final double amount;
  final String currencyCode;
  final String currencySymbol;
  final String date;
  final String type;
  final String wallet;
  final String walletName;
  final String walletTypeIconUrl;
  final bool ordinary;
  final bool variable;
  final bool planned;
  final bool taxRelevant;

  const SinglePartyTransactionPost({
    required this.amount,
    required this.currencyCode,
    required this.currencySymbol,
    required this.date,
    required this.key,
    required this.type,
    required this.wallet,
    required this.walletName,
    required this.walletTypeIconUrl,
    required this.ordinary,
    required this.variable,
    required this.planned,
    required this.taxRelevant,
  });

  static SinglePartyTransactionPost fromMap(Map map) {
    return SinglePartyTransactionPost(
      amount: map["amount"] ?? 0,
      key: map["key"] ?? "",
      currencyCode: map["currencyCode"] ?? "",
      currencySymbol: map["currencySymbol"] ?? "",
      date: map["date"] ?? "",
      type: map["type"] ?? "",
      wallet: map["wallet"] ?? "",
      walletName: map["walletName"] ?? "",
      walletTypeIconUrl: map["walletTypeIconUrl"] ?? "",
      ordinary: map["ordinary"] ?? false,
      variable: map["variable"] ?? false,
      planned: map["planned"] ?? false,
      taxRelevant: map["taxRelevant"] ?? false,
    );
  }

  bool get isInflowOrOutflow {
    return type == "INFLOW";
  }
}

class Attachment {
  final String name;
  final String key;
  final String type;
  final String iconUrl;
  final String contentType;
  final String location;
  final int sizeInKb;

  const Attachment({
    this.name = "",
    this.key = "",
    this.type = "",
    this.iconUrl = "",
    this.contentType = "",
    this.location = "",
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
      sizeInKb: map["sizeInKb"] ?? 0,
    );
  }
}
