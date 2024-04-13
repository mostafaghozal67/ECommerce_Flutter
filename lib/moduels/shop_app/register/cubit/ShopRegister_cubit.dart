import 'package:first_project/models/shop_app/login_model.dart';
import 'package:first_project/moduels/shop_app/register/cubit/ShopRegister_states.dart';
import 'package:first_project/shared/network/endpoints.dart';
import 'package:first_project/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit () : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = true;

  late ShopLoginModel shopLoginModel;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    emit(ShopChangePasswordvisibilityState());
  }
  
  void userRegister({required String name,required String email,required String password,required String phone}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        Data: {
          'name' :name ,
          'email' : email,
          'password' : password,
          'phone' : phone}).then((value) {
            shopLoginModel= ShopLoginModel.fromJson(value.data);
            emit(ShopRegisterSuccessState(shopLoginModel));

    }).catchError((error){
      //print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }




}