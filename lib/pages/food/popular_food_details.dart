import 'package:cm/controllers/popular_product_controller.dart';
import 'package:cm/pages/home/main_food_page.dart';
import 'package:cm/util/app_constants.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_column.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icons_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;

  PopularFoodDetails({Key? key,required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
              width: double.maxFinite,
                height: Dimentions.popularFoodImageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+product.img!
                    )
                  )
                ),
          )),
          //Icon Widget
          Positioned(
              top: Dimentions.height45,
              left: Dimentions.width20,
              right: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>MainFoodPage());
                      },
                      child: AppIcon(icon: (Icons.arrow_back_ios))),
                  AppIcon(icon: (Icons.shopping_cart_checkout_outlined)),
                ],
              )
          ),
          //Introduction Sections
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimentions.popularFoodImageSize-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20,top: Dimentions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimentions.raidus20),
                      topLeft: Radius.circular(Dimentions.raidus20)
                    ),
                    color: Colors.white
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimentions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimentions.height20,),
                    //Expandable Text widget
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!)))
                  ],
                )
          ))
          
        ],
      ),
      bottomNavigationBar: Container(
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
                  Icon(Icons.remove,color:AppColors.signColor),
                  SizedBox(width: Dimentions.width10/2,),
                  BigText(text: "0"),
                  SizedBox(width: Dimentions.width10/2,),
                  Icon(Icons.add,color: AppColors.signColor,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimentions.height15,bottom: Dimentions.height15,left: Dimentions.width20,right: Dimentions.width20),
              child: BigText(text: "\$ ${product.price!}" + " | Addto Cart",color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.raidus20),
                color: AppColors.mainColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
