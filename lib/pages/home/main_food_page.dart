import 'package:cm/colors.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await  Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();

  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: Column(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(top:Dimentions.height45,bottom: Dimentions.height15),
            padding: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "India",color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: "Bangalore",color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimentions.height45,
                    height: Dimentions.height45,
                    child: Icon(Icons.search,color: Colors.white,size: Dimentions.iconSize24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.raidus15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ), onRefresh: _loadResources);
  }
}
