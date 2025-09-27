class ValidationHelper {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    } else if (value.trim().length > 20) {
      return 'Title must be <= 20 characters';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    } else if (value.trim().length > 1000) {
      return 'Description must be <= 1000 characters';
    }
    return null;
  }
}
