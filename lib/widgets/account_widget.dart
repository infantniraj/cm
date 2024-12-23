import 'package:cm/util/dimentions.dart';
import 'package:cm/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({super.key,required this.appIcon,required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: Dimentions.width20,
          top: Dimentions.width10,bottom: Dimentions.width10 ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimentions.width20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
