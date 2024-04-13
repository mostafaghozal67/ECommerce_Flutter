import 'package:first_project/models/shop_app/favourites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../../layouts/ShopApp/cubit/ShopLayout_States.dart';
import '../../../layouts/ShopApp/cubit/ShopLayout_cubit.dart';
import '../../../shared/components/constants.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context , state){},
      builder: (context, state){
        var cubit = ShopLayoutCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! ShopLayoutLoadingGetFavouritesState ,
          widgetBuilder: (context) => ListView.separated(
              itemBuilder: (context , index) => buildFavIcon(cubit.favoritesModel!.data1!.data2[index].product!,context ),
              separatorBuilder: (context , index) => const Divider(),
              itemCount:cubit.favoritesModel!.data1!.data2.length),
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
  Widget buildFavIcon(ProductData productData, context) {
    //print(ShopLayoutCubit.get(context).favoritesModel!.data1!.data2.length);
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                    image: NetworkImage(productData.image),
                    width: 120,
                    height: 120.0,
                  ),
                  if (productData.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(fontSize: 8.0, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
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
                    productData.name ,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: (const TextStyle(height: 1.3, fontWeight: FontWeight.bold)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${productData.price?.round()}',
                        style: (const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 5.0),
                      if (productData.discount != 0)
                        Text(
                          '${productData.oldPrice?.round()}',
                          style: (const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          )),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavourites(productData.id);
                        },
                        icon: CircleAvatar(
                          radius: 17.0,
                          backgroundColor: favourites[productData.id]! ? Colors.blue : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 16.0,
                            color: Colors.white,
                          ),
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
