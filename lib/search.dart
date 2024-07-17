// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
// import 'package:shopping_app/end_points.dart';
import 'package:shopping_app/model/search_model.dart';
import 'reusable components/reusable_components.dart';

TextEditingController search =TextEditingController();
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state) 
      {
        var favourite=ShoppingCubit.get(context).favourite;
        return
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: formfield(controller: search, validate: (String ? value){
                  if(value!.isEmpty)
                  {
                    return "Search Must Not Be Empty";
                  }
                  else
                  {
                    return null;
                  }
                }, type: TextInputType.text, label: "Search", prefix: const Icon(Icons.search),sumbit: (String value){
                  ShoppingCubit.get(context).getSearchData(text: value);
                }),
              ),
              // ignore: unnecessary_null_comparison
              if(ShoppingCubit.get(context).searchModel!.data!.data.isNotEmpty)
              const SizedBox(height: 20.0,),
              ConditionalBuilder(
                condition: state is! ShoppingSearchLoadingState,
                builder:(context) =>Expanded(
                  child: ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(context, index) => searchItem(context,ShoppingCubit.get(context).searchModel!.data!.data[index],favourite),
                  separatorBuilder:(context, index) => hr(color: Colors.grey),
                  itemCount:ShoppingCubit.get(context).searchModel!.data!.data.length,
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}

  Widget searchItem(BuildContext context,DataDetails model,Map<int?,bool?> favorite)=>
  Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      width: double.infinity,
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(model.name!,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18.0),maxLines: 2,overflow: TextOverflow.ellipsis,),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${model.price!.round()}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18.0),),
                    const Spacer(),
                    IconButton(onPressed: (){
                    ShoppingCubit.get(context).changeFavourite(model.id!);
                    }, icon: const Icon(
                    Icons.favorite,
                    ),
                    padding: EdgeInsetsDirectional.zero,
                    color:(favorite[model.id]==true) ?Colors.red :Colors.grey ,
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