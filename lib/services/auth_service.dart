import '../models/user_model.dart';
import '../utils/constants.dart';

class AuthService {
  // Mock authentication service
  // In production, this would use Firebase Auth or similar

  User? _currentUser;

  // Sign in with email and password
  Future<User> signIn(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock authentication
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: email.split('@')[0],
        email: email,
        phoneNumber: '+1234567890',
        role: AppConstants.rolePassenger,
        createdAt: DateTime.now(),
      );
      return _currentUser!;
    } else {
      throw Exception('Invalid email or password');
    }
  }

  // Sign up with email and password
  Future<User> signUp(String name, String email, String password, String phoneNumber, String role) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock user creation
    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      role: role,
      createdAt: DateTime.now(),
    );
    return _currentUser!;
  }

  // Sign out
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }

  // Update user
  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = user;
  }
}
