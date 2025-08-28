import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '1018709818584-4t8sr72lgld70bupv4kubatqj36e486s.apps.googleusercontent.com', // لازم يكون Web Client ID بالذات
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final account = await _googleSignIn.signIn();
      return account;
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }

  Future<String?> getAccessToken(GoogleSignInAccount account) async {
    final authentication = await account.authentication;
    return authentication.accessToken ?? authentication.idToken;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
