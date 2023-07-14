import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/bank_details_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/country_code.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class BankDetailScreen extends StatefulWidget {
  const BankDetailScreen({Key? key}) : super(key: key);

  @override
  _BankDetailScreenState createState() => _BankDetailScreenState();
}

var choose_country_name = "";
var choose_country_flage = "";
String bank_account_number = "";
String account_holder_name = "";

class _BankDetailScreenState extends State<BankDetailScreen> {
  var controller = Get.put(BankDetailController());

  @override
  void initState() {
    Future.delayed((Duration.zero), () {
      controller.getDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar('', isCentered: true),
        body: GetBuilder<BankDetailController>(builder: (value) {
          return value.loading
              ? AppViews.showLoading()
              : ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style: subHeadingText(size: 25),
                            ),
                            SizedBox(
                              height: ht(30),
                            ),

                            GetBuilder<BankDetailController>(builder: (value) {
                              return customTextFiled(
                                  controller.countryController,
                                  controller.countryNode,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.textColor,
                                    size: 28,
                                  ),
                                  readOnly: true, onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ChooseCountry(
                                          (String name, String code) {
                                        value.changeFlag(name, code);
                                        Get.back();
                                      });
                                    });
                              },
                                  prefix: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          width: 34,
                                          alignment: Alignment.center,
                                          child: Image.network(
                                              "http://www.geonames.org/flags/x/${value.codeC}.gif")),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 1,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 11),
                                        color:
                                            AppColors.colorTextFildBorderColor,
                                        alignment: Alignment.center,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ));
                            }),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiled(
                                controller.bankName, controller.bankNameNode,
                                hint: 'Bank Name', maxLength: 100),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiled(controller.branchCode,
                                controller.branchCodeNode,
                                hint: 'Branch Code', maxLength: 100),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiled(
                              controller.numberController,
                              controller.numberNode,
                              hint: 'Bank Account Number',
                              textInputType: TextInputType.number,

                              maxLength: 50,
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              // icon: Image.asset('assets/images/Mastercard Logo.png')
                            ),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiled(
                                controller.nameController, controller.nameNode,
                                hint: 'Account Holder Name', maxLength: 100),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiledMultiLine(
                                controller.address, controller.addressNode,
                                lines: 3,
                                prefix: Container(
                                    height: 100,
                                    padding: const EdgeInsets.only(top: 24),
                                    alignment: Alignment.topCenter,
                                    width: 30,
                                    child: const Icon(
                                      Icons.location_city,
                                      color: AppColors.sparkblue,
                                    )),
                                hint: 'Address',
                                maxLength: 200),
                            SizedBox(
                              height: ht(21),
                            ),

                            customTextFiled(
                                controller.swift, controller.swiftNode,
                                hint: 'Swift Code', maxLength: 20),

                            /// Swift Code
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: ht(18)),
                      child: CustomButton(
                          label: 'Save',
                          onPress: () {
                            controller.addBank();
                          }),
                    ),
                  ],
                );
        }));
  }
}
