import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/core/network/local/global_storage.dart';
import 'package:multi_vendor_app/data/repositories/auth/email_verification/email_verification_repository.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';


class EmailVerificationBloc extends Bloc<EmailVerificationEvent, EmailVerificationState> {

  final EmailVerificationRepositoryRemote _emailVerificationRepositoryRemote;
  final GlobalStorage _globalStorage;
  EmailVerificationBloc(this._emailVerificationRepositoryRemote,this._globalStorage) : super(const EmailVerificationState()) {
    on<EmailVerificationCodeChanged>(_onEmailVerificationCodeChanged);
  }

  Future<void> _onEmailVerificationCodeChanged(
      EmailVerificationCodeChanged event, Emitter<EmailVerificationState> emit)  async{
    try{
      emit(state.copyWith(
        isLoading: true,
      ));
      final user = await _emailVerificationRepositoryRemote.verificationEmail(event.verificationCode);
      await _globalStorage.saveUser(user);
      await _globalStorage.saveIsLoggedIn(true);


      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));



    }catch(e){
      emit(state.copyWith(isLoading: false, errorMessage: e.toString(),isFailed: true));
      rethrow;
    }
  }
}