import 'package:flutter/foundation.dart';

/// Lightweight notifier holding authentication state for the router guard.
/// Can be hooked up to your state management solution (Riverpod, Bloc, etc.).
class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void logIn() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logOut() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

/// Global instance for router redirect listenable.
final authNotifier = AuthNotifier();
