import 'package:cm/base/show_custom_snack_bar.dart';
import 'package:cm/colors.dart';
import 'package:cm/pages/auth/sign_in_page.dart';
import 'package:cm/pages/auth/sign_up_page.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_text_field.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _registeration(){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar("Please enter your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Please enter your phonenumber",title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Please enter your email",title: "Email Address");
      }else if(GetUtils.isEmail(email)){
        showCustomSnackBar("Please enter valid email",title: "Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Please enter the password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Please should least six characters",title: "Password");
      }else{
        showCustomSnackBar("All Went well",title: "ok");
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimentions.screenHeight*0.05,),
            Container(
              height: Dimentions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/images/anchor.jpg"
                  ),
                ),
              ),
            ),
            //email
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height: Dimentions.height20,),
            //password
            AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password_sharp),
            SizedBox(height: Dimentions.height20,),
            //name
            AppTextField(textController: nameController, hintText: "Name", icon: Icons.person),
            SizedBox(height: Dimentions.height20,),
            //phone
            AppTextField(textController: phoneController, hintText: "Phone", icon: Icons.phone),
            SizedBox(height: Dimentions.height45,),

            GestureDetector(
              onTap: (){
                _registeration();
              },
              child: Container(
                width: Dimentions.screenWidth/2,
                height: Dimentions.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.raidus30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                 child:  BigText(
                    text: "Register",
                    size: Dimentions.font20+Dimentions.font20/2,
                   color: Colors.white,
                 ),
                ),
                ),
            ),
            SizedBox(
              height: Dimentions.height45,
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                    text: "Have an account already?",
                    style:TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimentions.font20,
                    ),
                  children: [
                    TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                    text: " Log In",
                    style:TextStyle(
                      color: AppColors.mainBlackColor,
                      fontSize: Dimentions.font20,
                    )),
                  ],
                ),
            ),
            SizedBox(height: Dimentions.screenHeight*0.05,),
          ],
        ),
      ),
    );
  }
}
