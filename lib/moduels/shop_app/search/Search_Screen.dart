import 'package:first_project/moduels/shop_app/search/cubit/ShopSearch_cubit.dart';
import 'package:first_project/moduels/shop_app/search/cubit/ShopSearch_states.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/constants.dart';


class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>() ;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopSearchCubit>(
      create: (BuildContext context) => ShopSearchCubit()..getFavourites(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value!.isEmpty || value == null)
                          return "Search text can't be empty";
                      },
                      onSubmit: (value){
                        ShopSearchCubit.get(context).search(text: searchController.text);
                      },
                      label: "Search",
                      prefix: Icons.search),
                  const SizedBox(height: 10.0,),
                  if(state is ShopSearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 10.0,),
                  if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated
                        (itemBuilder: (context , index) => buildSearchItem(ShopSearchCubit.get(context).searchModel!.data!.data[index],context),
                          separatorBuilder: (context , index) => Padding(
                            padding: const EdgeInsetsDirectional.only(start: 20.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          itemCount: ShopSearchCubit.get(context).searchModel!.data!.data.length),
                    )

                ],),
              ),
            )
          );
        },

      ),
    );
  }

  Widget buildSearchItem(SearchProductData searchProductData, context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(searchProductData.image),
                    width: 120,
                    height: 120.0,
                  ),

                ],
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchProductData.name ,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: (const TextStyle(height: 1.3, fontWeight: FontWeight.bold)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${searchProductData.price?.round()}',
                        style: (const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 5.0),

                      const Spacer(),

                      CircleAvatar(
                        radius: 17.0,
                        backgroundColor: favourites[searchProductData.id]! ? Colors.blue : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
