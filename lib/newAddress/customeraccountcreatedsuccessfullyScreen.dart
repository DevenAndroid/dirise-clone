
import 'package:dirise/repository/repository.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../widgets/dimension_screen.dart';
import '../iAmHereToSell/securityDetailsScreen.dart';
import '../vendor/dashboard/dashboard_screen.dart';

const String navigationBackUrl = "navigationbackUrlCode/navigationbackUrlCode";
const String failureUrl = "navigationbackUrlCode/navigationbackUrlCode__failureUrl";

class CustomerAccountCreatedSuccessfullyScreen extends StatefulWidget {
  const CustomerAccountCreatedSuccessfullyScreen({
    Key? key,
  }) : super(key: key);
  // final PlanInfoData planInfoData;
  @override
  State<CustomerAccountCreatedSuccessfullyScreen> createState() => _CustomerAccountCreatedSuccessfullyScreenState();
}

class _CustomerAccountCreatedSuccessfullyScreenState extends State<CustomerAccountCreatedSuccessfullyScreen> {
  final Repositories repositories = Repositories();
  ModelPaymentMethods? methods;
  String paymentMethod = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        Get.back();
        Get.back();
        Get.to(() => const VendorDashBoardScreen());
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AddSize.size45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  height: AddSize.size300,
                  width: double.maxFinite,
                  image: const AssetImage('assets/images/newlogoo.png'),
                  fit: BoxFit.contain,
                  opacity: const AlwaysStoppedAnimation(.80),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Customer account created successfully ".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 30, color: const Color(0xff262F33)),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  height: 100,
                  width: double.maxFinite,
                  image: AssetImage('assets/images/thanku.png'),
                  fit: BoxFit.contain,
                  opacity: AlwaysStoppedAnimation(.80),
                ),
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Text(
                "If you are having troubles:-".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff596774)),
              ),
              Text(
                "FAQs".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff262F33)),
              ),
              Text(
                "Customer Support".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff262F33)),
              ),
              Text(
                "Call".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff262F33)),
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(const SecurityDetailsScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      backgroundColor: AppTheme.buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                      textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Continue".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font22),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
