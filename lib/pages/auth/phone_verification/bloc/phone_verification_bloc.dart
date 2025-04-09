import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/local/global_storage.dart';
import '../../../../data/repositories/auth/phone_verification/phone_verification_repository.dart';

part 'phone_verification_event.dart';
part 'phone_verification_state.dart';

class PhoneVerificationBloc extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final PhoneVerificationRepositoryRemote _phoneVerificationRepository;
  final GlobalStorage _globalStorage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneVerificationBloc(
      this._phoneVerificationRepository,
      this._globalStorage,
      ) : super(const PhoneVerificationState()) {
    on<PhoneVerificationStarted>(_onPhoneVerificationStarted);
    on<PhoneCodeEntered>(_onPhoneCodeEntered);
  }

  Future<void> _onPhoneVerificationStarted(
      PhoneVerificationStarted event,
      Emitter<PhoneVerificationState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isFailed: false, errorMessage: ''));

    final completer = Completer<void>();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCredential = await _auth.signInWithCredential(credential);

            if (userCredential.user != null) {
              emit(state.copyWith(isLoading: false, isSuccess: true));
            } else {
              emit(state.copyWith(
                isLoading: false,
                isFailed: true,
                errorMessage: "Xác thực tự động không thành công.",
              ));
            }
          } catch (e) {
            emit(state.copyWith(
              isLoading: false,
              isFailed: true,
              errorMessage: e.toString(),
            ));
          } finally {
            if (!completer.isCompleted) completer.complete();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: e.message ?? "Đã xảy ra lỗi khi xác minh.",
          ));
          if (!completer.isCompleted) completer.complete();
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(
            isLoading: false,
            verificationId: verificationId,
          ));
          if (!completer.isCompleted) completer.complete();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print("⏱️ Mã OTP hết hạn: $verificationId");
          }
          if (!completer.isCompleted) completer.complete();
        },
      );

      // Đợi một trong các callback hoàn tất trước khi thoát khỏi handler
      await completer.future;

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isFailed: true,
        errorMessage: e.toString(),
      ));
      if (!completer.isCompleted) completer.complete();
    }
  }

  Future<void> _onPhoneCodeEntered(
      PhoneCodeEntered event,
      Emitter<PhoneVerificationState> emit,
      ) async {
    emit(state.copyWith(isLoading: true,));

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        emit(state.copyWith(isLoading: false, isFailed: true, errorMessage: "Đăng nhập thất bại."));
        return;
      }

      final idToken = await user.getIdToken();
      if (idToken == null) {
        emit(state.copyWith(isLoading: false, isFailed: true, errorMessage: "Không lấy được token."));
        return;
      }

      final userInfo = await _phoneVerificationRepository.verificationPhone(user.phoneNumber ?? '');
      await _globalStorage.saveUser(userInfo);
      await _globalStorage.saveToken(userInfo.userToken!);
      await _globalStorage.saveVerification(true);
      await _globalStorage.saveIsLoggedIn(true);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailed: true, errorMessage: e.toString()));
    }
  }
}
