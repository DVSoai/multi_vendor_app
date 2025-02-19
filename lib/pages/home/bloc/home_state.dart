part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String category;
  final String title;

  HomeState({
    required this.category,
    required this.title,
});

  factory HomeState.initial() {
    return HomeState(
      category: '',
      title: '',
    );
  }

  HomeState copyWith({
    String? category,
    String? title,
  }) {
    return HomeState(
      category: category ?? this.category,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [category, title];
}