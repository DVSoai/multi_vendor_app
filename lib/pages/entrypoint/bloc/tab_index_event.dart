

part of 'tab_index_bloc.dart';

abstract class TabIndexEvent extends Equatable {
  const TabIndexEvent();

  @override
  List<Object> get props => [];
}

class TabIndexChanged extends TabIndexEvent {
  final int index;

  const TabIndexChanged(this.index);

  @override
  List<Object> get props => [index];

}