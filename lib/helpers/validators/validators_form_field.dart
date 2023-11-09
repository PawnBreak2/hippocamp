class ValidatorsFormField {
  static String? validateEmptyText(String? v) {
    return v == null || v.isEmpty ? "Questo campo è obbligatorio" : null;
  }

  static String? validateStrongPassword(String? v) {
    return v!.length < 8
        ? "Inserisci una password lunga almeno 8 caratteri"
        : null;
  }

  static String? validatePasswordEqual(String? v, String? v2) {
    return v != v2 || (v!.isEmpty || v2!.isEmpty)
        ? "Le due password non corrispondono"
        : null;
  }
}
