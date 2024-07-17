import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cache/cache.dart';
import 'package:shopping_app/cubit/shopping_cubit.dart';
import 'package:shopping_app/cubit/states.dart';
import 'package:shopping_app/home_layout.dart';
// import 'package:shopping_app/register.dart';
import 'package:shopping_app/reusable%20components/reusable_components.dart';

TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
TextEditingController phoneController=TextEditingController();
var formKey=GlobalKey<FormState>();
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShoppingCubit,ShoppingStates>(
      listener: (context, state) {
        if(state is ShoppingRegisterSuccessState)
        {
          if(state.model.status!)
          {
            // print(state.model.status);
            toast(state.model.message!,Colors.green,5);
            CacheHelper.saveData("token",state.model.data!.token).then(
              (value) 
              {
                token=state.model.data!.token;
                ShoppingCubit.get(context).getFavouriteData();
                ShoppingCubit.get(context).getUserData();
                navigateAndFinish(context, const HomeLayout());
           });
          }
          else
          {
            // print(state.model.status);
            toast(state.model.message!,Colors.red,5);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:Colors.white ,
          elevation: 0.0,
          foregroundColor: Colors.grey,
        ),
        body:  Center(
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics() ,
            child: Padding(
              padding:  const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text(
                      "REGISTER",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
                    ),
                     const SizedBox(height: 10.0,),
                     const Text(
                      "Register To Browse Our Offers",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.grey),
                    ),
                      const SizedBox(height: 30.0,)
                      ,
                    formfield(
                      controller:nameController ,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Name Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.name,
                      label: "User Name",
                      prefix:const Icon(Icons.person)
                         ),
                   const SizedBox(height: 20.0,),
                    formfield(
                      controller:emailController ,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Email Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.emailAddress,
                      label: "Email Address",
                      prefix:const Icon(Icons.email),
                         ),
                         const SizedBox(height: 20.0,)
                         ,
                      formfield(
                      controller:passController,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Password Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.visiblePassword,
                      label: "Password",
                      prefix:const Icon(Icons.lock_outline),
                      suffix:  IconButton(onPressed: (){
                        ShoppingCubit.get(context).changeFormRegister();}, icon: Icon(ShoppingCubit.get(context).passwordRegister)),
                      ispassword:ShoppingCubit.get(context).isPasswordRegister,
                         ),
                         const SizedBox(height: 20.0,)
                         ,
                      formfield(
                      controller:phoneController,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Phone Number Must Not Be Empty";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      type: TextInputType.phone,
                      label: "Phone Number",
                      prefix:const Icon(Icons.phone),
                         ),
                         const SizedBox(height: 20.0,)
                         ,
                      ConditionalBuilder(
                      condition: state is! ShoppingRegisterLoadingState,
                      builder:(context) => 
                      MaterialButton(onPressed: (){
                        if(formKey.currentState!.validate())
                        {
                           ShoppingCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passController.text,
                            phone: phoneController.text,
                            name:nameController.text,
                            );
                        }
                      },
                      color: Colors.blue[400],
                      minWidth: double.infinity,
                      height: 50.0,
                      child: const Text("SIGN IN" ,style: TextStyle(color: Colors.white,fontSize: 18.0),),
                      ), 
                      fallback: (context) => const Center(child:  CircularProgressIndicator()),
                        ),
                      const SizedBox(height: 20.0,),
                        ]
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}