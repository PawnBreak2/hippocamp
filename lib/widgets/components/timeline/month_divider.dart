import 'package:flutter/material.dart';
import 'package:hippocamp/helpers/extensions/int_extensions.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';

import '../../../models/responses/posts_response_model.dart';

class MonthDivider extends StatelessWidget {
  const MonthDivider({
    super.key,
    required this.currentDateP,
    required this.p,
  });

  final DateTime currentDateP;
  final MapEntry<String, List<Post>> p;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Text(
            "${currentDateP.month.monthFromInt} ${p.key.dateFromString.year}",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
