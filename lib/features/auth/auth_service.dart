class AuthService {
  // Simulate a simple in-memory database
  // Format: username -> { 'fullName': fullName, 'password': password, etc... }
  static final Map<String, Map<String, dynamic>> _users = {};

  static Map<String, dynamic>? currentUser;

  static bool isRegistered(String username) {
    return _users.containsKey(username);
  }

  static bool register({
    required String username,
    required String fullName,
    required String password,
    String? subject,
    String? school,
    String? email,
  }) {
    if (isRegistered(username)) {
      return false; // Username already taken
    }
    _users[username] = {
      'username': username,
      'fullName': fullName,
      'password': password,
      'subject': subject,
      'school': school,
      'email': email,
    };
    currentUser = _users[username];
    return true;
  }

  static String? login(String username, String password) {
    if (_users.containsKey(username) && _users[username]!['password'] == password) {
      currentUser = _users[username];
      return _users[username]!['fullName'] as String?;
    }
    return null; // Invalid credentials
  }

  static void logout() {
    currentUser = null;
  }
}
