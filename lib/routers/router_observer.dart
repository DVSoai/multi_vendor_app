import 'package:bloc/bloc.dart';

class RouterObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('Change: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition: $transition');
  }
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Create: $bloc');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('Close: $bloc');
  }
}