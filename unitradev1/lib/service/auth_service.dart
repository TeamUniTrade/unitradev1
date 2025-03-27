import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  static AuthService? _instance;
  AuthService._();
  factory AuthService() => _instance ??= AuthService._();

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Stream<auth.User> authStateChanges() async* {
    _auth.authStateChanges();
  }

  Future<auth.UserCredential> signUp(
      String name, String email, String password) async {
    auth.UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
    return credential;
  }

  Future<auth.UserCredential> login(String email, String password) async {
    auth.UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    return credential;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
