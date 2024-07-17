// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/model/categories.dart';

import 'reusable components/reusable_components.dart';

class CategoryScreen extends StatelessWidget 
{
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state) 
      {
        return ListView.separated(
        physics:const BouncingScrollPhysics(),
        itemBuilder:(context, index) => buildCatItem(ShoppingCubit.get(context).categoryData!.data!.data[index]),
        separatorBuilder:(context, index) => hr(color: Colors.grey),
        itemCount:ShoppingCubit.get(context).categoryData!.data!.data.length
        );
      },
    );
  }

  Widget buildCatItem(DataInfo model)=>Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image(
            image: NetworkImage(model.image!),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
        ),
        const SizedBox(width: 20.0,),
        Text(model.name!,
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20.0),
        ),
        const Spacer(),
        IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios))
      ],
    );

}