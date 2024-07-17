import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/model/favourite_data_mode.dart';

import 'reusable components/reusable_components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state) 
      {
        return ConditionalBuilder(
          condition: state is! ShoppingGetFavouriteLoadingState,
         builder:(context) =>  ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder:(context, index) => favoriteItem(context,ShoppingCubit.get(context).getFavourite!.data!.data[index]),
          separatorBuilder:(context, index) => hr(color: Colors.grey),
          itemCount:ShoppingCubit.get(context).getFavourite!.data!.data.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget favoriteItem(BuildContext context,Data ?  model)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 100.0,
        width: double.infinity,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(model!.product!.image!),
                      width: 100.0,
                      height:100.0,
                      fit: BoxFit.cover,
                      ),
                       if(model.product!.discount!=0)
                      Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Container(
                          padding:const EdgeInsets.symmetric(horizontal:5.0),
                          color: Colors.yellow,
                          child:  Text("${model.product!.discount}% SALE",style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),),
                        ),
                      )
                  ],
                )
                  ,
                const SizedBox(width: 20.0,),
                  Expanded(
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                      model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                    ),
                    const Spacer(),
                        Row(
                          children: [
                            Text(
                            "${model.product!.price!.round()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.blueAccent,
                            ),
                               ),
                           const SizedBox(width: 5.0,),
                           Text(
                            "${(model.product!.discount !=0 )?model.product!.oldPrice!.round():''}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.green,
                              decoration: TextDecoration.lineThrough,
                            ),
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){
                              ShoppingCubit.get(context).changeFavourite(model.product!.productId!);
                            }, icon: const Icon(
                              Icons.favorite,
                              ),
                              padding: EdgeInsetsDirectional.zero,
                              color:(ShoppingCubit.get(context).favourite[model.product!.productId!]!) ?Colors.red :Colors.grey ,
                              )
                          ],
                        ),
                      ],
                    ),
                  )
              ],
            ),
      ),
    );
}