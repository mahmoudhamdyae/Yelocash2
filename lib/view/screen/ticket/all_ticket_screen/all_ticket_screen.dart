import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/ticket_helper.dart';
import 'package:changa_lab/data/controller/support/support_controller.dart';
import 'package:changa_lab/data/repo/support/support_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/floating_action_button/fab.dart';
import 'package:changa_lab/view/components/no_support_ticket_screen.dart';
import 'package:changa_lab/view/components/shimmer/all_ticket_shimmer.dart';
import 'package:changa_lab/view/screen/ticket/all_ticket_screen/widget/all_ticket_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTicketScreen extends StatefulWidget {
  const AllTicketScreen({super.key});

  @override
  State<AllTicketScreen> createState() => _AllTicketScreenState();
}

class _AllTicketScreenState extends State<AllTicketScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<SupportController>().hasNext()) {
        Get.find<SupportController>().getSupportTicket();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportTicketRepo(apiClient: Get.find()));
    final controller = Get.put(SupportController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(builder: (controller) {
      return Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar:  CustomAppBar(title: MyStrings.supportTicket,bgColor: MyColor.primaryColor,titleStyle: regularDefault.copyWith(color: MyColor.colorWhite)),
        body: RefreshIndicator(
            onRefresh: () async {
              controller.loadData();
            },
            color: MyColor.primaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: Dimensions.defaultPaddingHV,
              child: controller.isLoading ?
              ListView.separated(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context,index) => Container(margin: const EdgeInsets.only(bottom: Dimensions.space10)),
                  itemBuilder: (BuildContext context, int index) {
                    return const TicketShimmer();
                  }) : controller.ticketList.isEmpty ?
                const Center(child: NoSupportTicketScreen(image: MyImages.noSupport)) :
              ListView.separated(
                controller: scrollController,
                itemCount: controller.ticketList.length + 1,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                itemBuilder: (context, index) {
                  if (controller.ticketList.length == index) {
                    return controller.hasNext()
                        ? const CustomLoader(isPagination: true)
                        : const SizedBox();
                  }
                  return GestureDetector(
                      onTap: () {
                        String id = controller.ticketList[index].ticket ?? '-1';
                        String subject = controller.ticketList[index].subject ?? '';
                        Get.toNamed(RouteHelper.ticketDetailsScreen, arguments: [id, subject]);
                      },
                      child: AllTicketListItem(
                          ticketNumber: controller.ticketList[index].ticket ?? '',
                          subject: controller.ticketList[index].subject ?? '',
                          status: TicketHelper.getStatusText(controller.ticketList[index].status ?? '0'),
                          priority: TicketHelper.getPriorityText(controller.ticketList[index].priority ?? '0'),
                          statusColor: TicketHelper.getStatusColor(controller.ticketList[index].status ?? '0'),
                          priorityColor: TicketHelper.getPriorityColor(controller.ticketList[index].priority ?? '0'),
                          time: DateConverter.getFormatedSubtractTime(controller.ticketList[index].createdAt ?? '')
                      )
                  );
                },
              ),
            )),
        floatingActionButton: FAB(
          callback: () {
            Get.toNamed(RouteHelper.newTicketScreen)?.then(
                    (value) => {
                  if(value != null && value == 'updated'){
                    controller.getSupportTicket(),
                    controller.loadData()
                  }
                });
          },
        ),
      );
    });
  }
}