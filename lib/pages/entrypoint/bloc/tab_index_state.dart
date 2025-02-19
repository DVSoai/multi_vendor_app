

part of 'tab_index_bloc.dart';
 class TabIndexState extends Equatable {
  final int index;
  const TabIndexState({
    required this.index,
});

  factory TabIndexState.initial() => const TabIndexState(index: 0);

  @override
  List<Object> get props => [index];
}

