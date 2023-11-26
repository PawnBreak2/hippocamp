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
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text:
                'Nella Timeline puoi inserire dei post per memorizzare i fatti e gli eventi che ritieni rilevanti. Fatti ed eventi che si sono svolti nel',
          ),
          TextSpan(
            text: 'passato',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ', che si stanno svolgendo nel ',
          ),
          TextSpan(
            text: 'presente',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'o che vuoi pianificare per il ',
          ),
          TextSpan(
            text: 'futuro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '. \n',
          ),
          TextSpan(
            text:
                'Clicca nel pulsante in basso a destra (+) per aggiungere un nuovo post.',
          ),
        ]),
      ),
    );
  }
}
