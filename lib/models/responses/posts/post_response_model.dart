import 'package:flutter/material.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/posts/attachment.dart';
import 'package:hippocapp/models/responses/posts/multi_party_transaction.dart';
import 'package:hippocapp/models/responses/posts/partner.dart';
import 'package:hippocapp/models/responses/posts/single_party_transaction.dart';

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
  final double latitude;
  final double longitude;
  final String address;
  final bool important;
  final bool uncertain;
  final bool sensitiveInfo;
  final String type;
  final String from;
  final String to;
  final String date;
  final String holiday;
  final bool allDay;
  final String visualization;
  final List<String> businessPartners;
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
    required this.uncertain,
    required this.sensitiveInfo,
    required this.type,
    required this.from,
    required this.to,
    required this.date,
    required this.holiday,
    required this.allDay,
    required this.visualization,
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
    double? latitude,
    double? longitude,
    String? address,
    bool? important,
    bool? uncertain,
    bool? sensitiveInfo,
    String? type,
    String? from,
    String? to,
    String? date,
    String? holiday,
    String? visualization,
    bool? allDay,
    List<String>? businessPartners,
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
      uncertain: uncertain ?? this.uncertain,
      sensitiveInfo: sensitiveInfo ?? this.sensitiveInfo,
      type: type ?? this.type,
      visualization: visualization ?? this.visualization,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      holiday: holiday ?? this.holiday,
      allDay: allDay ?? this.allDay,
      businessPartners: businessPartners ?? this.businessPartners,
      singlePartyTransactions:
          singlePartyTransactions ?? this.singlePartyTransactions,
      attachments: attachments ?? this.attachments,
    );
  }

  static Post fromJson(Map json) {
    return Post(
      title: json["title"] ?? "",
      key: json["key"] ?? "",
      description: json["description"] ?? "",
      attachmentCount: json["attachmentCount"] ?? 0,
      category: PostCategory.fromMap(json["category"] ?? {}),
      businessPartners: json["businessPartners"] ?? [],
      multiPartyTransaction:
          MultiPartyTransaction.fromMap(json["multiPartyTransaction"]),
      latitude: json["latitude"] ?? 0,
      longitude: json["longitude"] ?? 0,
      address: json["address"] ?? "",
      visualization: json["visualization"] ?? "",
      important: json["important"] ?? false,
      uncertain: json["uncertain"] ?? false,
      sensitiveInfo: json["sensitiveInfo"] ?? false,
      type: json["type"] ?? "",
      from: json["from"] ?? "",
      to: json["to"] ?? "",
      date: json["date"] ?? "",
      holiday: json["holiday"] ?? "",
      allDay: json["allDay"] ?? false,
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
