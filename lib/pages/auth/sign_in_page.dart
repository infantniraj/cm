import 'package:cm/colors.dart';
import 'package:cm/pages/auth/sign_up_page.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_text_field.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

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
                  radius: Dimentions.raidus20*4,
                  backgroundImage: AssetImage(
                      "assets/images/anchor.jpg"
                  ),
                ),
              ),
            ),
            //welcomesection
            Container(
              margin: EdgeInsets.only(left: Dimentions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome",
                    style: TextStyle(
                      fontSize: Dimentions.font20*3+Dimentions.font20/2,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Sign Into your account",
                    style: TextStyle(
                        fontSize: Dimentions.font20,
                      color: Colors.grey,
                    ),

                  ),

                ],
              ),
            ),
            SizedBox(height: Dimentions.height20,),
            //email
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height: Dimentions.height20,),
            //password
            AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password_sharp),
            SizedBox(height: Dimentions.height20,),
            //phone
            // AppTextField(textController: phoneController, hintText: "Phone", icon: Icons.phone),
            // SizedBox(height: Dimentions.height45,),

            Container(
              width: Dimentions.screenWidth/2,
              height: Dimentions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.raidus30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child:  BigText(
                  text: "Log In",
                  size: Dimentions.font20+Dimentions.font20/2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: Dimentions.height45,
            ),
            RichText(
              text: TextSpan(
                text: "Don\'t Have Account? ",
                style:TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimentions.font20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                  text: "Create",
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
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
