class ValidationUtils {
  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "Email cannot be empty.";
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim())) {
      return "Please enter a valid email address.";
    }
    return null; // No error
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return "Password cannot be empty.";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters long.";
    }
    return null; // No error
  }

  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return "Name cannot be empty.";
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name.trim())) {
      return "Name can only contain alphabets and spaces.";
    }
    return null; // No error
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.trim().isEmpty) {
      return "Confirm Password cannot be empty.";
    }
    if (password != confirmPassword) {
      return "Passwords do not match.";
    }
    return null; // No error
  }
}
