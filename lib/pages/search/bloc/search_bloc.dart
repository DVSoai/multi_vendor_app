import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';

import '../../../data/repositories/search/search_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositoryRemote _searchRepositoryRemote;

  SearchBloc(this._searchRepositoryRemote) : super(SearchState.initial()) {
    on<SearchFoods>(_onSearchFoods);
    on<ClearSearchResults>(_onClearSearchResults);
  }

  Future<void> _onSearchFoods(
      SearchFoods event, Emitter<SearchState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(searchResults: []));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final searchResults =
          await _searchRepositoryRemote.searchFoods(query: event.query);
      emit(state.copyWith(
        isLoading: false,
        searchResults: searchResults.isNotEmpty ? searchResults : [],
        error: searchResults.isEmpty ? 'No results found' : '',
      ));
    } catch (e) {
      print('e: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onClearSearchResults(
      ClearSearchResults event, Emitter<SearchState> emit) async {
    emit(SearchState.initial());
  }
}
