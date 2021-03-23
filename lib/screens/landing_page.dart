import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_kart/screens/login_page.dart';
import 'package:flutter_kart/screens/home_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScaffold(error: snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Streambuilder will check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return ErrorScaffold(error: streamSnapshot.error);
              }

              // Do the user logged-in check
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User _user = streamSnapshot.data;

                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              return Scaffold(
                body: Center(
                  child: Text("Checking the authentication...."),
                ),
              );
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text("Initializing Firebase...."),
          ),
        );
      },
    );
  }
}

class ErrorScaffold extends StatelessWidget {
  const ErrorScaffold({
    Key key,
    @required this.error,
  }) : super(key: key);

  final error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error: $error"),
      ),
    );
  }
}
