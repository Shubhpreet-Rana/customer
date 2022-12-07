import 'package:app/common/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../main.dart';
import 'methods/common.dart';

// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final BuildContext _context = locator<NavigationService>().navigatorKey.currentContext!;

Future<SocialAuthModel?> googleAuth() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      /* final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );*/
      if (googleSignInAuthentication.idToken != null) {
        return SocialAuthModel(
          email: googleSignInAccount.email,
          displayName: googleSignInAccount.displayName ?? "",
          photoUrl: googleSignInAccount.photoUrl ?? "",
          providerId: googleSignInAuthentication.idToken!,
        );
      } else {
        return null;
      }
    }
  } catch (e, s) {
    CommonMethods().showToast(context: _context, message: e.toString());
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
  return null;
}

Future<SocialAuthModel?> facebookAuth() async {
  try {
    final FacebookAuth facebookAuth = FacebookAuth.instance;
    final LoginResult result = await facebookAuth.login(
      permissions: ['public_profile', 'email'],
    );
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      Map<String, dynamic> userData = await facebookAuth.getUserData();
      return SocialAuthModel(
        providerId: accessToken.userId,
        email: userData['email'],
        displayName: userData['name'],
        photoUrl: userData['picture']['data']['url'],
      );
    } else {
      debugPrint(result.status.toString());
      debugPrint(result.message);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<SocialAuthModel?> appleAuth() async {
  try {
    if (await SignInWithApple.isAvailable()) {
      final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(scopes: AppleIDAuthorizationScopes.values);
      return SocialAuthModel(
        providerId: credential.userIdentifier ?? "",
        email: credential.email ?? "",
        displayName: credential.givenName ?? "",
      );
    }
  } on SignInWithAppleAuthorizationException catch (e) {
    debugPrint(e.message);
  }
  return null;
}

/*void signOut() async {
  try {
    await _firebaseAuth.signOut();
  } catch (e) {
    debugPrint(e.toString());
  }
}*/

class SocialAuthModel {
  final String providerId;
  final String email;
  final String displayName;
  final String photoUrl;

  SocialAuthModel({
    required this.providerId,
    required this.email,
    this.photoUrl = "",
    this.displayName = "",
  });
}
