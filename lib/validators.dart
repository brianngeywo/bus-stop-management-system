bool validatePassword(String password) {
  // Regex pattern for password validation
  const String passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*~]).{8,}$';

  return RegExp(passwordPattern).hasMatch(password);
}

bool validateName(String name) {
  // Regex pattern for name validation
  const String namePattern = r'^[a-zA-Z ]+$';

  return RegExp(namePattern).hasMatch(name);
}

bool validateEmail(String email) {
  // Regex pattern for email validation
  const String emailPattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';

  return RegExp(emailPattern).hasMatch(email);
}
