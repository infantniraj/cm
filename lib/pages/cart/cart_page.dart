import 'package:cm/colors.dart';
import 'package:cm/controllers/cart_controller.dart';
import 'package:cm/pages/home/main_food_page.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_constants.dart';

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
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>MainFoodPage());
                      },
                      child: AppIcon(icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimentions.iconSize24,
                      ),
                    ),
                    AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),

                  ],
                )
            ),
            Positioned(
                top: Dimentions.height20*5,
                left:Dimentions.width20,
                right: Dimentions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top:Dimentions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      return ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimentions.height20*5,
                              width: double.maxFinite,
                              //color:Colors.blue,
                              margin: EdgeInsets.only(bottom: Dimentions.height10),
                              child: Row(
                                children: [
                                  Container(
                                    width: Dimentions.height20*5,
                                    height: Dimentions.height20*5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants.BASE_URL+cartController.getItems[index].img!),
                                        ),
                                        borderRadius:BorderRadius.circular(Dimentions.raidus20),
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(width: Dimentions.width10,),
                                  Expanded(child: Container(
                                    height: Dimentions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: cartController.getItems[index].price!.toString(),color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimentions.height10,bottom: Dimentions.height10,left: Dimentions.width10,right: Dimentions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimentions.raidus20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap:(){
                                                        //popularProduct.setQuantity(false);
                                                      },
                                                      child: Icon(Icons.remove,color:AppColors.signColor)
                                                  ),
                                                  SizedBox(width: Dimentions.width10/2,),
                                                  BigText(text: "0"),//popularProduct.inCartItems.toString()),
                                                  SizedBox(width: Dimentions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        //popularProduct.setQuantity(true);
                                                      },
                                                      child: Icon(Icons.add,color: AppColors.signColor,)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),)
                                ],
                              ),
                            );
                          });
                    },),
                  ),
            ))
          ])
    );
  }
}
