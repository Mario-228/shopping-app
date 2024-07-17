import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/model/categories.dart';
import 'package:shopping_app/model/home_model.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {

    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {
        if(state is ShoppingFavouriteSuccessState)
        {
          if(!state.model.status!)
          {
            toast(state.model.message!, Colors.red, 3);
          }
        }
      },
      builder: (context, state) 
      {
        return ConditionalBuilder(
        condition:ShoppingCubit.get(context).homeModel!=null ,
        builder: (context) {
          final model =ShoppingCubit.get(context).homeModel;
          return buildProduct(model,context);
        },
        fallback:(context) => const Center(child: CircularProgressIndicator()),
       );
      }
    );
  }

Widget buildProduct(HomeModel ? model,BuildContext context) => SingleChildScrollView(
  physics:const BouncingScrollPhysics(),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
        items:model!.data!.banners.map((e) => Image(
        image: NetworkImage(e.image!,),
      fit: BoxFit.cover,
      width: double.infinity,
      )
      ).toList() ,
       options: CarouselOptions(
        // aspectRatio: 1.0,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),//for one image
        height: 250.0,
        scrollDirection: Axis.horizontal,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(seconds: 3),//for all images
        initialPage: 0,
        reverse: false,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
       ),
       )
       ,
      const SizedBox(height:10.0,),
      const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.0),
      child:  Text("CATEGORIES",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20.0),),
      ),
      const SizedBox(height: 10.0,),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 100.0,
        child: ListView.separated(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => buildCategoriesItem(ShoppingCubit.get(context).categoryData!.data!.data[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
          itemCount:ShoppingCubit.get(context).categoryData!.data!.data.length,
          ),
      ),
      const SizedBox(height: 20.0,),
      const Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.0),
        child:  Text("PRODUCTS",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20.0),),
      ),
      const SizedBox(height: 10.0,),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        crossAxisCount: 2,
        childAspectRatio: 1/1.49,
        children: List.generate(model.data!.products.length, (index) => buildItem(model.data!.products[index],context)
        ),
        ),
      )
    ],
  ),
);

Widget buildItem(HomeProductsDataModel model,BuildContext context)=>
Container(
  color: Colors.white,
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height:200.0,
                  ),
                  if(model.discount!=0)
                  Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal:5.0),
                      color: Colors.yellow,
                      child:  Text("${model.discount}% SALE",style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.black,
                        ),),
                    ),
                  )
              ],
            )
              ,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  height: 1.3,
                ),
                ),
                    Row(
                      children: [
                        Text(
                        "${model.price!.round()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.blueAccent,
                        ),
                           ),
                       const SizedBox(width: 5.0,),
                       Text(
                        "${(model.discount!=0)?model.oldPrice!.round():''}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.green,
                          decoration: TextDecoration.lineThrough,
                        ),
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){
                          ShoppingCubit.get(context).changeFavourite(model.id!);
                        }, icon: const Icon(
                          Icons.favorite,
                          ),
                          padding: EdgeInsetsDirectional.zero,
                          color:ShoppingCubit.get(context).favourite[model.id]! ?Colors.red :Colors.grey ,
                          )
                      ],
                    ),
                  ],
                ),
              )
          ],
        ),
);

Widget buildCategoriesItem(DataInfo model)=>      
Stack(
      alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: 100.0,
              child:  Text(model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:  const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.white,
                   )
                   ,
                   ),
            )
        ],
      );
}