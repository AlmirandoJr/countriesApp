import 'package:challenge2ibi/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  //FloatingModal({this.child, this.backgroundColor = Colors.blue});
  
  const FloatingModal({Key key, this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: Get.height*0.10,
          left: Get.width*0.05,
          right: Get.width*0.05,
          top: Get.height*0.10,

        ),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: child,
        ),
      ),
    );
  }
}

Future<T> showFloatingModalBottomSheet<T>({
  @required BuildContext context,
  @required ScrollWidgetBuilder builder,
  Color backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
    context: context,
    builder: builder,
    barrierColor: appColor.withOpacity(0.3),
    containerWidget: (_, animation, child) => FloatingModal(
      child: child,
      backgroundColor: Color(0xFF1e2433),
    ),
    expand: false
  );

  return result;
}