import 'package:first_project/models/shop_app/search_model.dart';
import 'package:first_project/moduels/shop_app/search/cubit/ShopSearch_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/shop_app/favourites_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/endpoints.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit () : super(ShopSearchIntialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  FavoritesModel? favoritesModel;


  void search({required String text}){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        Data: {
          'text' : text
        }).then((value) {
      searchModel = SearchModel.fromjson(value.data);
      emit(ShopSearchSuccessState());

    }).catchError((error){
      //print(error.toString());
      emit(ShopSearchErrorState());
    });

  }

  void getFavourites(){

    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      //print("Iam get fav");
      favoritesModel = FavoritesModel.fromjson(value.data);
      //print(value.data);
      //print("Iam get favourites");
    }).catchError((error){
      //print(error.toString());

    });

  }
}