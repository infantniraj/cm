import 'package:cm/colors.dart';
import 'package:cm/controllers/recommended_product_controller.dart';
import 'package:cm/routes/route_helper.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../util/app_constants.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({Key? key,required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.initial);
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child: Center(child: BigText(size:Dimentions.font26,text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.raidus20),
                    topRight: Radius.circular(Dimentions.raidus20)
                  )
                ),
              ),
            ),
              pinned: true,
              backgroundColor: AppColors.blueColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(AppConstants.BASE_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,

                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child:ExpandableTextWidget(text: product.description,),
                  margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20),
          )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimentions.width20*2.5,
                right: Dimentions.width20*2.5,
                top: Dimentions.height10,
              bottom: Dimentions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize:Dimentions.iconSize24,
                    iconColor:Colors.white,
                    backgroundColor:AppColors.mainColor,
                    icon: Icons.remove),
                BigText(text: "\$ ${product.price!} X   0",color: AppColors.mainBlackColor,size: Dimentions.font26,),
                AppIcon(
                    iconSize:Dimentions.iconSize24,
                    iconColor:Colors.white,
                    backgroundColor:AppColors.mainColor,
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimentions.height15,bottom: Dimentions.height15,left: Dimentions.width20,right: Dimentions.width20),
                  child: BigText(text: "\$10 | Addto Cart",color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.raidus20),
                      color: AppColors.mainColor
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
