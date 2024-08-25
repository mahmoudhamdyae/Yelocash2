import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/account/profile_complete_controller.dart';
import 'package:changa_lab/data/model/country/country_model.dart';
import 'package:changa_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:changa_lab/view/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:changa_lab/view/components/card/bottom_sheet_card.dart';
import 'package:changa_lab/view/components/image/my_image_widget.dart';
import 'package:changa_lab/view/components/text-form-field/label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CountryBottomSheet {
  static void profileCompleteCountryBottomSheet(BuildContext context, ProfileCompleteController controller) {
    CustomBottomSheetPlus(
        bgColor: MyColor.getGreyColor().withOpacity(.2),
        isNeedPadding: false,
        child: StatefulBuilder(builder: (context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              List<Countries> filterData = controller.filteredCountries.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
              setState(() {
                controller.filteredCountries = filterData;
              });
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: MyColor.getCardBgColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: MyUtils.getShadow(),
            ),
            child: Column(
              children: [
                const BottomSheetBar(),
                const SizedBox(height: 10),
                LabelTextField(
                  labelText: '',
                  hintText: '${MyStrings.searchCountry.tr}${controller.countryList.length}',
                  controller: controller.countryController,
                  textInputType: TextInputType.text,
                  onChanged: filterCountries,
                  prefixIcon:  Icon(
                    Icons.search,
                    color: MyColor.getGreyColor(),
                  ),
                  labelTextStyle: boldDefault.copyWith(),
                  fillColor: MyColor.getGreyColor().withOpacity(0.01),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.countryController.text = controller.filteredCountries[index].country ?? '';
                            controller.setCountryNameAndCode(controller.filteredCountries[index].country ?? '', controller.filteredCountries[index].countryCode ?? '', controller.filteredCountries[index].dialCode ?? '');

                            Navigator.pop(context);

                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: BottomSheetCard(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", countryItem.countryCode.toString().toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '+${controller.filteredCountries[index].dialCode}  ${controller.filteredCountries[index].country?.tr ?? ''}',
                                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        })).show(context);
  }
}
