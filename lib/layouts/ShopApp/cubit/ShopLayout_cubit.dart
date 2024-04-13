import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_States.dart';
import 'package:first_project/models/shop_app/ChangeFavourites_model.dart';
import 'package:first_project/models/shop_app/categories_model.dart';
import 'package:first_project/models/shop_app/favourites_model.dart';
import 'package:first_project/models/shop_app/home_model.dart';
import 'package:first_project/models/shop_app/login_model.dart';
import 'package:first_project/moduels/shop_app/categories/Categories_Screen.dart';
import 'package:first_project/moduels/shop_app/favourites/Favourites_Screen.dart';
import 'package:first_project/moduels/shop_app/products/Products_Screen.dart';
import 'package:first_project/moduels/shop_app/settings/Settings_Screen.dart';
import 'package:first_project/shared/components/constants.dart';
import 'package:first_project/shared/network/endpoints.dart';
import 'package:first_project/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ShopLayoutCubit extends Cubit<ShopLayoutStates> {

  ShopLayoutCubit() : super(ShopLayoutInitialState());
  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    CategoriessScreen(),
    FavouritesScreen(),
    SettingsScreen(),

  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourites"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  HomeModel? homemodel;
  CategorirsModel? categorirsModel;
  ChangeFavouritesModel? changeFavouritesModel;
  FavoritesModel? favoritesModel;
  ShopLoginModel? shopLoginModel;

  //Map<int , bool> favourites = {};

  void changeBottom(int index){
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  void getHomeData(){
    emit(ShopLayoutLoadingHomeDataState());
    
    DioHelper.getData(url: HOME, token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      //print(homemodel!.status);
      
      homemodel!.data.products.forEach((element) {
        favourites.addAll({
          element.id : element.inFavourites
        });
       // print("Iam get homeData");
      });
      //print(favourites.toString());
      emit(ShopLayoutSuccessHomeDataState());
    }).catchError((error){
      //print(error.toString());
      emit(ShopLayoutErrorHomeDataState());
    });

  }

  void getCategories(){
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      //print("object");
      categorirsModel = CategorirsModel.fromjson(value.data);
      //print(categorirsModel?.status);
      //print("Iam getCategories");
      emit(ShopLayoutSuccessCategoriesState());
    }).catchError((error){
      //print(error.toString());
      emit(ShopLayoutErrorCategoriesState());
    });

  }

  void changeFavourites(int productId){
    favourites[productId] = !favourites[productId]!;
    emit(ShopLayoutChangeFavouritesState());
    DioHelper.postData(
        url: FAVOURITES,
        Data: {
          'product_id' : productId,
        },
        token: token).then((value)  {
          changeFavouritesModel = ChangeFavouritesModel.fromjson(value.data);
          //print(token);
          //print(value.data);
          //print(favourites.toString());
          if(!changeFavouritesModel!.status) {
            favourites[productId] = !favourites[productId]!;
          } else {
            getFavourites();
          }
          emit(ShopLayoutSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error){
      favourites[productId] = !favourites[productId]!;
      emit(ShopLayoutErrorChangeFavouritesState());
    });
  }

  void getFavourites(){
    emit(ShopLayoutLoadingGetFavouritesState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      //print("Iam get fav");
      favoritesModel = FavoritesModel.fromjson(value.data);
      //print(value.data);
      //print("Iam get favourites");
      emit(ShopLayoutSuccessGetFavouritesState());
    }).catchError((error){
      //print(error.toString());
      emit(ShopLayoutErrorGetFavouritesState());
    });

  }

  void getUserData(){
    //print("object");
    //print(token);
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLayoutSuccessUserDataState(shopLoginModel!));
    }
    ).catchError((error){
      //print(error.toString());
      emit(ShopLayoutErrorUserDataState());
    });
  }

  void updateUserData({required String name , required String email,required String phone}){
    emit(ShopLayoutLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE,
        token: token,
        Data: {
          'name' : name,
          'email': email,
          'phone': phone
        }).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLayoutSuccessUpdateUserState(shopLoginModel!));
    }
    ).catchError((error){
      //print(error.toString());
      emit(ShopLayoutErrorUpdateUserState());
    });
  }





}
