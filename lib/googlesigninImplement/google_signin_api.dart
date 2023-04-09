import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static const _clientIDWeb = 
  "108522717277-ff5v04dahatoif985g2b05dtg9lgmaee.apps.googleusercontent.com";
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
