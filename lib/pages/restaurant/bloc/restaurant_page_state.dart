part of 'restaurant_page_bloc.dart';
class RestaurantPageState extends Equatable{
  final int? count;
  const RestaurantPageState({this.count});

  RestaurantPageState copyWith({int? count}){
    return RestaurantPageState(count: count ?? this.count);
  }

  @override
  List<Object?> get props => [count];

}