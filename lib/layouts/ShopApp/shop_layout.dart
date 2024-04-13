import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_States.dart';
import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_cubit.dart';
import 'package:first_project/moduels/shop_app/search/Search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopLayoutCubit>(
      create: (BuildContext context) => ShopLayoutCubit()..getHomeData()..getCategories()..getFavourites()..getUserData(),
      child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder:  (context,state){
          var cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Salla"),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                }, icon: const Icon(Icons.search))
              ],
            
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap:(index){ cubit.changeBottom(index) ;},
            ),


          );
        },

      ),
    );
  }
}
/*
TextButton(onPressed: () {
        CacheHelper.removeData(key: 'token').then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopLoginScreen()));
        });
      }, child: Text("Logout"), )
 */