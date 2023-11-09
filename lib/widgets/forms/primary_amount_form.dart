import 'package:flutter/services.dart';

class TextAmountFormat {
  static List<TextInputFormatter>? formatAmountValues() {
    return [
      TextInputFormatter.withFunction(
        (oldValue, newValue) {
          final text2 = newValue.text;

          // Return 2 decimals limit
          if (text2.contains(",")) {
            final splitText = text2.split(',');
            final decimals = text2.split(',').last.length;
            if (decimals > 2)
              return _upr(
                "${splitText.first},${splitText.last.substring(0, 2)}",
              );
          }

          final newTextWithoutDot = text2.replaceAll(".", "");
          final valueDouble =
              double.tryParse(newTextWithoutDot.replaceAll(".", ""));

          if (valueDouble == null) return _upr(text2);

          if (valueDouble >= 1000000000000) return _upr(oldValue.text);

          // Billions
          if (valueDouble >= 1000000000) {
            final v = "${valueDouble ~/ 1000000000}";
            final v2 = "${valueDouble ~/ 1000000}";
            final v3 = "${valueDouble ~/ 1000}";

            final newText =
                "$v.${v2.substring(v.length, v2.length)}.${v3.substring(v2.length, v3.length)}.${newTextWithoutDot.substring(v3.length)}";
            return _upr(newText);
            // Millions
          } else if (valueDouble >= 1000000) {
            final v = "${valueDouble ~/ 1000000}";
            final v2 = "${valueDouble ~/ 1000}";

            final newText =
                "$v.${v2.substring(v.length, v2.length)}.${newTextWithoutDot.substring(v2.length)}";
            return _upr(newText);
            // Thusands
          } else if (valueDouble >= 1000) {
            final v = "${valueDouble ~/ 1000}";

            final newText = "$v.${newTextWithoutDot.substring(v.length)}";
            return _upr(newText);
          }

          return _upr(newTextWithoutDot);
        },
      ),
    ];
  }

  static TextEditingValue _upr(String input) {
    TextEditingValue val1 = TextEditingValue(
      text: input,
      selection: TextSelection.fromPosition(
        TextPosition(offset: input.length),
      ),
    );
    return val1;
  }
}
