import 'package:first_project/models/shop_app/ChangeFavourites_model.dart';
import 'package:first_project/models/shop_app/login_model.dart';

abstract class ShopLayoutStates{}

class ShopLayoutInitialState extends ShopLayoutStates{}

class ChangeBottomNavState extends ShopLayoutStates{}

class ShopLayoutLoadingHomeDataState extends ShopLayoutStates{}

class ShopLayoutSuccessHomeDataState extends ShopLayoutStates{}

class ShopLayoutErrorHomeDataState extends ShopLayoutStates{}

class ShopLayoutSuccessCategoriesState extends ShopLayoutStates{}

class ShopLayoutErrorCategoriesState extends ShopLayoutStates{}

class ShopLayoutSuccessChangeFavouritesState extends ShopLayoutStates{
  final ChangeFavouritesModel changeFavouritesModel;
  ShopLayoutSuccessChangeFavouritesState(this.changeFavouritesModel);
}

class ShopLayoutChangeFavouritesState extends ShopLayoutStates{} 

class ShopLayoutErrorChangeFavouritesState extends ShopLayoutStates{}

class ShopLayoutLoadingGetFavouritesState extends ShopLayoutStates{}

class ShopLayoutSuccessGetFavouritesState extends ShopLayoutStates{}

class ShopLayoutErrorGetFavouritesState extends ShopLayoutStates{}

class ShopLayoutSuccessUserDataState extends ShopLayoutStates{
  final ShopLoginModel shopLoginModel;
  ShopLayoutSuccessUserDataState(this.shopLoginModel);
}

class ShopLayoutErrorUserDataState extends ShopLayoutStates{}

class ShopLayoutLoadingUpdateUserState extends ShopLayoutStates{}

class ShopLayoutSuccessUpdateUserState extends ShopLayoutStates{
  final ShopLoginModel shopLoginModel;
  ShopLayoutSuccessUpdateUserState(this.shopLoginModel);
}

class ShopLayoutErrorUpdateUserState extends ShopLayoutStates{}



