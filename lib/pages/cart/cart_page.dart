import 'package:cm/colors.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Stack(
          children: [
            Positioned(
                left: Dimentions.width20,
                right: Dimentions.width20,
                top: Dimentions.height20*3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),
                    SizedBox(width: Dimentions.width20*5,),
                    AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),
                    AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),

                  ],
                )
            ),
          ])
    );
  }
}
