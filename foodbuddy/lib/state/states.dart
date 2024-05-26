import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteState {
  List<String> foodIds;
  FavoriteState(this.foodIds);
}

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class AddFoodToFavorite extends FavoriteEvent {
  final String foodId;
  const AddFoodToFavorite(this.foodId);
}

class RemoveFoodFromFavorite extends FavoriteEvent {
  final String foodId;
  const RemoveFoodFromFavorite(this.foodId);
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState([])) {
    _loadFavorites();
    on<AddFoodToFavorite>((event, emit) {
      state.foodIds.add(event.foodId);
      _saveFavorites(state.foodIds);
      emit(FavoriteState(List.from(state.foodIds)));
    });
    on<RemoveFoodFromFavorite>((event, emit) {
      state.foodIds.remove(event.foodId);
      _saveFavorites(state.foodIds);
      emit(FavoriteState(List.from(state.foodIds)));
    });
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final foodIds = prefs.getStringList('favorite_food_ids') ?? [];
    emit(FavoriteState(foodIds));
  }

  Future<void> _saveFavorites(List<String> foodIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_food_ids', foodIds);
  }
}
