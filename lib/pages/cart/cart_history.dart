import 'dart:convert';

import 'package:cm/base/no_data_page.dart';
import 'package:cm/colors.dart';
import 'package:cm/controllers/cart_controller.dart';
import 'package:cm/models/cart_model.dart';
import 'package:cm/util/app_constants.dart';
import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/app_icon.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:cm/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../routes/route_helper.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});
  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOrder = Map();

    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);

      }

    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder =  cartItemsPerOrderToList();

    var listCounter=0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }

      return BigText(text:outputDate);
    }

    return Scaffold(

      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            height: Dimentions.height10*10,
            width: double.maxFinite,
            padding: EdgeInsets.only(top:Dimentions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color:Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  backgroundColor: AppColors.iconColor2,
                  iconColor: AppColors.mainColor,),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?Expanded(
              child: Container(
                  height: 500,
                  margin: EdgeInsets.only(
                    top:Dimentions.height20,
                    left: Dimentions.width20,
                    right:Dimentions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context, child: ListView(
                    children: [
                      for(int i=0; i<cartItemsPerOrder.length;i++)
                        Container(
                          height:Dimentions.height30*4,
                          margin: EdgeInsets.only(
                              bottom: Dimentions.height20
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height: Dimentions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index){
                                      if(listCounter<getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index<2?Container(
                                        height: Dimentions.height20*4,
                                        width: Dimentions.height20*4,
                                        margin: EdgeInsets.only(right: Dimentions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimentions.raidus15/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.IMAGE_URI_BASEURL+getCartHistoryList[listCounter-1].img!))
                                        ),
                                      ):Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimentions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total",color: AppColors.mainBlackColor,),
                                        BigText(text: itemsPerOrder[i].toString()+" Items",color: AppColors.mainBlackColor,),
                                        GestureDetector(
                                          onTap:(){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder ={};
                                            for(int j=0; j<getCartHistoryList.length;j++){
                                              if(getCartHistoryList[j].time==orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, ()=>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());

                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimentions.width10,vertical: Dimentions.height10/2 ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimentions.raidus15/3),
                                              border: Border.all(width: 1,color: AppColors.mainColor),
                                            ),
                                            child: SmallText(text: "One More",color: AppColors.mainColor,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),)
              ),
            ):
            SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                  child: NoDataPage(text: "Your Didn't Buy anything so far !",
                    imgPath: "assets/images/empty-cart-1.png",),
                ));
          })
        ],
      ),
    );
  }
}
