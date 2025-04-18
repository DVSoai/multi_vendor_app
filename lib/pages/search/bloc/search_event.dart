part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFoods extends SearchEvent {
  final String query;

  const SearchFoods({required this.query});

  @override
  List<Object> get props => [query];
}
class ClearSearchResults extends SearchEvent {
  const ClearSearchResults();
}