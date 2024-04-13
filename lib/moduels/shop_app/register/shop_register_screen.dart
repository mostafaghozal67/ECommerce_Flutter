import 'package:first_project/moduels/shop_app/register/cubit/ShopRegister_cubit.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../../layouts/ShopApp/shop_layout.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/ShopRegister_states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var usernamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller= TextEditingController();
  var phonecontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context , state){
          if( state is ShopRegisterSuccessState){
            if(state.shopLoginModel.status){
              //print(state.loginModel.message);
              //print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data?.token).then((value) {
              token = state.shopLoginModel.data!.token; 
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopLayout()));
              });
              //ShowToast(mesg: state.loginModel.message, color: Colors.green);
            }
            else{
              //print("object");
              ShowToast(mesg: state.shopLoginModel.message, color: Colors.red);
            }
          }
        },
        builder: (BuildContext context, state) {
          var registerCubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.black),),
                        const SizedBox(height: 5.0,),
                        Text("Register Now to browse our hot offers",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),
                        const SizedBox(height: 30.0,),
                        defaultFormField(
                            controller: usernamecontroller,
                            type: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty || value == null) {
                                return "Please enter your user name";
                              }
                            }, label: "User Name", prefix: Icons.person_outline),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: emailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty || value == null) {
                                return "Please enter your email address";
                              }
                            }, label: "Email Address", prefix: Icons.email_outlined),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller: passwordcontroller,
                          type: TextInputType.visiblePassword,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Please enter your password";
                            }
                          }, label: "Password", prefix: Icons.lock_outline,
                          isPassword: registerCubit.isPasswordShown,
                          suffix: registerCubit.isPasswordShown ? Icons.visibility_outlined :Icons.visibility_off_outlined,
                          suffixPressed: (){
                            registerCubit.changePasswordVisibility();
                          }
                        ),// Default Form Field
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: phonecontroller,
                            type: TextInputType.text,
                            validate: (value){
                              if(value!.isEmpty || value == null) {
                                return "Please enter your phone number";
                              }
                            },
                            label: "Phone", prefix: Icons.phone_outlined,
                            onSubmit: (value){
                            if(formKey.currentState!.validate()) {
                              registerCubit.userRegister(
                                  name: usernamecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phone: phonecontroller.text);
                            }
                          }
                        ),
                        const SizedBox(height: 30.0,),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! ShopRegisterLoadingState,
                            widgetBuilder: (context) => defaultButton(
                                onpressed: (){
                                  if(formKey.currentState!.validate()){
                                    registerCubit.userRegister(
                                        name: usernamecontroller.text,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                        phone: phonecontroller.text);
                                  }
                                }, text: "Register", isUpperCase: true) ,
                            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
                        ),


                      ],),
                  ),
                ),
              ),
            ),

          );
        },

      ),
    );
  }
}
