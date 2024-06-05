import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ServiceController extends GetxController {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController fixedPriceAfterSaleController = TextEditingController();

  //tell uss
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  TextEditingController stockAlertController = TextEditingController();
  TextEditingController writeTagsController = TextEditingController();

  //return policy
  TextEditingController titleController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //international shipping
  TextEditingController weightController = TextEditingController();
  TextEditingController dimensionController = TextEditingController();
  TextEditingController dimensionWidthController = TextEditingController();
  TextEditingController dimensionHeightController = TextEditingController();

  //optional Des
  final TextEditingController metaTitleController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController productNumberController = TextEditingController();

  //optional collection
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController promotionCodeController = TextEditingController();
  final TextEditingController longDescription1Controller = TextEditingController();
  final TextEditingController packageDetailsController = TextEditingController();

  //optional classs
  final TextEditingController serialNumber1Controller = TextEditingController();
  final TextEditingController productNumber1Controller = TextEditingController();
  final TextEditingController productCode1Controller = TextEditingController();
  final TextEditingController promotionCode1Controller = TextEditingController();
  final TextEditingController packageDetails1Controller = TextEditingController();

  //location class
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController specialInstructionController = TextEditingController();


  final TextEditingController firstNameController= TextEditingController();
  final TextEditingController lastNameController= TextEditingController();
  final TextEditingController phoneController= TextEditingController();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController alternatePhoneController= TextEditingController();
  final TextEditingController addressController= TextEditingController();
  final TextEditingController address2Controller= TextEditingController();
  final TextEditingController zipCodeController= TextEditingController();
  final TextEditingController landmarkController= TextEditingController();
  final TextEditingController titleController1= TextEditingController();
  TextEditingController countryController1 = TextEditingController();
  TextEditingController stateController1 = TextEditingController();
  TextEditingController cityController1 = TextEditingController();
}
