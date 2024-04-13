import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_States.dart';
import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_cubit.dart';
import 'package:first_project/models/shop_app/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context , state){},
      builder: (context, state){
        var cubit = ShopLayoutCubit.get(context);
        return ListView.separated(
            itemBuilder: (context , index) => BuildCatItem(cubit.categorirsModel!.categoriesDataModel.data[index]),
            separatorBuilder: (context , index) => const Divider(),
            itemCount: cubit.categorirsModel!.categoriesDataModel.data.length);
      },

    );
  }

  Widget BuildCatItem(DataModel dataModel) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(dataModel.image),
          height: 120,
          width: 120,
          fit: BoxFit.cover,),
        const SizedBox(width: 20.0,),
        Text(dataModel.name,style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),

      ],
    ),
  );
}
