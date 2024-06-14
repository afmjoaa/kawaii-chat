import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

String get googleClientId =>
    '102511634049-daorkfmvqfi4evhfkeauuk4qn7npkfna.apps.googleusercontent.com';

firebase_auth.ActionCodeSettings get actionCodeSettings => firebase_auth.ActionCodeSettings(
    url: 'https://kawaii-chat-88920.web.app/',
    handleCodeInApp: true
);

EmailLinkAuthProvider get emailLinkProviderConfig => EmailLinkAuthProvider(
    actionCodeSettings: actionCodeSettings,
);

List<AuthProvider> get authProviders =>
    [
        EmailAuthProvider(),
        emailLinkProviderConfig,
        PhoneAuthProvider(),
        GoogleProvider(clientId: googleClientId),
    ];
