import 'package:first_project/layouts/ShopApp/shop_layout.dart';
import 'package:first_project/moduels/shop_app/login/cubit/ShopLogin_cubit.dart';
import 'package:first_project/moduels/shop_app/login/cubit/ShopLogin_states.dart';
import 'package:first_project/moduels/shop_app/register/shop_register_screen.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>(); 
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if( state is ShopLoginSuccessState){
            if(state.loginModel.status){
              //print(state.loginModel.message);
              //print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                token = state.loginModel.data!.token; 
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopLayout()));
              });
              //ShowToast(mesg: state.loginModel.message, color: Colors.green);
            }
            else{
              //print("object");
              ShowToast(mesg: state.loginModel.message, color: Colors.red);
            }
          }
        },
        builder: (context , state) {
          var loginCubit = ShopLoginCubit.get(context);
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
                        Text("Login", style: Theme.of(context).textTheme.headlineLarge,),
                        const SizedBox(height: 5.0,),
                        Text("Login now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),
                        const SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Please enter your email address";
                            }
                          },
                          label: "Email Address",
                          prefix: Icons.email_outlined,
                        ),//DefaultFromField
                        const SizedBox(height: 15.0 ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty || value == null) {
                                return "Please enter your password";
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                loginCubit.userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            label: "Password",
                            prefix: Icons.lock_outline,
                            isPassword: loginCubit.isPasswordShown,
                            suffix: loginCubit.suffix,
                            suffixPressed: (){
                              loginCubit.changePasswordVisibility();
                            }
                        ),//DefaultFormField
                        const SizedBox(height: 30.0,),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! ShopLoginLoadingState,
                            widgetBuilder: (context) => defaultButton(
                                onpressed: (){
                                  if(formKey.currentState!.validate()){
                                    loginCubit.userLogin(email: emailController.text, password: passwordController.text);
                                  }
                                },
                                text: "Login", isUpperCase: true) ,
                            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ?"),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShopRegisterScreen()));
                            }, child: Text("Register Now".toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
