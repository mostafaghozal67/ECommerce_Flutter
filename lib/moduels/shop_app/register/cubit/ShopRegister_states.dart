import '../../../../models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterIntialState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel shopLoginModel;
  ShopRegisterSuccessState(this.shopLoginModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates{

}

class ShopRegisterErrorState extends ShopRegisterStates{}

class ShopChangePasswordvisibilityState extends ShopRegisterStates{}
