part of 'search_bloc.dart';

class SearchState extends Equatable {
   bool isLoading;
   List<FoodsModel>? searchResults;
   String error;

   SearchState({
    required this.isLoading,
    required this.searchResults,
    required this.error,
  });

  factory SearchState.initial() {
    return  SearchState(
      isLoading: false,
      searchResults: null,
      error: '',
    );
  }

  SearchState copyWith({
    bool? isLoading,
    List<FoodsModel>? searchResults,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, searchResults ?? [], error];
}
