import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/view/components/shimmer/my_shimmer_widget.dart';
import 'package:flutter/material.dart';

class TicketShimmer extends StatelessWidget {
  const TicketShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color:  MyColor.getGreyColor().withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Column(
                      children: [
                        MyShimmerWidget(
                          child: Container(
                            width: double.infinity,
                            height: 15,
                            color:  MyColor.colorWhite,
                          ),
                        ),
                        const SizedBox(height: 5),
                       MyShimmerWidget(child:  Container(
                         width: double.infinity,
                         height: 12,
                         color:  MyColor.colorWhite,
                       )),
                      ],
                    ),
                  ),
                ),
                MyShimmerWidget(
                  child: Container(
                    width: 60,
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:  MyColor.colorWhite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyShimmerWidget(child: Container(
                  width: 60,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:  MyColor.colorWhite,
                  ),
                )),
               MyShimmerWidget(child:  Container(
                 width: 100,
                 height: 12,
                 color:  MyColor.colorWhite,
               ),)
              ],
            ),
          ],
        ),
    );
  }
}

