import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
// import 'package:shopping_app/dio/dio.dart';
// import 'package:shopping_app/end_points.dart';
import 'package:shopping_app/login.dart';
import 'reusable components/reusable_components.dart';
var formKey=GlobalKey<FormState>();
bool isClick=true;
class SettingsScreen extends StatelessWidget {
  
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController name =TextEditingController();
        TextEditingController phone =TextEditingController();
        TextEditingController email =TextEditingController();
        if(ShoppingCubit.get(context).update!=null)
        {
        name.text=ShoppingCubit.get(context).update!.data!.name!;
        phone.text=ShoppingCubit.get(context).update!.data!.phone!;
        email.text=ShoppingCubit.get(context).update!.data!.email!;
        }
        else
        {
        name.text=ShoppingCubit.get(context).userModel!.data!.name!;
        phone.text=ShoppingCubit.get(context).userModel!.data!.phone!;
        email.text=ShoppingCubit.get(context).userModel!.data!.email!;
        }
        return 
          ConditionalBuilder(
          condition:ShoppingCubit.get(context).userModel!=null ,
          builder:(context)=> 
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                formfield(controller:name ,label:"User Name" ,prefix:const Icon(Icons.person) ,type:TextInputType.name ,
                validate:(String ? value)
                {
                if(value!.isEmpty)
                {
                  return "Name Must Not Be Empty";
                }
                else
                {
                  return null;
                }
                },isClick: isClick,),
              const SizedBox(height: 20.0,),
               formfield(controller:email ,label:"Email" ,prefix:const Icon(Icons.email) ,type:TextInputType.emailAddress ,validate:(value){
                if(value!.isEmpty)
                {
                  return "Email Must Not Be Empty";
                }
                else
                {
                  return null;
                }
              },isClick: isClick,),
              const SizedBox(height: 20.0,),
               formfield(controller:phone ,label:"Phone" ,prefix:const Icon(Icons.phone) ,type:TextInputType.phone ,validate:(value)
               {
                if(value!.isEmpty)
                {
                  return "Phone Must Not Be Empty";
                }
                else
                {
                  return null;
                }
              },isClick: isClick,),
              const SizedBox(height: 20.0,),
            MaterialButton(onPressed: ()
            {
            CacheHelper.removeData("token")
            .then((value)
            {
              if(value)
              {
                navigateAndFinish(context, const LoginScreen());
              }
            });
                   }, 
                  color: Colors.blue,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text("SIGN OUT",style:TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 20.0,),
                  ConditionalBuilder(
                    condition: state is! ShoppingUpdateLoadingState,
                    builder:(context) => MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                 ShoppingCubit.get(context).updateUserData(name: name.text, phone: phone.text, email: email.text);
                                 if(state is ShoppingUpdateSuccessState)
                                 {
                                //   ShoppingCubit.get(context).getUserData();
                                //  name.text=ShoppingCubit.get(context).userModel!.data!.name!;
                                //  phone.text=ShoppingCubit.get(context).userModel!.data!.phone!;
                                //  email.text=ShoppingCubit.get(context).userModel!.data!.email!;
                                  toast(ShoppingCubit.get(context).update!.message!,Colors.green, 3);
                                }
                                }
                              },
                    color: Colors.blue,
                    minWidth: double.infinity,
                    padding: const EdgeInsets.all(15.0),
                    child: const Text("Update",style:TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600)),
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
                  )
              ],
            ),
          ),
              ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}