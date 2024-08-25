import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/support/ticket_details_controller.dart';
import 'package:changa_lab/data/repo/support/support_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/screen/ticket/ticket_details_screen/sections/message_list_section.dart';
import 'package:changa_lab/view/screen/ticket/ticket_details_screen/sections/reply_section.dart';
import 'package:changa_lab/view/screen/ticket/ticket_details_screen/widget/ticket_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  String title = "";
  @override
  void initState() {
    String ticketId = Get.arguments[0];
    title = Get.arguments[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportTicketRepo(apiClient: Get.find()));
    var controller = Get.put(TicketDetailsController(repo: Get.find(), ticketId: ticketId));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
      builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            bgColor: MyColor.primaryColor,
            title: MyStrings.replyTicket,
            titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
            action: [
              if (controller.model.data?.myTickets?.status != '3')
                controller.closeLoading
                    ? const CustomLoader(loaderColor: MyColor.colorWhite,)
                    : InkWell(
                      onTap: () {
                         controller.closeTicket(controller.model.data?.myTickets?.id.toString() ?? '-1');
                      },
                      child: Container(
                        decoration:const BoxDecoration( color: MyColor.redCancelTextColor ,shape: BoxShape.circle),
                          margin: const EdgeInsets.all(Dimensions.space15),
                          padding:const EdgeInsets.symmetric(horizontal: Dimensions.space10,vertical:Dimensions.space5),
                          child: const CustomSvgPicture(image:MyImages.cancel,svgColor: true,color: MyColor.white,)
                        ),
                    )
            ],
          ),
          body: controller.isLoading
              ? const CustomLoader(isFullScreen: true)
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TicketStatusWidget(controller: controller),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: MyColor.getCardBgColor(),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ReplySection(), MessageListSection()],
                          ),
                        ) 
                      ],
                    ),
                  ),
                )),
    );
  }
}
