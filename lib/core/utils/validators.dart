class Validators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre de usuario no puede estar vacío';
    }
    if (value.length < 3) {
      return 'El nombre de usuario debe tener al menos 3 caracteres';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }
    if (value.length < 6) {
      return 'La contraseña debe contener 6 caracteres como mínimo';
    }
    return null;
  }

  static String? validateIncidentTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'El título no puede estar vacío.';
    }
    return null;
  }

  static String? validateIncidentDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'La descripción no puede estar vacía';
    }
    return null;
  }

  static String? validateRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'El rol no puede estar vacío';
    }
    if (!['admin', 'root'].contains(value)) {
      return 'El rol debe ser admin o root';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El apellido no puede estar vacío';
    }
    return null;
  }

  static String? validateRegistrationNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'El apellido no puede estar vacío';
    }
    return null;
  }
}
