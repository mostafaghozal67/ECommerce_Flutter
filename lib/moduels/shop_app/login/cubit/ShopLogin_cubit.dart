import 'package:first_project/models/shop_app/login_model.dart';
import 'package:first_project/moduels/shop_app/login/cubit/ShopLogin_states.dart';
import 'package:first_project/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  late ShopLoginModel loginModel;
  bool isPasswordShown = true;
  IconData suffix = Icons.visibility_outlined;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email , required String password}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,// Constants
        Data: {
          'email' : email,
          'password' : password

        }).then((value) {
          print(value.data);
          loginModel=ShopLoginModel.fromJson(value.data); 
          print(loginModel.status);
          //print(loginModel.data.email);
          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ?  Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordvisibilityState());
  }
}
