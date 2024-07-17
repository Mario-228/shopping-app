import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/category.dart';
import 'package:shopping_app/favourite.dart';
// import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
// import 'package:shopping_app/login.dart';
import 'package:shopping_app/products.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';
import 'package:shopping_app/search.dart';
import 'package:shopping_app/settings.dart';

List<Widget> screens=const
[
  ProductsScreen(),
  CategoryScreen(),
  FavouriteScreen(),
  SettingsScreen()
];
class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {} ,
      builder: (context, state) {
        return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.white,
     elevation: 0.0,
     actionsIconTheme: const IconThemeData(color: Colors.black,),
      title:const Text("MK Market",style: TextStyle(color: Colors.black),),
      actions: [
        IconButton(onPressed: (){
          // ShoppingCubit.get(context).getSearchData(text:"*");
          navigateTo(context, const SearchScreen());
        }, icon: const Icon(Icons.search)),
      ],
    ),
    body: screens[ShoppingCubit.get(context).currentIndex],
    bottomNavigationBar:BottomNavigationBar(
      showSelectedLabels:true,
      currentIndex: ShoppingCubit.get(context).currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        ShoppingCubit.get(context).changeBottom(value);
      },
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home"
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: "Category",
        ),

      BottomNavigationBarItem(icon: Icon(Icons.favorite),
      label: "Favourite"
      ),
      BottomNavigationBarItem(icon:Icon(Icons.settings) ,
      label: "Settings"
      )
    ],
    ) ,
    );
      },
    );
  }
}