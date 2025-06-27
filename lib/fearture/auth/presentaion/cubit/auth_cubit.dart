import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/fearture/auth/presentaion/cubit/auth_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthAlitilaState());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  register(
      {required String emailAddress,
      required String password,
      required String displayName}) async {
    emit(AuthRegLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(displayName);

      FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "email": emailAddress,
        "name": displayName,
        "gender": "",
        "location": ""
      });
      emit(AuthRegSccsesState());
      AppLocalStorege.cachData(AppLocalStorege.isreg, user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthRegErorrState(erorr: "'The password provided is too weak.'"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthRegErorrState(
            erorr: "'The account already exists for that email.'"));
      }
    } catch (e) {
      emit(AuthRegErorrState(erorr: "Something Went Wrong"));
    }
  }

  login({
    required String emailAddress,
    required String password,
  }) async {
    emit(AuthLogLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      User user = credential.user!;
      await AppLocalStorege.cachData(AppLocalStorege.islog, user.uid);

      emit(AuthLogSccsesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthLogErorrState(erorr: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(AuthLogErorrState(erorr: "Wrong password provided."));
      } else {
        emit(AuthLogErorrState(erorr: "Authentication failed: ${e.message}"));
      }
    } catch (e) {
      emit(AuthLogErorrState(erorr: "Something went wrong: ${e.toString()}"));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthFailure("تم إلغاء تسجيل الدخول"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': user.email,
            'name': user.displayName ?? '',
            'photo': user.photoURL ?? '',
            'gender': '',
            'location': '',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        emit(AuthSuccess(user));
        AppLocalStorege.cachData(AppLocalStorege.islog, user.uid);
      } else {
        emit(AuthFailure("المستخدم غير موجود"));
      }
    } catch (e) {
      emit(AuthFailure("فشل تسجيل الدخول: ${e.toString()}"));
    }
  }

  getData(String uid) {
    FirebaseFirestore.instance.collection("users").doc(uid).get();
  }
}
