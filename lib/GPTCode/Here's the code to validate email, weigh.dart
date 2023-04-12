// Here's the code to validate email, weight, height and phone number using regular expressions in Dart:
// ```
bool validateEmail(String email) {
  // Regular expression to validate email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool validateWeight(String weight) {
  // Regular expression to validate weight
  RegExp weightRegex = RegExp(r'^\d{1,3}(\.\d{1,2})?$');
  return weightRegex.hasMatch(weight);
}

bool validateHeight(String height) {
  // Regular expression to validate height
  RegExp heightRegex = RegExp(r'^\d{1,3}(\.\d{1,2})?$');
  return heightRegex.hasMatch(height);
}

bool validatePhoneNumber(String phoneNumber) {
  // Regular expression to validate US phone number
  RegExp phoneRegex = RegExp(r'^\+?1?\d{9,15}$');
  return phoneRegex.hasMatch(phoneNumber);
}
// ```
// You can use these functions to validate email, weight, height and phone number by passing the respective values as arguments. The function will return 'true' if the value matches the regular expression, otherwise it will return 'false'.