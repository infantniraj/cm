import 'package:cm/colors.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/account_widget.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size:24,color: Colors.white,),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top:Dimentions.height20),
        child: Column(
          children: [
            //profile icon
            AppIcon(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,iconSize: Dimentions.height45+Dimentions.height30,
              size: Dimentions.height15*10,),
            SizedBox(height: Dimentions.height20,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(appIcon: AppIcon(icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: 'Infant')),
                    SizedBox(height: Dimentions.height20,),
                    //phone
                    AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: '8675427161')),
                    SizedBox(height: Dimentions.height20,),
                    //email
                    AccountWidget(appIcon: AppIcon(icon: Icons.email,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: 'Infant@gmail.com')),
                    SizedBox(height: Dimentions.height20,),
                    //Address
                    AccountWidget(appIcon: AppIcon(icon: Icons.location_city,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: '234,6th cross street,btm,bengalure')),
                    SizedBox(height: Dimentions.height20,),
                    //text
                    AccountWidget(appIcon: AppIcon(icon: Icons.message,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: 'Infant')),
                    SizedBox(height: Dimentions.height20,),
                    AccountWidget(appIcon: AppIcon(icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,iconSize: Dimentions.height10*5/2,
                      size: Dimentions.height10*5,), bigText: BigText(text: 'Infant')),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
