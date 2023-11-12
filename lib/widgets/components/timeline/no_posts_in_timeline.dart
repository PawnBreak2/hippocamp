import 'package:flutter/material.dart';

class NoPostsInTimelineSection extends StatelessWidget {
  const NoPostsInTimelineSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(241, 245, 223, 1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        "In questa pagina puoi inserire i tuoi eventi passati / futuri e annotare tutte le cose che ti succedono e che ritieni rilevanti. Clicca nel pulsante in basso a destra (+) per inserire un nuovo post.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
