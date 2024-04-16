import 'dart:convert';
import 'dart:io';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/notification_service.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/bank_details/model_bank_list.dart';
import '../../model/customer_profile/model_country_list.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/helper.dart';
import '../../utils/styles.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import 'image_widget.dart';
import 'verify_vendor_otp.dart';

enum PlansType { advertisement, company, personal }

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key, required this.selectedPlan, required this.modelPlansList})
      : super(key: key);
  final PlanInfoData selectedPlan;
  final ModelPlansList modelPlansList;

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  PlanInfoData get planInfo => widget.selectedPlan;
//  final vendorProfileController = Get.put(VendorProfileController());
  final profileController = Get.put(ProfileController());


  final Repositories repositories = Repositories();

  ModelBankList? modelBankList;
  String bankId = "";

  bool get bankLoaded => modelBankList != null && modelBankList!.data != null && modelBankList!.data!.banks != null;
  bool errorResolved = false;
  RxInt bankListValue = 0.obs;

  bool get insideKuwait => selectedCountry == null ? false : selectedCountry!.name.toString() == "Kuwait";

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  Map<String, VendorCategoriesData> allSelectedCategory = {};
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;

  /// Vendor 1 Fields and some are mandatory and present in all.
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController homeAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();

  /// Vendor 2 Fields and rest are from above
  final TextEditingController ceoName = TextEditingController();
  final TextEditingController partnerCount = TextEditingController();
  File paymentReceiptCertificate = File("");
  final GlobalKey paymentReceiptCertificateKey = GlobalKey();

  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ibnNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();

  /// Vendor 3 Fields
  final TextEditingController companyName = TextEditingController();
  final TextEditingController workAddress = TextEditingController();
  final TextEditingController workEmail = TextEditingController();
  final TextEditingController businessNumber = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();

  File memorandumAssociation = File("");
  final GlobalKey memorandumAssociationKey = GlobalKey();
  File commercialLicense = File("");
  final GlobalKey commercialLicenseKey = GlobalKey();
  File signatureApproval = File("");
  final GlobalKey signatureApprovalKey = GlobalKey();
  File ministryCommerce = File("");
  final GlobalKey ministryCommerceKey = GlobalKey();
  File originalCivilInformation = File("");
  final GlobalKey originalCivilInformationKey = GlobalKey();
  File companyBankAccount = File("");
  final GlobalKey companyBankAccountKey = GlobalKey();

  PlansType selectedPlan = PlansType.personal;

  Future getBankList() async {
    await repositories.getApi(url: ApiUrls.bankListUrl).then((value) {
      modelBankList = ModelBankList.fromJson(jsonDecode(value));
      bankListValue.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  void vendorRegistration() {
    if (showValidation.value == false) {
      showValidation.value = true;
      setState(() {});
    }

    /// Validations
    if (!_formKey.currentState!.validate()) {
      if (allSelectedCategory.isEmpty) {
        categoryKey.currentContext!.navigate;
      }
      if (selectedCountry == null) {
        categoryKey.currentContext!.navigate;
        return;
      }
      if (selectedPlan == PlansType.advertisement) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
        // Optional
        // Optional
        // Optional
      }
      if (selectedPlan == PlansType.personal) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
       /* if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (ceoName.checkEmpty) return;
        // Email
        if (partnerCount.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Phone Number
        if (emailAddress.checkBothWithEmail) return;
        // accountNumber
        if (bankId.isEmpty) {
          accountNumber.getKey.currentContext!.navigate;
          return;
        }
        // accountNumber
        if (accountNumber.checkEmpty) return;
        // ibnNumber
        if (ibnNumber.checkEmpty) return;
        // accountHolderName
        if (accountHolderName.checkEmpty) return;*/
      }
      if (selectedPlan == PlansType.company) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
       /* if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Company Name
        if (companyName.checkEmpty) return;
        // Work Adress
        if (workAddress.checkEmpty) return;
        // Business number
        if (businessNumber.checkEmpty) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
        // Work Email
        if (workEmail.checkBothWithEmail) return;
        // accountNumber
        if (bankId.isEmpty) {
          accountNumber.getKey.currentContext!.navigate;
          return;
        }
        // accountNumber
        if (accountNumber.checkEmpty) return;
        // ibnNumber
        if (ibnNumber.checkEmpty) return;
        // accountHolderName
        if (accountHolderName.checkEmpty) return;*/
      }
      return;
    }
    if (selectedPlan == PlansType.personal) {
      // Payment receipt certificate
   /*   if (paymentReceiptCertificate.path.isEmpty) {
        showToast("Please Select Payment Receipt Certificate");
        paymentReceiptCertificateKey.currentContext!.navigate;
        return;
      }*/
    }
    /*if (selectedPlan == PlansType.company) {
      // Memorandum of Association
      if (memorandumAssociation.path.isEmpty) {
        showToast("Please Select Memorandum of Association");
        memorandumAssociationKey.currentContext!.navigate;
        return;
      }

      // Commercial license
      if (commercialLicense.path.isEmpty) {
        showToast("Please Select Commercial license");
        commercialLicenseKey.currentContext!.navigate;
        return;
      }

      // Signature approval
      if (signatureApproval.path.isEmpty) {
        showToast("Please Select Signature approval");
        signatureApprovalKey.currentContext!.navigate;
        return;
      }

      // Extract from the Ministry of Commerce
      if (ministryCommerce.path.isEmpty) {
        showToast("Please Select Extract from the Ministry of Commerce");
        ministryCommerceKey.currentContext!.navigate;
        return;
      }

      // Original civil information
      if (originalCivilInformation.path.isEmpty) {
        showToast("Please Select Original civil information");
        originalCivilInformationKey.currentContext!.navigate;
        return;
      }

      // Company bank account
      if (companyBankAccount.path.isEmpty) {
        showToast("Please Select Company bank account");
        companyBankAccountKey.currentContext!.navigate;
        return;
      }
    }*/

    /// Map Data
    /*{
  'first_name': 'karan',
  'last_name': 'Junwal',
  'email': 'karanjunwal143@yopmail.com',
  'phone': '8599612592',
  'password': '12345678',
  'store_name': 'halak',
  'store_url': 'www.abc.com',
  'category_id': '3',
  'store_address': 'Jaipur',
  'store_business_id': '1',
  'store_about_us': 'checking out',
  'store_about_me': 'damn serious',
  'vendor_type': 'company',
  'owner_name': 'Rishi',
  'ceo_name': 'dsfsdfs',
  'home_address': 'Amer Road',
  'partners': '6',
  'company_name': 'webluci',
  'work_email': 'luci@yopmail.com',
  'tax_number': '',
  'label1': 'optional',
  'label2': 'optional',
  'label3': 'optional',
  'work_address': 'adfadfda'
}*/

    Map<String, String> map = {};
    if (selectedPlan == PlansType.advertisement) {
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
      };
    }
    if (selectedPlan == PlansType.personal) {
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
        /*'partners': partnerCount.text.trim(),
        'first_name': firstName.text.trim(),
        'ceo_name': ceoName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
        'account_number': accountNumber.text.trim(),
        'ibn_number': ibnNumber.text.trim(),
        'account_holder_name': accountHolderName.text.trim(),
        'bank_name': bankId,*/
      };
    }
    if (selectedPlan == PlansType.company) {
      // Business number
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
        /*'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'store_name': storeName.text.trim(),
        'company_name': companyName.text.trim(),
        'work_address': workAddress.text.trim(),
        'work_email': workEmail.text.trim(),
        'business_number': businessNumber.text.trim(),
        'account_number': accountNumber.text.trim(),
        'ibn_number': ibnNumber.text.trim(),
        'account_holder_name': accountHolderName.text.trim(),
        'bank_name': bankId,
        'tax_number': taxNumber.text.trim(),*/
      };
    }

    map["vendor_type"] = selectedPlan.name;
    map["country_id"] = selectedCountry!.id.toString();
    map["category_id"] = allSelectedCategory.entries.map((e) => e.key).toList().join(",");

    /// Files upload map
    Map<String, File> images = {};

    if (selectedPlan == PlansType.personal) {
      images["payment_certificate"] = paymentReceiptCertificate;
    }

    if (selectedPlan == PlansType.company) {
      // Memorandum of Association ✅
      // Commercial license ✅
      // Signature approval ✅
      // Extract from the Ministry of Commerce ✅
      // Original civil information ✅
      // Company bank account ✅

      images["memorandum_of_association"] = memorandumAssociation;
      images["commercial_license"] = commercialLicense;
      images["signature_approval"] = signatureApproval;
      images["ministy_of_commerce"] = ministryCommerce;
      images["original_civil_information"] = originalCivilInformation;
      images["company_bank_account"] = companyBankAccount;
    }
    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.vendorRegistrationUrl,
            onProgress: (int bytes, int totalBytes) {
              NotificationService().showNotificationWithProgress(
                  title: "Uploading Documents",
                  body: "Uploading Documents are in progress",
                  payload: "payload",
                  maxProgress: 100,
                  progress: ((bytes / totalBytes) * 100).toInt(),
                  progressId: 770);
            })
        .then((value) {
      NotificationService().hideAllNotifications();
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true && response.otp != null) {
        Get.to(() => const VendorOTPVerification(), arguments: [emailAddress.text.trim(), planInfo]);
      }
    }).catchError((e) {
      NotificationService().hideAllNotifications();
    });
  }

  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
      throw Exception(e);
    });
  }

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }


  showAddressSelectorDialog({
    required List<CommonAddressRelatedClass> addressList,
    required String selectedAddressId,
    required Function(String selectedId) selectedAddressIdPicked,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    final TextEditingController searchController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(18),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StatefulBuilder(builder: (context, newState) {
                String gg = searchController.text.trim().toLowerCase();
                List<CommonAddressRelatedClass> filteredList =
                addressList.where((element) => element.title.toString().toLowerCase().contains(gg)).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: searchController,
                      onChanged: (gg) {
                        newState(() {});
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          suffixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                    ),
                    Flexible(
                        child: ListView.builder(
                            itemCount: filteredList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                // dense: true,
                                onTap: () {
                                  selectedAddressIdPicked(filteredList[index].addressId);
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Get.back();
                                },
                                leading: filteredList[index].flagUrl != null
                                    ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: filteredList[index].flagUrl.toString().contains("svg")
                                        ? SvgPicture.network(
                                      filteredList[index].flagUrl.toString(),
                                    )
                                        : Image.network(
                                      filteredList[index].flagUrl.toString(),
                                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                    ))
                                    : null,
                                visualDensity: VisualDensity.compact,
                                title: Text(filteredList[index].title),
                                trailing: selectedAddressId == filteredList[index].addressId
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.purple,
                                )
                                    : Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.grey.shade800,
                                ),
                              );
                            }))
                  ],
                );
              }),
            ),
          );
        });
  }

  ModelCountryList? modelCountryList;
  Country? selectedCountry;

  getCountryList() {
    if(modelCountryList != null)return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
    });
  }

  @override
  void initState() {
    super.initState();

    getBankList();
    selectedPlan = PlansType.values.firstWhere(
        (element) => element.name.toLowerCase() == widget.selectedPlan.businessType.toString(),
        orElse: () => PlansType.personal);
    // vendorType= getVendorType;
    // storeType = widget.selectedPlan.businessType.toString();
    getVendorCategories();
    getCountryList();
    profileController.getDataProfile();
    print('emnialllll eddressssss------'+ profileController.model.user!.email.toString());
    emailAddress.text = profileController.model.user!.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar:  CommonAppBar(
        titleText: "Vendor Registration".tr,
      ),
      body:  SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8),
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: AddSize.padding20),
              child: Column(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    planCard(),
                    14.spaceY,
                    Obx(() {
                      if (kDebugMode) {
                        print(modelVendorCategory.usphone!
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                            .toList());
                      }
                      return DropdownButtonFormField<VendorCategoriesData>(
                        key: categoryKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        icon: vendorCategoryStatus.value.isLoading
                            ? const CupertinoActivityIndicator()
                            : vendorCategoryStatus.value.isError
                                ? IconButton(
                                    onPressed: () => getVendorCategories(),
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.black,
                                    ))
                                : const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        iconDisabledColor: const Color(0xff97949A),
                        iconEnabledColor: const Color(0xff97949A),
                        value: null,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Color(0xffE2E2E2))),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                        items: modelVendorCategory.usphone!
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                            .toList(),
                        hint:  Text('Category'.tr),
                        onChanged: (value) {
                          // selectedCategory = value;
                          if (value == null) return;
                          if(allSelectedCategory.isNotEmpty)return;
                          allSelectedCategory[value.id.toString()] = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (allSelectedCategory.isEmpty) {
                            return "Please select Category".tr;
                          }
                          return null;
                        },
                      );
                    }),
                    if (allSelectedCategory.entries.isNotEmpty) ...[
                      14.spaceY,
                      StatefulBuilder(
                        builder: (context, newState) {
                          return Wrap(
                            runSpacing: 0,
                            spacing: 8,
                            children: allSelectedCategory.entries
                                .map((e) => Chip(
                                    label: Text(e.value.name.toString().capitalize!),
                                    labelPadding: const EdgeInsets.only(right: 4, left: 2),
                                    onDeleted: () {
                                      allSelectedCategory.remove(e.key);
                                      newState(() {});
                                    }))
                                .toList(),
                          );
                        }
                      ),
                    ],
                    14.spaceY,
                    // Country Picker
                    VendorCommonTextfield(
                        controller: TextEditingController(text: selectedCountry != null ? selectedCountry!.name : ""),
                        // key: firstName.getKey,
                        hintText: "Select Country".tr,
                        // prefix: selectedCountry != null
                        //     ? SizedBox(
                        //   width: 50,
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       NewHelper.countryCodeToEmoji(selectedCountry!.countryCode),
                        //       style: titleStyle,
                        //     ),
                        //   ),
                        // )
                        //     : null,
                        readOnly: true,
                        onTap: () {
                          showAddressSelectorDialog(
                              addressList: modelCountryList!.country!
                                  .map((e) => CommonAddressRelatedClass(
                                  title: e.name.toString(), addressId: e.id.toString(), flagUrl: e.icon.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                selectedCountry = modelCountryList!.country!
                                    .firstWhere((element) => element.id.toString() == gg);
                                setState(() {});
                              },
                              selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                        },
                        validator: (value) {
                          if (selectedCountry == null) {
                            return "Please select Country".tr;
                          }
                          return null;
                        }),

                    if (selectedPlan == PlansType.advertisement) ...[
                      14.spaceY,
                      // First Name
                      VendorCommonTextfield(
                          controller: firstName,
                          key: firstName.getKey,
                          hintText: "First Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Last Name
                      VendorCommonTextfield(
                          controller: lastName,
                          key: lastName.getKey,
                          hintText: "Last Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter last name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Store Name
                      VendorCommonTextfield(
                          controller: storeName,
                          key: storeName.getKey,
                          hintText: "Store Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Home Address
                      VendorCommonTextfield(
                          controller: homeAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: homeAddress.getKey,
                          hintText: "Address".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      //Phone Number
                      VendorCommonTextfield(
                          controller: phoneNumber,
                          key: phoneNumber.getKey,
                          hintText: "Phone Number".tr,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store phone number".tr;
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid store phone number".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Email Address
                      VendorCommonTextfield(
                          controller: emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          key: emailAddress.getKey,
                          hintText: 'Email Address'.tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address".tr;
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address".tr;
                            }
                            return null;
                          }),
                    ],
                    if (selectedPlan == PlansType.personal) ...[
                      14.spaceY,
                      // First Name
                      VendorCommonTextfield(
                          controller: firstName,
                          key: firstName.getKey,
                          hintText: "First Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Last Name
                      VendorCommonTextfield(
                          controller: lastName,
                          key: lastName.getKey,
                          hintText: "Last Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter last name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Store Name
                      VendorCommonTextfield(
                          controller: storeName,
                          key: storeName.getKey,
                          hintText: "Store Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Home Address
                      VendorCommonTextfield(
                          controller: homeAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: homeAddress.getKey,
                          hintText: "Address".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      //Phone Number
                      VendorCommonTextfield(
                          controller: phoneNumber,
                          key: phoneNumber.getKey,
                          hintText: "Phone Number".tr,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store phone number".tr;
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid store phone number".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Email Address
                      VendorCommonTextfield(
                          controller: emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          key: emailAddress.getKey,
                          hintText: "Email Address".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address".tr;
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address".tr;
                            }
                            return null;
                          }),
                      /*VendorCommonTextfield(
                          controller: firstName,
                          key: firstName.getKey,
                          hintText: "First Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Last Name
                      VendorCommonTextfield(
                          controller: lastName,
                          key: lastName.getKey,
                          hintText: "Last Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter last name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Store Name
                      VendorCommonTextfield(
                          controller: storeName,
                          key: storeName.getKey,
                          hintText: "Store Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Ceo Name
                      VendorCommonTextfield(
                          controller: ceoName,
                          keyboardType: TextInputType.name,
                          key: ceoName.getKey,
                          hintText: "Ceo Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter ceo name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      //#Partners
                      VendorCommonTextfield(
                          controller: partnerCount,
                          keyboardType: TextInputType.number,
                          key: partnerCount.getKey,
                          hintText: "#Partners",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter you partners";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Home Address
                      VendorCommonTextfield(
                          controller: homeAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: homeAddress.getKey,
                          hintText: "Address",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address";
                            }
                            return null;
                          }),
                      14.spaceY,
                      //Phone Number
                      VendorCommonTextfield(
                          controller: phoneNumber,
                          key: phoneNumber.getKey,
                          hintText: "Phone Number",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store phone number";
                            }
                            if (value.trim().length < 10) {
                              return "Please enter valid store phone number";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Email Address
                      VendorCommonTextfield(
                          controller: emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          key: emailAddress.getKey,
                          hintText: "Email Address",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address";
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),
                      ...bankDetails(),
                      ImageWidget(
                        key: paymentReceiptCertificateKey,
                        title: "Payment Receipt Certificate",
                        file: paymentReceiptCertificate,
                        validation: checkValidation(showValidation.value, paymentReceiptCertificate.path.isEmpty),
                        filePicked: (File g) {
                          paymentReceiptCertificate = g;
                        },
                      ),*/
                    ],
                    if (selectedPlan == PlansType.company) ...[
                      14.spaceY,
                     /* // First Name
                      VendorCommonTextfield(
                          controller: firstName,
                          key: firstName.getKey,
                          hintText: "First Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Last Name
                      VendorCommonTextfield(
                          controller: lastName,
                          key: lastName.getKey,
                          hintText: "Last Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter last name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Store Name
                      VendorCommonTextfield(
                          controller: storeName,
                          key: storeName.getKey,
                          hintText: "Store Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Company Name
                      VendorCommonTextfield(
                          controller: companyName,
                          keyboardType: TextInputType.name,
                          key: companyName.getKey,
                          hintText: "Company Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter company name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Work Address
                      VendorCommonTextfield(
                          controller: workAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: workAddress.getKey,
                          hintText: "Work Address",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter work address";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Business Number
                      VendorCommonTextfield(
                          controller: businessNumber,
                          key: businessNumber.getKey,
                          keyboardType: TextInputType.number,
                          hintText: "Business Number",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter business number";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Email Address
                      VendorCommonTextfield(
                          controller: emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          key: emailAddress.getKey,
                          hintText: "Email Address",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address";
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Work Email
                      VendorCommonTextfield(
                          controller: workEmail,
                          keyboardType: TextInputType.emailAddress,
                          key: workEmail.getKey,
                          hintText: "Work Email",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter work email";
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Work Email
                      VendorCommonTextfield(
                          controller: taxNumber,
                          key: taxNumber.getKey,
                          keyboardType: TextInputType.number,
                          hintText: "Tax number* (outside Kuwait)",
                          validator: (value) {
                            if(selectedCountry == null)return null;
                            if(!insideKuwait && value!.trim().isEmpty){
                              return "Please enter Tax number, you are outside of Kuwait";
                            }
                            return null;
                          }),
                      ...bankDetails(),
                      // memorandumAssociation
                      // commercialLicense
                      // signatureApproval
                      // ministryCommerce
                      // originalCivilInformation
                      // companyBankAccount
                      ImageWidget(
                        key: memorandumAssociationKey,
                        title: "Memorandum of Association",
                        file: memorandumAssociation,
                        validation: checkValidation(showValidation.value, memorandumAssociation.path.isEmpty),
                        filePicked: (File g) {
                          memorandumAssociation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Commercial license",
                        file: commercialLicense,
                        key: commercialLicenseKey,
                        validation: checkValidation(showValidation.value, commercialLicense.path.isEmpty),
                        filePicked: (File g) {
                          commercialLicense = g;
                        },
                      ),
                      ImageWidget(
                        title: "Signature approval",
                        file: signatureApproval,
                        key: signatureApprovalKey,
                        validation: checkValidation(showValidation.value, signatureApproval.path.isEmpty),
                        filePicked: (File g) {
                          signatureApproval = g;
                        },
                      ),
                      ImageWidget(
                        title: "Extract from the Ministry of Commerce",
                        file: ministryCommerce,
                        key: ministryCommerceKey,
                        validation: checkValidation(showValidation.value, ministryCommerce.path.isEmpty),
                        filePicked: (File g) {
                          ministryCommerce = g;
                        },
                      ),
                      ImageWidget(
                        title: "Original civil information",
                        file: originalCivilInformation,
                        key: originalCivilInformationKey,
                        validation: checkValidation(showValidation.value, originalCivilInformation.path.isEmpty),
                        filePicked: (File g) {
                          originalCivilInformation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Company bank account",
                        file: companyBankAccount,
                        key: companyBankAccountKey,
                        validation: checkValidation(showValidation.value, companyBankAccount.path.isEmpty),
                        filePicked: (File g) {
                          companyBankAccount = g;
                        },
                      ),*/
                      VendorCommonTextfield(
                          controller: firstName,
                          key: firstName.getKey,
                          hintText: "First Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Last Name
                      VendorCommonTextfield(
                          controller: lastName,
                          key: lastName.getKey,
                          hintText: "Last Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter last name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Store Name
                      VendorCommonTextfield(
                          controller: storeName,
                          key: storeName.getKey,
                          hintText: "Store Name".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store name".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Home Address
                      VendorCommonTextfield(
                          controller: homeAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: homeAddress.getKey,
                          hintText: "Address".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      //Phone Number
                      VendorCommonTextfield(
                          controller: phoneNumber,
                          key: phoneNumber.getKey,
                          hintText: "Phone Number".tr,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter store phone number".tr;
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid store phone number".tr;
                            }
                            return null;
                          }),
                      14.spaceY,
                      // Email Address
                      VendorCommonTextfield(
                          controller: emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          key: emailAddress.getKey,
                          hintText: "Email Address".tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address".tr;
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address".tr;
                            }
                            return null;
                          }),
                    ],
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          vendorRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            backgroundColor: AppTheme.buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                            textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                        child: Text(
                          "Submit".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                        )),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card planCard() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              planInfo.businessType.toString().capitalize!,
              style: titleStyle.copyWith(fontSize: 18),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      planInfo.title.toString().capitalize!,
                      style: titleStyle,
                    )),
                    Text(planInfo.amount.toString()),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Validity".tr,
                      style: titleStyle,
                    )),
                    Text("${planInfo.label}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  resolveError() {
    if (bankId.isEmpty) return;
    if (bankLoaded) {
      int temp = modelBankList!.data!.banks!.indexWhere((element) => element.id.toString() == bankId);
      if (temp == -1) {
        bankId = "";
      }

    }
  }

  List<Widget> bankDetails() {
    return [
      14.spaceY,
      //Bank List
      insideKuwait ?
      Obx(() {
        if (bankListValue.value > 0) {}
        resolveError();
        return DropdownButtonFormField<String?>(
          isExpanded: true,
          value: bankLoaded
              ? bankId.isNotEmpty
                  ? bankId
                  : null
              : null,
          style: const TextStyle(color: Colors.red),
          decoration: InputDecoration(
            hintText: "Please select bank".tr,
            labelText: "Please select bank".tr,
            filled: true,
            fillColor: const Color(0xffE2E2E2).withOpacity(.35),
            labelStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(15),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppTheme.secondaryColor)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppTheme.secondaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppTheme.secondaryColor)),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppTheme.secondaryColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppTheme.secondaryColor),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: bankLoaded
              ? modelBankList!.data!.banks!
                  .map((e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(
                          e.name.toString(),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ))
                  .toList()
              : [],
          validator: (value) {
            if (bankId.isEmpty) {
              return "Please select bank".tr;
            }
            return null;
          },
          onChanged: (newValue) {
            if (newValue == null) return;
            bankId = newValue;
            setState(() {});
          },
        );
      }) :
      VendorCommonTextfield(
          controller: TextEditingController(text: bankId),
          hintText: "Bank Name".tr,
          onChanged: (value){
            bankId = value;
          },
          validator: (value) {
            if (bankId.trim().isEmpty) {
              return "Please enter bank name".tr;
            }
            return null;
          }),
      14.spaceY,
      //accountNumber
      VendorCommonTextfield(
          controller: accountNumber,
          key: accountNumber.getKey,
          keyboardType: TextInputType.number,
          hintText: "Account Number".tr,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter account number".tr;
            }
            return null;
          }),
      14.spaceY,
      //ibnNumber
      VendorCommonTextfield(
          controller: ibnNumber,
          keyboardType: TextInputType.number,
          key: ibnNumber.getKey,
          hintText: "IBM Number".tr,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter IBM number".tr;
            }
            return null;
          }),
      14.spaceY,
      //accountHolderName
      VendorCommonTextfield(
          controller: accountHolderName,
          key: accountHolderName.getKey,
          hintText: "Account Holder Name".tr,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter account holder name".tr;
            }
            return null;
          }),
    ];
  }
}
