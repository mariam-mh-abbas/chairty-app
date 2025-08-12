// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId:
//         '1018709818584-4t8sr72lgld70bupv4kubatqj36e486s.apps.googleusercontent.com',
//     scopes: ['email',],
//   );

//   Future<GoogleSignInAccount?> signInWithGoogle() async {
//     try {
//       final account = await _googleSignIn.signIn();
//       return account;
//     } catch (e) {
//       print('Google Sign-In failed: $e');
//       return null;
//     }
//   }

//   Future<String?> getAccessToken(GoogleSignInAccount account) async {
//     final authentication = await account.authentication;
//     return authentication.accessToken;
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//   }
// }

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '1018709818584-4t8sr72lgld70bupv4kubatqj36e486s.apps.googleusercontent.com', // لازم يكون Web Client ID بالذات
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }

  Future<String?> getAccessToken(GoogleSignInAccount account) async {
    final authentication = await account.authentication;
    return authentication.accessToken;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
// services/auth/google_auth_service.dart

// import 'package:charity_project/services/auth_service.dart';
// import 'package:dio/dio.dart';


// class GoogleAuthService {
//   final Dio _dio;

//   GoogleAuthService(this._dio);

//   Future<> loginWithGoogle({
//     required String accessToken,
//     required String preferredLanguage,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '$baseUrl/api/user/google',
//         data: {
//           'access_token': accessToken,
//           'preferred_language': preferredLanguage,
//         },
//       );

//       return .fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Google login error: ${e.response!.data}');
//       } else {
//         print('Connection error: ${e.message}');
//       }
//       rethrow;
//     }
//   }
// }

