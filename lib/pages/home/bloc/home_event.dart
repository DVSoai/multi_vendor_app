part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateCategories extends HomeEvent {
  const UpdateCategories();
}

class UpdateTitle extends HomeEvent {
  const UpdateTitle();
}

class UpdateCategoryAndTitle extends HomeEvent {
  final String category;
  final String title;

  const UpdateCategoryAndTitle({
    required this.category,
    required this.title,
  });

  @override
  List<Object> get props => [category, title];
}
