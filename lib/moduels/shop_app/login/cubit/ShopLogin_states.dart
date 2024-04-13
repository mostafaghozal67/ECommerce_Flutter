import '../../../../models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
   final ShopLoginModel loginModel;
   ShopLoginSuccessState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
  late final String error ;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordvisibilityState extends ShopLoginStates{}