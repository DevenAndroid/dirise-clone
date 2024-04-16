import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/bank_details/model_bank_list.dart';
import '../../model/common_modal.dart';
import '../../model/customer_profile/model_country_list.dart';
import '../../model/model_category_list.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../model/vendor_models/model_vendor_details.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/notification_service.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import '../authentication/image_widget.dart';
import '../authentication/payment_screen.dart';
import '../authentication/thank_you_screen.dart';
import '../authentication/vendor_registration_screen.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key, this.selectedPlan, this.planId});

  final PlansType? selectedPlan;
  final String? planId;
  static String route = "/VendorProfileScreen";

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  String get planId => widget.planId!;

  final vendorProfileController = Get.put(VendorProfileController());

  PlanInfoData get planInfo => PlanInfoData();

  ModelPaymentMethods? methods;
  String paymentMethod = "";

  getPaymentGateWays() {
    if (methods != null) return;
    repositories.getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  getPaymentUrl() {
    if (paymentMethod.isEmpty) {
      showToast("Please select payment method".tr);
      return;
    }
    repositories.postApi(url: ApiUrls.createPaymentUrl, context: context, mapData: {
      'plan_id': planId,
      'callback_url': 'https://diriseapp.com/home/$navigationBackUrl',
      'failure_url': 'https://diriseapp.com/home/$failureUrl',
      'payment_method': paymentMethod,
    }).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.uRL != null) {
        Get.to(() => PaymentScreen(
              paymentUrl: modelCommonResponse.uRL,
            ));
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  final Repositories repositories = Repositories();

  ModelBankList? modelBankList;
  String bankId = "";

  /// Vendor 1 Fields and some are mandatory and present in all.
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController storeUrl = TextEditingController();
  final TextEditingController vendorWallet = TextEditingController();
  final TextEditingController storePhone = TextEditingController();
  final TextEditingController taxNumber2 = TextEditingController();
  final TextEditingController workEmail2 = TextEditingController();
  final TextEditingController additionalNotes = TextEditingController();
  final TextEditingController additionalNotes2 = TextEditingController();
  final TextEditingController storeName2 = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subCategory = TextEditingController();
  final TextEditingController homeAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController description = TextEditingController();

  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ibnNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();

  /// Vendor 2 Fields and rest are from above
  final TextEditingController ceoName = TextEditingController();
  final TextEditingController partnerCount = TextEditingController();
  final TextEditingController partnersName = TextEditingController();
  File paymentReceiptCertificate = File("");
  File idProof = File("");
  File storeBanner = File("");
  File storeLogo = File("");

  final GlobalKey paymentReceiptCertificateKey = GlobalKey();
  final GlobalKey idProofKey = GlobalKey();
  final GlobalKey storeLogoKey = GlobalKey();
  final GlobalKey storeBannerKey = GlobalKey();

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

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  bool valuesLoaded = false;

  VendorUser get vendorInfo => vendorProfileController.model.user!;

  updateControllers() {
    if (valuesLoaded) return;
    if (widget.selectedPlan != null) {
      getPaymentGateWays();
    }
    if (vendorProfileController.model.user == null) return;
    if (widget.selectedPlan == null) {
      selectedPlan = PlansType.values.firstWhere((element) => element.name.toString() == vendorInfo.vendorType.toString(),
          orElse: () => PlansType.personal);
    } else {
      selectedPlan = widget.selectedPlan!;
    }
    firstName.text = vendorInfo.firstName ?? "";
    lastName.text = vendorInfo.lastName ?? "";
    storeName.text = vendorInfo.storeName ?? "";
    homeAddress.text = vendorInfo.address ?? "";
    phoneNumber.text = vendorInfo.phone ?? "";
    emailAddress.text = vendorInfo.email ?? "";
    getCategoryFilter();
    if (vendorInfo.vendorProfile != null) {
      businessNumber.text = vendorInfo.vendorProfile!.businessNumber ?? "";
      homeAddress.text = vendorInfo.vendorProfile!.home_address ?? "";
      storeUrl.text = vendorInfo.storeUrl ?? "";
      vendorWallet.text = (vendorInfo.vendorWallet ?? "").toString();
      additionalNotes.text = vendorInfo.vendorProfile!.label1 ?? "";
      additionalNotes2.text = vendorInfo.vendorProfile!.label2 ?? "";
      partnersName.text = vendorInfo.vendorProfile!.partnersName ?? "";
      storeName2.text = vendorInfo.storeName ?? "";
      storePhone.text = (vendorInfo.storePhone ?? "").toString();
      categoryController.text =
          vendorInfo.venderCategory!.isNotEmpty ? (vendorInfo.venderCategory![0].name ?? "").toString() : "";
      bankId = vendorInfo.vendorProfile!.bankName ?? "";
      accountNumber.text = (vendorInfo.vendorProfile!.accountNumber ?? "").toString();
      ibnNumber.text = vendorInfo.vendorProfile!.ibnNumber ?? "";
      accountHolderName.text = vendorInfo.vendorProfile!.accountHolderName ?? "";
      ceoName.text = (vendorInfo.vendorProfile!.ceoName ?? "").toString();
      partnerCount.text = (vendorInfo.vendorProfile!.partners ?? "").toString();
      paymentReceiptCertificate = File((vendorInfo.vendorProfile!.paymentCertificate ?? "").toString());
      companyName.text = (vendorInfo.vendorProfile!.companyName ?? "").toString();
      workAddress.text = (vendorInfo.vendorProfile!.workAddress ?? "").toString();
      workEmail.text = (vendorInfo.vendorProfile!.workEmail ?? "").toString();
      idProof = File((vendorInfo.vendorProfile!.idProof ?? "").toString());
      storeLogo = File((vendorInfo.storeLogo ?? "").toString());
      storeBanner = File((vendorInfo.bannerProfile ?? "").toString());
      description.text = (vendorInfo.storeBannerDesccription ?? "").toString();
      // businessNumber.text = (vendorInfo.vendorProfile. ?? "").toString();
      taxNumber.text = (vendorInfo.vendorProfile!.taxNumber ?? "").toString();
      memorandumAssociation = File((vendorInfo.vendorProfile!.memorandumOfAssociation ?? "").toString());
      commercialLicense = File((vendorInfo.vendorProfile!.commercialLicense ?? "").toString());
      signatureApproval = File((vendorInfo.vendorProfile!.signatureApproval ?? "").toString());
      ministryCommerce = File((vendorInfo.vendorProfile!.ministyOfCommerce ?? "").toString());
      originalCivilInformation = File((vendorInfo.vendorProfile!.originalCivilInformation ?? "").toString());
      companyBankAccount = File((vendorInfo.vendorProfile!.companyBankAccount ?? "").toString());
    }
    valuesLoaded = true;
  }

  bool get planUpdate => widget.selectedPlan != null;

  void updateProfile() {
    if (showValidation.value == false) {
      showValidation.value = true;
      setState(() {});
    }

    /// Validations
    if (!_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      if (allSelectedCategory.isEmpty) {
        categoryKey.currentContext?.navigate;
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
        if (accountHolderName.checkEmpty) return;
      }
      if (selectedPlan == PlansType.company) {
        // First Name
        if (firstName.checkEmpty) return;
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
        if (accountHolderName.checkEmpty) return;
      }
      return;
    }
    if (selectedPlan == PlansType.advertisement) {
      // Id Proof
      if (idProof.path.isEmpty) {
        showToast("Please Select Id Proof".tr);
        idProofKey.currentContext!.navigate;
        return;
      }
      // Store Logo
      // if (storeLogo.path.isEmpty) {
      //   showToast("Please Select Store Logo");
      //   storeLogoKey.currentContext!.navigate;
      //   return;
      // }

      // Store Banner
      // if (storeBanner.path.isEmpty) {
      //   showToast("Please Select Store Banner");
      //   storeBannerKey.currentContext!.navigate;
      //   return;
      // }
    }
    if (selectedPlan == PlansType.personal) {
      // Payment receipt certificate
      if (paymentReceiptCertificate.path.isEmpty) {
        showToast("Please Select Payment Receipt Certificate".tr);
        paymentReceiptCertificateKey.currentContext!.navigate;
        return;
      }
      // store Logo
      // if (storeLogo.path.isEmpty) {
      //   showToast("Please Select Store Logo");
      //   storeLogoKey.currentContext!.navigate;
      //   return;
      // }
      // // store Banner
      // if (storeBanner.path.isEmpty) {
      //   showToast("Please Select Store Banner");
      //   storeBannerKey.currentContext!.navigate;
      //   return;
      // }
    }
    if (selectedPlan == PlansType.company) {
      // Memorandum of Association
      if (memorandumAssociation.path.isEmpty) {
        showToast("Please Select Memorandum of Association".tr);
        memorandumAssociationKey.currentContext!.navigate;
        return;
      }

      // Commercial license
      if (commercialLicense.path.isEmpty) {
        showToast("Please Select Commercial license".tr);
        commercialLicenseKey.currentContext!.navigate;
        return;
      }

      // Signature approval
      if (signatureApproval.path.isEmpty) {
        showToast("Please Select Signature approval".tr);
        signatureApprovalKey.currentContext!.navigate;
        return;
      }

      // Extract from the Ministry of Commerce
      if (ministryCommerce.path.isEmpty) {
        showToast("Please Select Extract from the Ministry of Commerce".tr);
        ministryCommerceKey.currentContext!.navigate;
        return;
      }

      // Original civil information
      if (originalCivilInformation.path.isEmpty) {
        showToast("Please Select Original civil information".tr);
        originalCivilInformationKey.currentContext!.navigate;
        return;
      }

      // Company bank account
      if (companyBankAccount.path.isEmpty) {
        showToast("Please Select Company bank account".tr);
        companyBankAccountKey.currentContext!.navigate;
        return;
      }

      // Store Logo
      // if (storeLogo.path.isEmpty) {
      //   showToast("Please Select Store Logo");
      //   storeLogoKey.currentContext!.navigate;
      //   return;
      // }
      //
      // // Store Banner
      // if (storeBanner.path.isEmpty) {
      //   showToast("Please Select Store Banner");
      //   storeBannerKey.currentContext!.navigate;
      //   return;
      // }
    }

    if (planUpdate && paymentMethod.isEmpty) {
      showToast("Please select payment method".tr);
      return;
    }

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
        'label1': additionalNotes.text.trim(),
        'store_url': storeUrl.text.trim(),
        'store_banner_desccription': description.text.trim(),
        'label2': additionalNotes2.text.trim(),
      };
    }
    if (selectedPlan == PlansType.personal) {
      // 'account_number': '96969696969696',
      // 'work_address': 'adfadfda',
      // 'business_number': '969',
      // 'ibn_number': 'KOM9696',
      // 'label1': 'optional',
      // 'account_holder_name': '',
      // 'bank_name': ''
      map = {
        'partners': partnerCount.text.trim(),
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
        'bank_name': bankId,
        'partner_name': partnersName.text.trim(),
        'store_url': storeUrl.text.trim(),
        'store_banner_desccription': description.text.trim(),
        'label1': additionalNotes.text.trim(),
        'label2': additionalNotes2.text.trim(),
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
        'company_name': companyName.text.trim(),
        'work_address': workAddress.text.trim(),
        'work_email': workEmail.text.trim(),
        'business_number': businessNumber.text.trim(),
        'account_number': accountNumber.text.trim(),
        'ibn_number': ibnNumber.text.trim(),
        'account_holder_name': accountHolderName.text.trim(),
        'bank_name': bankId,
        'tax_number': taxNumber.text.trim(),
        'store_phone': storePhone.text.trim(),
        'label1': additionalNotes.text.trim(),
        'store_url': storeUrl.text.trim(),
        'store_banner_desccription': description.text.trim(),
        'label2': additionalNotes2.text.trim(),
      };
    }

    map["vendor_type"] = selectedPlan.name;
    map["store_phone"] = storePhone.text.trim();
    if (modelCategoryList != null) {
      map["sub_category_id"] = modelCategoryList!.vendorSubCategory!.map((e) => e.selectedSubChildCategory!.id.toString()).toList().join(",");
    }
    // map["country_id"] = selectedCountry!.id.toString();
    map["category_id"] = allSelectedCategory.entries.map((e) => e.key).toList().join(",");

    /// Files upload map
    Map<String, File> images = {};

    if (selectedPlan == PlansType.advertisement) {
      images["id_proof"] = idProof;
      images["store_logo"] = storeLogo;
      images["banner_profile"] = storeBanner;
    }
    if (selectedPlan == PlansType.personal) {
      images["payment_certificate"] = paymentReceiptCertificate;
      images["store_logo"] = storeLogo;
      images["banner_profile"] = storeBanner;
    }

    if (selectedPlan == PlansType.company) {
      // Memorandum of Association  ✅
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
      images["store_logo"] = storeLogo;
      images["banner_profile"] = storeBanner;
    }
    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.editVendorDetailsUrl,
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
      if (response.status == true) {
        vendorProfileController.getVendorDetails();
        if (!planUpdate) {
          Get.back();
        } else {
          getPaymentUrl();
        }
      }
    }).catchError((e) {
      NotificationService().hideAllNotifications();
    });
  }

  RxInt bankListValue = 0.obs;

  Future getBankList() async {
    await repositories.getApi(url: ApiUrls.bankListUrl, showResponse: false).then((value) {
      modelBankList = ModelBankList.fromJson(jsonDecode(value));
      bankListValue.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  Map<String, VendorCategoriesData> allSelectedCategory = {};

  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl, showResponse: false).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory[element.id.toString()] = VendorCategoriesData.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
      // throw Exception(e);
    });
  }

  @override
  void initState() {
    super.initState();
    getBankList();
    getVendorCategories();
    // getCountryList();
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
  // Country? selectedCountry;

  getCountryList() {
    if (modelCountryList != null) return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
      for (var element in modelCountryList!.country!) {
        log("message....     ${element.id.toString()}      ........      ${vendorInfo.country_id}");
        if (element.id.toString() == (vendorInfo.country_id ?? "")) {
          // selectedCountry = element;
          setState(() {});
          break;
        }
      }
    });
  }

  ModelSingleCategoryList? modelCategoryList;

  bool editable = true;

  Future getCategoryFilter() async {
    if (vendorInfo.venderCategory == null || vendorInfo.venderCategory!.isEmpty) return;
    await repositories
        .getApi(url: ApiUrls.categoryListUrl + vendorInfo.venderCategory![0].id.toString(), showResponse: true)
        .then((value) {
      modelCategoryList = ModelSingleCategoryList.fromJson(jsonDecode(value));
      if (vendorInfo.vendorSub != null && modelCategoryList!.vendorSubCategory!.isNotEmpty) {
        for (var element in modelCategoryList!.vendorSubCategory!) {
          for (var element1 in element.childCategory!) {
            if(vendorInfo.vendorSub!.subCategoryId.toString().split(",").contains(element1.id.toString())){
              element.selectedSubChildCategory = element1;
              print(vendorInfo.vendorSub!.subCategoryId.toString().split(","));
              print(element1.id.toString());
              print(element1.name);
            editable = false;
              break;
            }
          }
            setState(() {});
          // if(vendorInfo.vendorSub!.subCategoryId.toString().split(",").contains(element.id.toString())){
          //
          // }
          // if (vendorInfo.vendorSub!.subCategoryId.toString() == element.id.toString()) {
          //   setState(() {});
          //   break;
          // }
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text('Vendor Profile'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        updateControllers();
        return vendorProfileController.apiLoaded
            ? RefreshIndicator(
                onRefresh: () async {
                  await vendorProfileController.getVendorDetails();
                  await getCategoryFilter();
                },
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    child: Form(
                      key: _formKey,
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(8),
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          child: Column(
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                // planCard(),
                                 Text(
                                  'Required Fields'.tr,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                16.spaceY,
                                /* Obx(() {
                                  return DropdownButtonFormField<String>(
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
                                    value: allSelectedCategory.isEmpty? null : allSelectedCategory.entries.map((e) => e.value).toList().first.id.toString(),
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                                        .map(
                                            (e) => DropdownMenuItem(value: e.id.toString(), child: Text(e.name.toString().capitalize!)))
                                        .toList(),
                                    hint: const Text('Category'),
                                    onChanged: (value) {
                                      // selectedCategory = value;
                                      if (value == null) return;
                                      allSelectedCategory.clear();
                                      allSelectedCategory[value.toString()] = modelVendorCategory.usphone!.firstWhere((element) => element.id.toString() == value.toString());
                                      setState(() {});
                                    },
                                    validator: (value) {
                                      if (allSelectedCategory.isEmpty) {
                                        return "Please select Category";
                                      }
                                      return null;
                                    },
                                  );
                                }),*/
                                VendorCommonTextfield(
                                  controller: categoryController,
                                  //key: firstName.getKey,
                                  hintText: "Category".tr,
                                  enabled: false,
                                  /*validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Please enter category";
                                      }
                                      return null;
                                    }*/
                                ),
                                if(modelCategoryList != null)
                                ...modelCategoryList!.vendorSubCategory!.map((e) => Column(
                                      children: [
                                        16.spaceY,
                                        IgnorePointer(
                                          ignoring: !editable,
                                          child: DropdownButtonFormField<dynamic>(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            iconSize: 30,
                                            iconDisabledColor: const Color(0xff97949A),
                                            iconEnabledColor: const Color(0xff97949A),
                                            value: e.selectedSubChildCategory,
                                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                                            items: e.childCategory
                                                    !.map((e) =>
                                                        DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                                                    .toList(),
                                            hint: Text('${'Select'.tr } ${e.name} ${'Category'.tr}'),
                                            onChanged: (value) {
                                              e.selectedSubChildCategory = value;
                                              setState(() {});
                                            },
                                            validator: (value) {
                                              if (e.selectedSubChildCategory == null) {
                                                return "Please select sub category".tr;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                4.spaceY,
                                /* Wrap(
                                  runSpacing: 0,
                                  spacing: 8,
                                  children: allSelectedCategory.entries
                                      .map((e) => Chip(
                                          label: Text(e.value.name.toString().capitalize!),
                                          labelPadding: const EdgeInsets.only(right: 4, left: 2),
                                          onDeleted: () {
                                            allSelectedCategory.remove(e.key);
                                            setState(() {});
                                          }))
                                      .toList(),
                                ),*/
                                //8.spaceY,
                                /* if (allSelectedCategory.isNotEmpty) 12.spaceY,
                                // // Country Picker
                                VendorCommonTextfield(
                                    controller:
                                        TextEditingController(text: selectedCountry != null ? selectedCountry!.name : ""),
                                    // key: firstName.getKey,
                                    hintText: "Select Country",
                                    // prefix: selectedCountry != null
                                    //     ? SizedBox(
                                    //         width: 50,
                                    //         child: Align(
                                    //           alignment: Alignment.center,
                                    //           child: Text(
                                    //             NewHelper.countryCodeToEmoji(selectedCountry!.countryCode),
                                    //             style: titleStyle,
                                    //           ),
                                    //         ),
                                    //       )
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
                                        return "Please select Country";
                                      }
                                      return null;
                                    }),*/
                                14.spaceY,
                                if (selectedPlan == PlansType.advertisement) ...[
                                  // 14.spaceY,
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
                                  /* 14.spaceY,
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
                                      }),*/
                                  14.spaceY,
                                  // Home Address
                                  VendorCommonTextfield(
                                      controller: homeAddress,
                                      keyboardType: TextInputType.streetAddress,
                                      key: homeAddress.getKey,
                                      hintText: "Home Address".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter home address".tr;
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
                                        if (value.trim().length < 10) {
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                      controller: additionalNotes,
                                      //key: storeName.getKey,
                                      hintText: "Additional Notes".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Additional Notes".tr;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Id Proof".tr,
                                    file: idProof,
                                    validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                                    filePicked: (File g) {
                                      idProof = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                   Text(
                                    'Optional Fields'.tr,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Logo".tr,
                                    file: storeLogo,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeLogo = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Banner".tr,
                                    file: storeBanner,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeBanner = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: description,
                                    //key: storeName.getKey,
                                    hintText: "Description".tr,
                                    /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store name";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: storeName,
                                    //key: storeName.getKey,
                                    hintText: "Store Name".tr,
                                    /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store name";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: storeUrl,
                                    //key: storeName.getKey,
                                    hintText: "Store Url".tr,
                                    /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store Url";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  /* const SizedBox(height: 10,),
                                  VendorCommonTextfield(
                                    controller: taxNumber2,
                                    //key: storeName.getKey,
                                    hintText: "Tax Number",
                                    */ /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Tax Number";
                                        }
                                        return null;
                                      }*/ /*
                                  ),*/
                                  /*  const SizedBox(height: 10,),
                                  VendorCommonTextfield(
                                    controller: workEmail2,
                                    //key: storeName.getKey,
                                    hintText: "Work Email",
                                    */
                                  /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Work Email";
                                        }
                                        return null;
                                      }*/ /*
                                  ),*/
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: additionalNotes2,
                                    //key: storeName.getKey,
                                    hintText: "Additional Notes".tr,
                                    /*  validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Additional Notes";
                                        }
                                        return null;
                                      }*/
                                  ),
                                ],
                                if (selectedPlan == PlansType.personal) ...[
                                  // 14.spaceY,
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
                                  // Ceo Name
                                  VendorCommonTextfield(
                                      controller: ceoName,
                                      keyboardType: TextInputType.name,
                                      key: ceoName.getKey,
                                      hintText: "Ceo Name".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter ceo name".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  //#Partners
                                  VendorCommonTextfield(
                                      controller: partnerCount,
                                      keyboardType: TextInputType.number,
                                      key: partnerCount.getKey,
                                      hintText: "#Partners".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter your partners".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  VendorCommonTextfield(
                                      controller: partnersName,
                                      keyboardType: TextInputType.text,
                                      // key: partnerCount.getKey,
                                      hintText: "Partner's Name".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter your partner's name".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  // Home Address
                                  VendorCommonTextfield(
                                      controller: homeAddress,
                                      keyboardType: TextInputType.streetAddress,
                                      key: homeAddress.getKey,
                                      hintText: "Home Address".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter home address".tr;
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
                                          return "Please enter  phone number".tr;
                                        }
                                        if (value.trim().length < 10) {
                                          return "Please enter valid  phone number".tr;
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
                                  ...bankDetails(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                      controller: additionalNotes,
                                      //key: storeName.getKey,
                                      hintText: "Additional Notes".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter additional notes".tr;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ImageWidget(
                                    key: paymentReceiptCertificateKey,
                                    title: "Payment Receipt Certificate".tr,
                                    file: paymentReceiptCertificate,
                                    validation: checkValidation(showValidation.value, paymentReceiptCertificate.path.isEmpty),
                                    filePicked: (File g) {
                                      paymentReceiptCertificate = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                   Text(
                                    'Optional Fields'.tr,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Logo".tr,
                                    file: storeLogo,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeLogo = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Banner".tr,
                                    file: storeBanner,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeBanner = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: description,
                                    //key: storeName.getKey,
                                    hintText: "Description".tr,
                                    /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store name";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: storeUrl,
                                    //key: storeName.getKey,
                                    hintText: "Store Url".tr,
                                    /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store Url";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  /*  const SizedBox(height: 10,),
                                  VendorCommonTextfield(
                                    controller: taxNumber,
                                    //key: storeName.getKey,
                                    hintText: "Tax Number",
                                    */ /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Tax Number";
                                        }
                                        return null;
                                      }*/ /*
                                  ),*/
                                  /* const SizedBox(height: 10,),
                                  VendorCommonTextfield(
                                    controller: workEmail,
                                    //key: storeName.getKey,
                                    hintText: "Work Email",
                                    */ /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Work Email";
                                        }
                                        return null;
                                      }*/ /*
                                  ),*/
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: additionalNotes2,
                                    //key: storeName.getKey,
                                    hintText: "Additional Notes".tr,
                                    /*  validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Additional Notes";
                                        }
                                        return null;
                                      }*/
                                  ),
                                ],
                                if (selectedPlan == PlansType.company) ...[
                                  // 14.spaceY,
                                  // First Name
                                  /* VendorCommonTextfield(
                                      controller: firstName,
                                      key: firstName.getKey,
                                      hintText: "Company Name",
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter company name";
                                        }
                                        return null;
                                      }),*/
                                  //  14.spaceY,
                                  // Last Name
                                  /*  VendorCommonTextfield(
                                      controller: lastName,
                                      key: lastName.getKey,
                                      hintText: "Last Name",
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter last name";
                                        }
                                        return null;
                                      }),*/
                                  // 14.spaceY,
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
                                  // Company Name
                                  VendorCommonTextfield(
                                      controller: companyName,
                                      keyboardType: TextInputType.name,
                                      key: companyName.getKey,
                                      hintText: "Company Name".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter company name".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  // Work Address
                                  VendorCommonTextfield(
                                      controller: workAddress,
                                      keyboardType: TextInputType.streetAddress,
                                      key: workAddress.getKey,
                                      hintText: "Work Address".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter work address".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  // Business Number
                                  VendorCommonTextfield(
                                      controller: businessNumber,
                                      key: businessNumber.getKey,
                                      keyboardType: TextInputType.number,
                                      hintText: "Business Number".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter business number".tr;
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
                                  14.spaceY,
                                  VendorCommonTextfield(
                                      controller: phoneNumber,
                                      key: phoneNumber.getKey,
                                      hintText: "Phone Number".tr,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter  phone number".tr;
                                        }
                                        if (value.trim().length < 10) {
                                          return "Please enter valid  phone number".tr;
                                        }
                                        return null;
                                      }),
                                  14.spaceY,
                                  // Work Email
                                  /* VendorCommonTextfield(
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
                                      }),*/
                                  // Work Email
                                  /*VendorCommonTextfield(
                                      controller: taxNumber,
                                      key: taxNumber.getKey,
                                      hintText: "Tax number* (outside Kuwait)",
                                      validator: (value) {
                                        if(selectedCountry == null)return null;
                                        if(!insideKuwait && value!.trim().isEmpty){
                                          return "Please enter Tax number, you are outside of Kuwait";
                                        }
                                        return null;
                                      }),*/
                                  // const SizedBox(height: 10,),
                                  VendorCommonTextfield(
                                      controller: storePhone,
                                      //key: storeName.getKey,
                                      hintText: "Store Phone".tr,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store phone".tr;
                                        }
                                        return null;
                                      }),
                                  ...bankDetails(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                      controller: additionalNotes2,
                                      //key: storeName.getKey,
                                      hintText: "Additional Notes".tr,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter additional notes".tr;
                                        }
                                        return null;
                                      }),
                                  // memorandumAssociation
                                  // commercialLicense
                                  // signatureApproval
                                  // ministryCommerce
                                  // originalCivilInformation
                                  // companyBankAccount
                                  ImageWidget(
                                    key: memorandumAssociationKey,
                                    title: "Memorandum of Association".tr,
                                    file: memorandumAssociation,
                                    validation: checkValidation(showValidation.value, memorandumAssociation.path.isEmpty),
                                    filePicked: (File g) {
                                      memorandumAssociation = g;
                                    },
                                  ),
                                  ImageWidget(
                                    title: "Commercial license".tr,
                                    file: commercialLicense,
                                    key: commercialLicenseKey,
                                    validation: checkValidation(showValidation.value, commercialLicense.path.isEmpty),
                                    filePicked: (File g) {
                                      commercialLicense = g;
                                    },
                                  ),
                                  ImageWidget(
                                    title: "Signature approval".tr,
                                    file: signatureApproval,
                                    key: signatureApprovalKey,
                                    validation: checkValidation(showValidation.value, signatureApproval.path.isEmpty),
                                    filePicked: (File g) {
                                      signatureApproval = g;
                                    },
                                  ),
                                  ImageWidget(
                                    title: "Extract from the Ministry of Commerce".tr,
                                    file: ministryCommerce,
                                    key: ministryCommerceKey,
                                    validation: checkValidation(showValidation.value, ministryCommerce.path.isEmpty),
                                    filePicked: (File g) {
                                      ministryCommerce = g;
                                    },
                                  ),
                                  ImageWidget(
                                    title: "Original civil information".tr,
                                    file: originalCivilInformation,
                                    key: originalCivilInformationKey,
                                    validation: checkValidation(showValidation.value, originalCivilInformation.path.isEmpty),
                                    filePicked: (File g) {
                                      originalCivilInformation = g;
                                    },
                                  ),
                                  ImageWidget(
                                    title: "Company bank account".tr,
                                    file: companyBankAccount,
                                    key: companyBankAccountKey,
                                    validation: checkValidation(showValidation.value, companyBankAccount.path.isEmpty),
                                    filePicked: (File g) {
                                      companyBankAccount = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Text(
                                    'Optional Fields'.tr,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Logo".tr,
                                    file: storeLogo,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeLogo = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ImageWidget(
                                    // key: paymentReceiptCertificateKey,
                                    title: "Store Banner".tr,
                                    file: storeBanner,
                                    validation: false,
                                    filePicked: (File g) {
                                      storeBanner = g;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: description,
                                    //key: storeName.getKey,
                                    hintText: "Description".tr,
                                    /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store name";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: storeUrl,
                                    //key: storeName.getKey,
                                    hintText: "Store Url".tr,
                                    /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter store Url";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: taxNumber,
                                    //key: storeName.getKey,
                                    hintText: "Tax Number".tr,
                                    /* validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Tax Number";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: workEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    key: workEmail.getKey,
                                    hintText: "Work Email".tr,
                                    /*  validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter work email";
                                        }
                                        if (value.trim().invalidEmail) {
                                          return "Please enter valid email address";
                                        }
                                        return null;
                                      }*/
                                  ),
                                  //const SizedBox(height: 10,),
                                  /* VendorCommonTextfield(
                                      controller: workEmail2,
                                      //key: storeName.getKey,
                                      hintText: "Work Email",
                                      */ /*validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Work Email";
                                        }
                                        return null;
                                      }*/ /*
                                      ),*/
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  VendorCommonTextfield(
                                    controller: additionalNotes,
                                    //key: storeName.getKey,
                                    hintText: "Additional Notes".tr,
                                    /*  validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please enter Additional Notes";
                                        }
                                        return null;
                                      }*/
                                  ),
                                ],
                                const SizedBox(
                                  height: 10,
                                ),
                                if (methods != null && methods!.data != null)
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                                        ),
                                        enabled: true,
                                        filled: true,
                                        hintText: "Select Payment Method".tr,
                                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                                        labelText: "Select Payment Method".tr,
                                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (paymentMethod.isEmpty) {
                                          return "Please select payment method".tr;
                                        }
                                        return null;
                                      },
                                      isExpanded: true,
                                      items: methods!.data!
                                          .map((e) => DropdownMenuItem(
                                              value: e.paymentMethodId.toString(),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text(e.paymentMethodEn.toString())),
                                                  SizedBox(width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                                                ],
                                              )))
                                          .toList(),
                                      onChanged: (value) {
                                        if (value == null) return;
                                        paymentMethod = value;
                                      }),
                                const SizedBox(
                                  height: 25,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      updateProfile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(double.maxFinite, 60),
                                        backgroundColor: AppTheme.buttonColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                        textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                                    child: Text(
                                      "Submit".tr,
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                                    )),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const LoadingAnimation();
      }),
    );
  }

  bool get bankLoaded => modelBankList != null && modelBankList!.data != null && modelBankList!.data!.banks != null;
  bool errorResolved = false;

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
      // insideKuwait ?
      // Obx(() {
      //   if (bankListValue.value > 0) {}
      //   resolveError();
      //   return DropdownButtonFormField<String?>(
      //     isExpanded: true,
      //     value: bankLoaded
      //         ? bankId.isNotEmpty
      //         ? bankId
      //         : null
      //         : null,
      //     style: const TextStyle(color: Colors.red),
      //     decoration: InputDecoration(
      //       hintText: "Please select bank",
      //       labelText: "Please select bank",
      //       filled: true,
      //       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
      //       labelStyle: GoogleFonts.poppins(
      //         color: Colors.black,
      //         fontSize: 14,
      //       ),
      //       contentPadding: const EdgeInsets.all(15),
      //       focusedErrorBorder: const OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(8)),
      //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
      //       errorBorder: const OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(8)),
      //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
      //       focusedBorder: const OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(8)),
      //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
      //       disabledBorder: const OutlineInputBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         borderSide: BorderSide(color: AppTheme.secondaryColor),
      //       ),
      //       enabledBorder: const OutlineInputBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(8)),
      //         borderSide: BorderSide(color: AppTheme.secondaryColor),
      //       ),
      //     ),
      //     icon: const Icon(Icons.keyboard_arrow_down),
      //     items: bankLoaded
      //         ? modelBankList!.data!.banks!
      //         .map((e) => DropdownMenuItem(
      //       value: e.id.toString(),
      //       child: Text(
      //         e.name.toString(),
      //         style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
      //       ),
      //     ))
      //         .toList()
      //         : [],
      //     validator: (value) {
      //       if (bankId.isEmpty) {
      //         return "Please select bank";
      //       }
      //       return null;
      //     },
      //     onChanged: (newValue) {
      //       if (newValue == null) return;
      //       bankId = newValue;
      //       setState(() {});
      //     },
      //   );
      // }) :
      VendorCommonTextfield(
          controller: TextEditingController(text: bankId),
          hintText: "Bank Name".tr,
          onChanged: (value) {
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
          hintText: "Account Number".tr,
          keyboardType: TextInputType.number,
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
          key: ibnNumber.getKey,
          hintText: "IBAN Number".tr,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter IBAN number".tr;
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
}
