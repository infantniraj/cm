import 'package:cm/colors.dart';
import 'package:cm/controllers/popular_product_controller.dart';
import 'package:cm/controllers/recommended_product_controller.dart';
import 'package:cm/models/products_models.dart';
import 'package:cm/pages/food/popular_food_details.dart';
import 'package:cm/routes/route_helper.dart';
import 'package:cm/util/app_constants.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_column.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/icons_and_text_widget.dart';
import 'package:cm/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _cureentPageValue =0.0;
  double _scaleFactor=0.8;
  double _height =Dimentions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _cureentPageValue = pageController.page!;
        print("CurrentPageValue"+_cureentPageValue.toString());
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return  popularProducts.isLoaded?Container(
            // color: Colors.redAccent,
            height: Dimentions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }
              ),
          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        // Dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _cureentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular Text
        SizedBox(height: Dimentions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimentions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color:Colors.black26),
              ),
              SizedBox(width: Dimentions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing",),
              )
            ],
          ),
        ),
        //recommended food
        //list of sea foods images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index));
                    },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimentions.width20,right: Dimentions.width20,bottom: Dimentions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          width:Dimentions.listViewImgSize,
                          height: Dimentions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimentions.raidus20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+recommendedProduct.recommendedProductList[index].img!
                                  )
                              )
                          ),
                        ),
                        //text container
                        Expanded(
                          child: Container(
                            height: Dimentions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimentions.raidus20),
                                  bottomRight: Radius.circular(Dimentions.raidus20)
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left:Dimentions.width10,right: Dimentions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text:recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: Dimentions.height10,),
                                  SmallText(text: "This is the descrption of the product and details"),
                                  SizedBox(height: Dimentions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.7KM",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(
                                        icon: Icons.access_time_rounded,
                                        text: "20Min",
                                        iconColor: AppColors.iconColor2,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                        )

                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: AppColors.mainColor,
          );

        }),

      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_cureentPageValue.floor()){
      var currScale = 1-(_cureentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index== _cureentPageValue.floor()+1){
      var currScale = _scaleFactor+(_cureentPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index== _cureentPageValue.floor()-1){
      var currScale = 1-(_cureentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale =0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
        transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.raidus30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimentions.width30,right: Dimentions.width30,bottom: Dimentions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.raidus20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0),
                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimentions.height15,left: Dimentions.height15,right: Dimentions.height15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
