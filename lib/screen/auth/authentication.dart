import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kawaii_chat/core/config.dart';
import 'package:kawaii_chat/screen/chat/chat_screen.dart';
import 'package:kawaii_chat/screen/landing/landing_screen.dart';
import 'package:kawaii_chat/shared/widgets/right_sliding_dialog.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class FirebaseAuthRoutes{
  static const String signInOrSignUp = '/';
  static const String verifyEmail= '/verify-email';
  static const String forgetPassword= '/forgot-password';
  static const String phone= '/phone';
  static const String sms= '/sms';
  static const String emailLinkSignIn= '/email-link-sign-in';
  static const String profile= '/profile';
}

class Authentication {
  static String get initialRoute {
    final user = FirebaseAuth.instance.currentUser;
    return switch (user) {
      null => FirebaseAuthRoutes.signInOrSignUp,
      User(emailVerified: false, email: final String _) =>
        FirebaseAuthRoutes.verifyEmail,
      _ => FirebaseAuthRoutes.profile,
    };
  }

  static final mfaAction = AuthStateChangeAction<MFARequired>(
    (context, state) async {
      final nav = Navigator.of(context);
      await startMFAVerification(
        resolver: state.resolver,
        context: context,
      );
      nav.pushReplacementNamed(FirebaseAuthRoutes.profile);
    },
  );

  static void openAuthDialog({required BuildContext context, String? givenInitialRoute}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RightSlidingDialog(
          width: 364,
          child: Navigator(
            initialRoute: givenInitialRoute ?? initialRoute,
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              builder = switch (settings.name) {
                FirebaseAuthRoutes.signInOrSignUp => signInOrSignUpRoute,
                FirebaseAuthRoutes.phone => phoneRoute,
                FirebaseAuthRoutes.sms => smsRoute,
                FirebaseAuthRoutes.forgetPassword => forgetPasswordRoute,
                FirebaseAuthRoutes.emailLinkSignIn => emailLinkSignInRoute,
                FirebaseAuthRoutes.profile => profileRoute,
                FirebaseAuthRoutes.verifyEmail => verifyEmailRoute,
                _ => throw Exception("Invalid route: ${settings.name}")
              };
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
        );
      },
    ).then((_) {
      if (givenInitialRoute == null) {
        final user = FirebaseAuth.instance.currentUser;
        String currentScreenName = ModalRoute.of(context)?.settings.name ?? "";
        if (user != null) {
          if (currentScreenName != ChatScreen.path) {
            GoRouter.of(context).pushReplacementNamed(ChatScreen.path);
          }
        } else {
          if (currentScreenName != LandingScreen.path) {
            GoRouter.of(context).pushReplacementNamed(LandingScreen.path);
          }
        }
      }
    });
  }

  static WidgetBuilder get signInOrSignUpRoute => (context) {
        return SignInScreen(
          oauthButtonVariant: OAuthButtonVariant.icon_and_text,
          actions: [
            ForgotPasswordAction((context, email) {
              Navigator.pushNamed(
                context,
                '/forgot-password',
                arguments: {'email': email},
              );
            }),
            VerifyPhoneAction((context, _) {
              Navigator.pushNamed(context, '/phone');
            }),
            AuthStateChangeAction((context, state) {
              final user = switch (state) {
                SignedIn(user: final user) => user,
                CredentialLinked(user: final user) => user,
                UserCreated(credential: final cred) => cred.user,
                _ => null,
              };

              switch (user) {
                case User(emailVerified: true):
                  Navigator.pushReplacementNamed(context, '/profile');
                case User(emailVerified: false, email: final String _):
                  Navigator.pushNamed(context, '/verify-email');
              }
            }),
            mfaAction,
            EmailLinkSignInAction((context) {
              Navigator.pushReplacementNamed(context, '/email-link-sign-in');
            }),
          ],
          styles: const {
            EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
          },
          subtitleBuilder: (context, action) {
            final actionText = switch (action) {
              AuthAction.signIn => 'Please sign in to continue.',
              AuthAction.signUp => 'Please create an account to continue',
              _ => throw Exception('Invalid action: $action'),
            };

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('Welcome to Code Intel Chatbot! $actionText.'),
            );
          },
          footerBuilder: (context, action) {
            final actionText = switch (action) {
              AuthAction.signIn => 'signing in',
              AuthAction.signUp => 'registering',
              _ => throw Exception('Invalid action: $action'),
            };

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'By $actionText, you agree to our terms and conditions.',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        );
      };

  static WidgetBuilder get forgetPasswordRoute => (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return ForgotPasswordScreen(
          headerBuilder:
              headerIcon(Icons.lock, FirebaseAuthRoutes.forgetPassword),
          email: arguments?['email'],
          headerMaxExtent: 200,
        );
      };

  static WidgetBuilder get verifyEmailRoute => (context) {
        return EmailVerificationScreen(
          headerBuilder:
              headerIcon(Icons.verified, FirebaseAuthRoutes.verifyEmail),
          actionCodeSettings: actionCodeSettings,
          actions: [
            EmailVerifiedAction(() {
              Navigator.pushReplacementNamed(
                  context, FirebaseAuthRoutes.profile);
            }),
            AuthCancelledAction((context) {
              FirebaseUIAuth.signOut(context: context);
              Navigator.pushReplacementNamed(
                  context, FirebaseAuthRoutes.signInOrSignUp);
            }),
          ],
        );
      };

  static WidgetBuilder get phoneRoute => (context) {
        return PhoneInputScreen(
          actions: [
            SMSCodeRequestedAction((context, action, flowKey, phone) {
              Navigator.of(context).pushReplacementNamed(
                FirebaseAuthRoutes.sms,
                arguments: {
                  'action': action,
                  'flowKey': flowKey,
                  'phone': phone,
                },
              );
            }),
          ],
          headerBuilder: headerIcon(Icons.phone, FirebaseAuthRoutes.phone),
        );
      };

  static WidgetBuilder get smsRoute => (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return SMSCodeInputScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              Navigator.of(context)
                  .pushReplacementNamed(FirebaseAuthRoutes.profile);
            })
          ],
          flowKey: arguments?['flowKey'],
          action: arguments?['action'],
          headerBuilder: headerIcon(Icons.sms_outlined, FirebaseAuthRoutes.sms),
        );
      };

  static WidgetBuilder get emailLinkSignInRoute => (context) {
        return EmailLinkSignInScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              Navigator.pushReplacementNamed(
                  context, FirebaseAuthRoutes.signInOrSignUp);
            }),
          ],
          provider: emailLinkProviderConfig,
          headerMaxExtent: 200,
          headerBuilder:
              headerIcon(Icons.link, FirebaseAuthRoutes.emailLinkSignIn),
        );
      };

  static WidgetBuilder get profileRoute => (context) {
        // final platform = Theme.of(context).platform;
        return ProfileScreen(
          avatarPlaceholderColor: AppColors.secondary,
          actions: [
            SignedOutAction((context) {
              Navigator.pushReplacementNamed(
                  context, FirebaseAuthRoutes.signInOrSignUp);
            }),
            mfaAction,
          ],
          actionCodeSettings: actionCodeSettings,
          showMFATile: false,
          showUnlinkConfirmationDialog: true,
          showDeleteConfirmationDialog: true,
        );
      };

  static HeaderBuilder headerIcon(IconData icon, String route) {
    return (context, constraints, shrinkOffset) {
      return Padding(
        padding: const EdgeInsets.all(20).copyWith(
            top: route == FirebaseAuthRoutes.phone ||
                    route == FirebaseAuthRoutes.sms
                ? 70
                : 100),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: constraints.maxWidth / 4 * (1 - shrinkOffset),
        ),
      );
    };
  }
}
