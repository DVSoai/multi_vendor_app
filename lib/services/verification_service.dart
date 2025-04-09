// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:multi_vendor_app/pages/auth/phone_verification/bloc/phone_verification_bloc.dart';
//
// class VerificationService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final  PhoneVerificationBloc _phoneVerificationBloc;
//   VerificationService(this._phoneVerificationBloc);
//
//   Future<void>verifyPhoneNumber(
//       String phoneNumber, {
//         required Null Function(String verificationId, int? resendToken) codeSent,
//   }
//       )async{
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // Automatically sign in the user if verification is successful
//           await _auth.signInWithCredential(credential);
//           _phoneVerificationBloc.add(PhoneVerificationCodeChanged(phoneNumber));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           // Handle verification failure
//           debugPrint('Verification failed: ${e.message}');
//         },
//         timeout: const Duration(seconds: 60),
//         codeSent: (String verificationId, int? resendToken) {
//           // Handle the code sent event
//           debugPrint('Code sent to $phoneNumber');
//           codeSent(verificationId, resendToken);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Handle the timeout event
//           debugPrint('Code auto-retrieval timeout: $verificationId');
//         },
//     );
//   }
//   Future<void>verifySmsCode(String verificationId, String smsCode)async{
//     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: smsCode,
//     );
//     // Sign the user in (or link) with the credential
//     await _auth.signInWithCredential(credential).then((value) {
//       debugPrint('User signed in: ${value.user?.uid}');
//       _phoneVerificationBloc.add(PhoneVerificationCodeChanged(value.user?.uid ?? ''));
//     }).catchError((error) {
//       debugPrint('Error signing in: $error');
//     });
//   }
// }