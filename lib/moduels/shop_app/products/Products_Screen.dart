import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_States.dart';
import 'package:first_project/layouts/ShopApp/cubit/ShopLayout_cubit.dart';
import 'package:first_project/models/shop_app/categories_model.dart';
import 'package:first_project/models/shop_app/home_model.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {

  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context ,state){
        if(state is ShopLayoutSuccessChangeFavouritesState)
          if(!state.changeFavouritesModel.status) {
            ShowToast(mesg: state.changeFavouritesModel.message, color: Colors.red);
          }
      } ,
      builder: (context , state) {
        var cubit = ShopLayoutCubit.get(context);
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.homemodel != null && cubit.categorirsModel != null,
            widgetBuilder: (context) => productsBuilder(cubit.homemodel!, cubit.categorirsModel!,context),
            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
  Widget productsBuilder(HomeModel model, CategorirsModel categorirsModel,context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.banners.map((e) => Image( 
              image: NetworkImage(e.image),
              width: double.infinity,
              fit : BoxFit.cover
          ) ).toList(),
          options: CarouselOptions(
            height: 200.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds:  3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),),
        const SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Categories", style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800),),
              const SizedBox(height: 10.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index) => buildCategoryItem(categorirsModel.categoriesDataModel.data[index]),
                    separatorBuilder: (context , index) => const SizedBox(width: 10.0,),
                    itemCount:categorirsModel.categoriesDataModel.data.length),
              ),
              const SizedBox(height: 20.0,),
              const Text("New Products", style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800),),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            crossAxisCount: 2 ,
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0, 
            childAspectRatio: 1/1.58, 
            children: List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index],context),),// return list of widgets
          ),
        )
      ],
    ),
  );

  Widget buildGridProduct(ProductModel productModel,context) => Container(
    color: Colors.white,
    child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
          image: NetworkImage(productModel.image),
          width: double.infinity,
          height: 200.0,),
          if(productModel.discount != 0)
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: const Text("DISCOUNT",style: TextStyle(fontSize: 8.0,color:Colors.white,fontWeight: FontWeight.bold ),),)


        ]
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productModel.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: (const TextStyle(height: 1.3,fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Text(
                  '${productModel.price.round()}',
                  style: (const TextStyle(fontSize: 12,color: Colors.blue,fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 5.0,),
                if(productModel.discount != 0)
                  Text(
                    '${productModel.oldprice.round()}',
                    style: (const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough
                    )),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: (){
                      ShopLayoutCubit.get(context).changeFavourites(productModel.id);
                      },
                    icon: CircleAvatar(
                      radius: 17.0,
                      backgroundColor: favourites[productModel.id]! ? Colors.blue : Colors.grey,
                      child: const Icon(
                          Icons.favorite_border,
                          size: 16.0,
                          color: Colors.white,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),

    ],),
  );

  Widget buildCategoryItem(DataModel dataModel) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
    Image(image: NetworkImage(dataModel.image),height: 100.0,width: 100.0,fit: BoxFit.cover,),
    Container(
      width: 100.0,
      color: Colors.black.withOpacity(0.7),
      child: Text(
        dataModel.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center ,
        style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.white),),
        ),
    ],
  );



}
