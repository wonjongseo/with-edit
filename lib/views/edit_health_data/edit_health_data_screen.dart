import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:with_diet/core/admob/global_banner_admob.dart';
import 'package:with_diet/core/enums/calory_type.dart';
import 'package:with_diet/core/enums/home_graph_type.dart';
import 'package:with_diet/core/utils/app_function.dart';
import 'package:with_diet/core/widgets/custom_button.dart';
import 'package:with_diet/core/widgets/custom_text_form_field.dart';
import 'package:with_diet/views/edit_health_data/edit_health_data_controller.dart';

class EditHealthDataScreen extends GetView<EditHealthDataController> {
  const EditHealthDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey dropdownKey = GlobalKey();
    final GlobalKey dropdownKey2 = GlobalKey();

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: '저장',
              onTap: () {
                controller.onSave();
              },
            ),
            SizedBox(height: 10),
            const GlobalBannerAdmob(),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
            child: GetBuilder<EditHealthDataController>(
              builder: (controller) {
                return Column(
                  children: [
                    CustomTextFormField(
                      hintText:
                          controller.selectedHealthType == null
                              ? '카테고리를 선택해주세요'
                              : controller.selectedHealthType!.label,
                      readOnly: true,
                      onTap: () {
                        AppFunction.openDropdown(dropdownKey);
                      },
                      widget: DropdownButton2(
                        key: dropdownKey,
                        dropdownStyleData: DropdownStyleData(
                          width: size.width * .7,
                        ),
                        underline: SizedBox(),
                        items: List.generate(HomeGraphType.values.length, (
                          index,
                        ) {
                          HomeGraphType type = HomeGraphType.values[index];
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.label),
                          );
                        }),
                        onChanged: controller.onChangeHealthType,
                      ),
                    ),

                    if (controller.selectedHealthType ==
                        HomeGraphType.calory) ...[
                      SizedBox(height: 12),
                      CustomTextFormField(
                        hintText:
                            controller.selectedCaloryType == null
                                ? '영양소를 골라주세요'
                                : controller.selectedCaloryType?.label,
                        readOnly: true,
                        onTap: () => AppFunction.openDropdown(dropdownKey2),
                        widget: DropdownButton2(
                          key: dropdownKey2,
                          dropdownStyleData: DropdownStyleData(
                            width: size.width * .7,
                          ),
                          underline: SizedBox(),
                          items: List.generate(CaloryType.values.length, (
                            index,
                          ) {
                            CaloryType type = CaloryType.values[index];
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.label),
                            );
                          }),
                          onChanged: controller.onChangeCaloryType,
                        ),
                      ),
                    ],
                    SizedBox(height: 12),
                    CustomTextFormField(
                      readOnly: true,
                      hintText: DateFormat.yMEd(
                        Get.deviceLocale.toString(),
                      ).format(controller.selectedDateTime),
                      onTap: () {
                        controller.onChangeDateTime(context);
                      },
                      sufficIcon: Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 12),

                    CustomTextFormField(
                      // autofocus: true,
                      controller: controller.teCtl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      sufficIcon:
                          controller.selectedHealthType == null
                              ? null
                              : Text(controller.selectedHealthType!.suffic),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
