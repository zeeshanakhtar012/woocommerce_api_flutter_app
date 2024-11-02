class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Address is required';
    }
    if (address.length < 5) {
      return 'Address must be at least 5 characters long';
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'Name must contain only letters and spaces';
    }
    return null;
  }

  static String? validateCountry(String? name) {
    if (name == null || name.isEmpty) {
      return 'Country is required';
    }
    if (name.length < 2) {
      return 'Country must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'Country must contain only letters and spaces';
    }
    return null;
  }

  static String? validateLocality(String? name) {
    if (name == null || name.isEmpty) {
      return 'Locality is required';
    }
    if (name.length < 2) {
      return 'Locality must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'Locality must contain only letters and spaces';
    }
    return null;
  }
  static String? validateCity(String? name) {
    if (name == null || name.isEmpty) {
      return 'City is required';
    }
    if (name.length < 2) {
      return 'City must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'Locality must contain only letters and spaces';
    }
    return null;
  }

  static String? validateRegion(String? name) {
    if (name == null || name.isEmpty) {
      return 'Region is required';
    }
    if (name.length < 2) {
      return 'Region must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'Region must contain only letters and spaces';
    }
    return null;
  }

  static String? validateUserName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Username is required';
    }
    if (name.length < 2) {
      return 'Username must be at least 2 characters long';
    }
    // Checks for alphabetic characters and spaces only
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(name)) {
      return 'username must contain only letters and spaces';
    }
    return null;
  }
static String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  if (password.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // Ensure password has at least one letter and one number
  final RegExp letterRegExp = RegExp(r'[A-Za-z]');
  final RegExp numberRegExp = RegExp(r'\d');

  if (!letterRegExp.hasMatch(password)) {
    return 'Password must contain at least one letter';
  }
  if (!numberRegExp.hasMatch(password)) {
    return 'Password must contain at least one number';
  }

  return null;
}


  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }

    final RegExp phoneRegExp = RegExp(r'^\d{9,15}$');
    if (!phoneRegExp.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}


// String? emailError = FormValidator.validateEmail(emailInput);
// String? addressError = FormValidator.validateAddress(addressInput);
// String? nameError = FormValidator.validateName(nameInput);
// String? passwordError = FormValidator.validatePassword(passwordInput);
// String? confirmPasswordError = FormValidator.validateConfirmPassword(passwordInput, confirmPasswordInput);
// String? phoneError = FormValidator.validatePhone(phoneInput);
