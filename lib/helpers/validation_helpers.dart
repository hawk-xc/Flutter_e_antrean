class ValidatorHelpers {
  static String? required(value) {
    if (value == null || value.isEmpty) {
      return 'Harus diisi tidak boleh kosong';
    }
    return null;
  }

  static String? email(value) {
    if (value == null || value.isEmpty) {
      return 'Harus diisi tidak boleh kosong';
    } else if (!value.contains('@') && value.contains('.')) {
      return 'Email tidak valid';
    }
    return null;
  }

  static String? password(value) {
    if (value == null || value.isEmpty) {
      return 'Harus diisi tidak boleh kosong';
    } else if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    return null;
  }
}
