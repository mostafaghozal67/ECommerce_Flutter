import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_States.dart';
import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_cubit.dart';
import 'package:first_project/moduels/shop_app/login/shop_login_screen.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context, ShopLayoutStates state) { },
      builder: (BuildContext context, ShopLayoutStates state) {
        var UserData = ShopLayoutCubit.get(context).shopLoginModel;
        namecontroller.text = UserData!.data!.name;
        emailcontroller.text = UserData.data!.email;
        phonecontroller.text = UserData.data!.phone;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              if(state is ShopLayoutLoadingUpdateUserState)
                const LinearProgressIndicator(),
              defaultFormField(
                  controller: namecontroller,
                  type: TextInputType.text,
                  validate: (value){
                    if(value!.isEmpty || value == null) {
                      return "Name Mustn't be empty";
                    }
                  },
                  label: "Name",
                  prefix: Icons.person),
              const SizedBox(height: 10.0,),
              defaultFormField(
                  controller: emailcontroller,
                  type: TextInputType.text,
                  validate: (value){
                    if(value!.isEmpty || value == null)
                      return "Email Mustn't be empty";
                  },
                  label: "Email Address",
                  prefix: Icons.email),
              const SizedBox(height: 10.0,),
              defaultFormField(
                  controller: phonecontroller,
                  type: TextInputType.phone,
                  validate: (value){
                    if(value!.isEmpty || value == null) {
                      return "Phone Mustn't be empty";
                    }
                  },
                  label: "Phone",
                  prefix: Icons.phone),
              const SizedBox(height: 20.0,),
              defaultButton(
                  onpressed: (){
                   ShopLayoutCubit.get(context).updateUserData(
                       name: namecontroller.text,
                       email: emailcontroller.text,
                       phone: phonecontroller.text);
                  },
                  text: "Update"),
              const SizedBox(height: 20.0,),
              defaultButton(
                  onpressed: (){
                    CacheHelper.removeData(key: 'token').then((value) {
                      if(value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()));
                      }
                    });
                  },
                  text: "Logout")
            ],),
          ),
        );
      },

    );
  }
}




//return Center(child: Text("Settings Screen",style: Theme.of(context).textTheme.bodyMedium,));