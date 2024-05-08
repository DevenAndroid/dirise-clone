import 'package:dirise/screens/my_account_screens/about_us_screen.dart';
import 'package:dirise/bottomavbar.dart';
import 'package:dirise/screens/my_account_screens/editprofile_screen.dart';
import 'package:dirise/screens/auth_screens/forgetpass_screen.dart';
import 'package:dirise/screens/auth_screens/newpasswordscreen.dart';
import 'package:dirise/screens/my_account_screens/profile_screen.dart';
import 'package:dirise/screens/my_account_screens/return_policy_screen.dart';
import 'package:dirise/screens/my_account_screens/termsconditions_screen.dart';
import 'package:get/get.dart';

import '../Services/choose_map_service.dart';
import '../Services/locationwherecustomerwilljoin.dart';
import '../Services/pick_up_address_service.dart';
import '../Services/servicesReturnPolicyScreen.dart';
import '../Services/tellUsscreen.dart';
import '../Services/whatServiceDoYouProvide.dart';

import '../addNewProduct/pickUpAddressScreen.dart';
import '../model/model_cart_response.dart';
import '../model/vendor_models/model_return_policy.dart';
import '../newAuthScreens/newOtpScreen.dart';
import '../newAuthScreens/signupScreen.dart';
import '../personalizeyourstore/returnpolicyScreen.dart';
import '../posts/posts_ui.dart';
import '../screens/auth_screens/createacc_screen.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../screens/calender.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/check_out/add_bag_screen.dart';
import '../screens/check_out/address/add_address.dart';
import '../screens/check_out/address/edit_address_screen.dart';
import '../screens/check_out/check_out_screen.dart';
import '../screens/check_out/direct_check_out.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../screens/my_account_screens/faqs_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/order_screens/my_orders_screen.dart';
import '../screens/my_account_screens/privacy_policy_screen.dart';
import '../screens/public_speaker_screen/publicspeaker_screen.dart';
import '../screens/public_speaker_screen/single_public_speaker_screen.dart';
import '../screens/return_policy.dart';
import '../screens/school_nursery_category.dart';
import '../screens/order_screens/selectd_order_screen.dart';
import '../screens/vendorinformation_screen.dart';
import '../screens/virtual_assets/virtual_assets_screen.dart';
import '../vendor/authentication/verify_vendor_otp.dart';
import '../vendor/dashboard/dashboard_screen.dart';
import '../vendor/dashboard/store_open_time_screen.dart';
import '../vendor/orders/vendor_order_list_screen.dart';
import '../vendor/payment_info/bank_account_screen.dart';
import '../vendor/payment_info/withdrawal_screen.dart';
import '../vendor/products/add_product/add_product_screen.dart';
import '../vendor/products/all_product_screen.dart';
import '../vendor/profile/vendor_profile_screen.dart';
import '../vendor/shipping_policy.dart';

class MyRouters {
  static var route = [


    GetPage(name: '/', page: () => const BottomNavbar()),


    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: VendorOTPVerification.route, page: () => const VendorOTPVerification()),
    GetPage(name: CreateAccountNewScreen.route, page: () => const CreateAccountNewScreen()),
    GetPage(name: ForgetPasswordScreen.route, page: () => const ForgetPasswordScreen()),
    GetPage(name: BottomNavbar.route, page: () => const BottomNavbar()),
    GetPage(name: PrivacyPolicy.route, page: () => const PrivacyPolicy()),
    GetPage(name: ProfileScreen.route, page: () => const ProfileScreen()),
    GetPage(name: OtpScreen.route, page: () => const NewOtpScreen()),
    GetPage(name: FrequentlyAskedQuestionsScreen.route, page: () => const FrequentlyAskedQuestionsScreen()),
    GetPage(name: VendorOrderList.route, page: () => const VendorOrderList()),
    GetPage(name: VendorProductScreen.route, page: () => const VendorProductScreen()),
    GetPage(name: AboutUsScreen.route, page: () => const AboutUsScreen()),
    GetPage(name: PublicSpeakerCategoryScreen.route, page: () => const PublicSpeakerCategoryScreen()),
    GetPage(name: BankDetailsScreen.route, page: () => const BankDetailsScreen()),
    GetPage(name: ReturnPolicyScreen.route, page: () => const ReturnPolicyScreen()),
    GetPage(name: PublicSpeakerScreen.route, page: () => const PublicSpeakerScreen()),
    GetPage(name: EditProfileScreen.route, page: () => const EditProfileScreen()),
    // GetPage(name: AddProductScreen.route, page: () => const AddProductScreen()),
    GetPage(name: NewPasswordScreen.route, page: () => const NewPasswordScreen()),
    GetPage(name: TermConditionScreen.route, page: () => const TermConditionScreen()),
    GetPage(name: EventCalendarScreen.route, page: () => const EventCalendarScreen()),
    GetPage(name: PublishPostScreen.route, page: () => const PublishPostScreen()),
    GetPage(name: VirtualAssetsScreen.route, page: () => const VirtualAssetsScreen()),
    GetPage(name: WithdrawMoney.route, page: () => const WithdrawMoney()),
    GetPage(name: VendorDashBoardScreen.route, page: () => const VendorDashBoardScreen()),
    GetPage(name: SchoolNurseryCategory.route, page: () => const SchoolNurseryCategory()),
    GetPage(name: SetTimeScreen.route, page: () => const SetTimeScreen()),
    GetPage(name: CategoriesScreen.route, page: () => const CategoriesScreen()),
    GetPage(name: BagsScreen.route, page: () => const BagsScreen()),
    GetPage(name: CheckOutScreen.route, page: () => const CheckOutScreen()),
    GetPage(name: OrderCompleteScreen.route, page: () => const OrderCompleteScreen()),
    GetPage(name: MyOrdersScreen.route, page: () => const MyOrdersScreen()),
    GetPage(name: SelectedOrderScreen.route, page: () => const SelectedOrderScreen()),
    GetPage(name: DirectCheckOutScreen.route, page: () => const DirectCheckOutScreen()),
    GetPage(name: VendorProfileScreen.route, page: () => const VendorProfileScreen()),
    GetPage(name: AddAddressScreen.route, page: () => const AddAddressScreen()),
    GetPage(name: ShippingPolicyScreen.route, page: () => const ShippingPolicyScreen()),
    GetPage(name: EditAddresss.route, page: () => const EditAddresss()),
    // GetPage(name: ReturnnPolicy.route, page: () => const ReturnnPolicy()),
    GetPage(name: VendorInformation.route, page: () => const VendorInformation()),
    GetPage(name: ChooseAddressService.route, page: () =>  ChooseAddressService()),
    GetPage(name: PickUpAddressService.route, page: () =>  PickUpAddressService()),

  ];
}
