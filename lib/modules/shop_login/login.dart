import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy/modules/Register/register.dart';
import 'package:shopy/modules/shop_layout/layout_screen.dart';
import 'package:shopy/modules/shop_login/cubit/cubit.dart';
import 'package:shopy/modules/shop_login/cubit/states.dart';
import 'package:shopy/network/local/cache_helper.dart';
import 'package:shopy/shared/components/components.dart';

//ignore: must_be_immutable
class ShopLogInScreen extends StatelessWidget {
  ShopLogInScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopingLoginCubit(),
      child: BlocConsumer<ShopingLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState) {
            if(state.loginModel.status){
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                navigateAndFinish(context,ShopLayout());
              });

            }else{
              showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('LOG IN',
                          style:TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                          ),
                        ),
                        const Text('login to browse our hot offers',
                          style:TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'cairo',
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        FormField(builder: (context)=> TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Email Address must not be empty';
                            }
                            return null;
                          },
                         ),),
                        const SizedBox(height: 15.0,),
                        FormField(builder: (context)=> TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              ShopingLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                        ),),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=> Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: MaterialButton(
                              color: Colors.blue,
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    ShopingLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: const Text('LOG IN',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'cairo',
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          ),
                          fallback: (context)=> const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'cairo',
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                navigateAndFinish(context, const RegisterScreen());
                              },
                              child: const Text('REGISTER',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'cairo',
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}