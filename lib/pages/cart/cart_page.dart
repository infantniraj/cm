import 'package:cm/colors.dart';
import 'package:cm/controllers/cart_controller.dart';
import 'package:cm/controllers/popular_product_controller.dart';
import 'package:cm/controllers/recommended_product_controller.dart';
import 'package:cm/pages/home/main_food_page.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
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
                        Get.toNamed(RouteHelper.getInitial());
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
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimentions.height20*5,
                              width: double.maxFinite,
                              //color:Colors.blue,
                              margin: EdgeInsets.only(bottom: Dimentions.height10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>()
                                          .popularProductList.indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }else{
                                        var recomendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList.indexOf(_cartList[index].product!);
                                        if(recomendedIndex<0){
                                          Get.snackbar("History Product", "Product Review is not available for history Products.",
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white,
                                          );
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFood(recomendedIndex,"cartpage"));
                                        }

                                      }
                                    },
                                    child: Container(
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
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,color:AppColors.signColor)
                                                  ),
                                                  SizedBox(width: Dimentions.width10/2,),
                                                  BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                  SizedBox(width: Dimentions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                       cartController.addItem(_cartList[index].product!, 1);

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
          ]),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimentions.bottomHeightBar,
            padding: EdgeInsets.only(top:Dimentions.height30,bottom: Dimentions.height30,left: Dimentions.width20,right: Dimentions.width20),
            decoration: BoxDecoration(
                color: AppColors.detailPageFooter,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.raidus20*2),
                  topRight: Radius.circular(Dimentions.raidus20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimentions.height15,bottom: Dimentions.height15,left: Dimentions.width20,right: Dimentions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.raidus20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimentions.width10/2,),
                      BigText(text: "\₹ "+cartController.totoalAmount.toString()),
                      SizedBox(width: Dimentions.width10/2,),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print("tapped");
                    cartController.addToHistory();
                    //popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimentions.height15,bottom: Dimentions.height15,left: Dimentions.width20,right: Dimentions.width20),
                    child: BigText(text: "Check Out",color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.raidus20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ),
          );
        })
    );
  }
}
