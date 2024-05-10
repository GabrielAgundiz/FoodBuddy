import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteState {
  List<String> foodIds;
  FavoriteState(this.foodIds);
}

abstract class FavoriteEvent {
  //se guardara una lista de los ids
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

class ChangeIcon extends FavoriteEvent {
  const ChangeIcon();
}

//escuchara por los eventos
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(super.initialState) {
    on<AddFoodToFavorite>((event, emit) {
      state.foodIds.add(event.foodId);
      //modifica la lista de bookId
      emit(FavoriteState(state
          .foodIds)); //avisa que el estado se modifico y hace que se reconstruya sus widgets
    });
    on<RemoveFoodFromFavorite>((event, emit) {
      state.foodIds.remove(event.foodId); //modifica la lista de bookId
      emit(FavoriteState(state
          .foodIds)); //avisa que el estado se modifico y hace que se reconstruya sus widgets
    });
  }
}
