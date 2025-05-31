// lib/utils/validators.dart

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  return emailRegex.hasMatch(email);
}

bool isValidName(String name) {
  return name.trim().length >= 2;
}
