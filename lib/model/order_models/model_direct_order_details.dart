import 'package:get/get.dart';

class ModelDirectOrderResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  ShippingType? shippingType;
  dynamic fedexCommision;
  dynamic icarryCommision;
  RxString fedexShippingOption = "".obs;
  RxString shippingOption = "".obs;
  dynamic total;
  dynamic discount;
  dynamic vendorCountryId;
  ReturnData? returnData;
  ProdcutData? prodcutData;
  bool? localShipping;
  double sPrice = 0.0;
  ModelDirectOrderResponse(
      {this.status,
      this.message,
      this.subtotal,
      this.shipping,
      this.shippingType,
      this.fedexCommision,
      this.icarryCommision,
      this.total,
      this.discount,
      this.vendorCountryId,
      this.returnData,
      this.prodcutData,
      this.localShipping});

  ModelDirectOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    shippingType = json['shipping_type'] != null ? new ShippingType.fromJson(json['shipping_type']) : null;
    fedexCommision = json['fedex_commision'];
    icarryCommision = json['icarry_commision'];
    total = json['total'];
    discount = json['discount'];
    vendorCountryId = json['vendor_country_id'];
    returnData = json['return_data'] != null ? new ReturnData.fromJson(json['return_data']) : null;
    prodcutData = json['prodcut_data'] != null ? new ProdcutData.fromJson(json['prodcut_data']) : null;
    localShipping = json['local_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    if (this.shippingType != null) {
      data['shipping_type'] = this.shippingType!.toJson();
    }
    data['fedex_commision'] = this.fedexCommision;
    data['icarry_commision'] = this.icarryCommision;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['vendor_country_id'] = this.vendorCountryId;
    if (this.returnData != null) {
      data['return_data'] = this.returnData!.toJson();
    }
    if (this.prodcutData != null) {
      data['prodcut_data'] = this.prodcutData!.toJson();
    }
    data['local_shipping'] = this.localShipping;
    return data;
  }
}

class ShippingType {
  List<IcarryShipping>? icarryShipping;
  List<LocalShipping>? localShipping;
  FedexShipping? fedexShipping;
  RxString fedexShippingOption = "".obs;
  ShippingType({this.icarryShipping, this.localShipping, this.fedexShipping});

  ShippingType.fromJson(Map<String, dynamic> json) {
    if (json['icarry_shipping'] != null) {
      icarryShipping = <IcarryShipping>[];
      json['icarry_shipping'].forEach((v) {
        icarryShipping!.add(new IcarryShipping.fromJson(v));
      });
    }
    if (json['local_shipping'] != null) {
      localShipping = <LocalShipping>[];
      json['local_shipping'].forEach((v) {
        localShipping!.add(new LocalShipping.fromJson(v));
      });
    }
    fedexShipping = json['fedex_shipping'] != null ? new FedexShipping.fromJson(json['fedex_shipping']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.icarryShipping != null) {
      data['icarry_shipping'] = this.icarryShipping!.map((v) => v.toJson()).toList();
    }
    if (this.localShipping != null) {
      data['local_shipping'] = this.localShipping!.map((v) => v.toJson()).toList();
    }
    if (this.fedexShipping != null) {
      data['fedex_shipping'] = this.fedexShipping!.toJson();
    }
    return data;
  }
}

class IcarryShipping {
  dynamic name;
  CarrierModel? carrierModel;
  dynamic shippingRateComputationMethodSystemName;
  dynamic methodName;
  dynamic methodId;
  dynamic methodBodyInfo;
  dynamic carrierTransportationTypeId;
  dynamic carrierAdminVehicleTypeId;
  dynamic description;
  dynamic price;
  dynamic cODCurrency;
  dynamic rate;
  Finance? finance;
  dynamic deliveryDateFormat;
  dynamic displayOrder;
  bool? selected;
  WorkingCurrency? workingCurrency;
  List<Null>? customProperties;
  dynamic friendlyPluginName;

  IcarryShipping(
      {this.name,
      this.carrierModel,
      this.shippingRateComputationMethodSystemName,
      this.methodName,
      this.methodId,
      this.methodBodyInfo,
      this.carrierTransportationTypeId,
      this.carrierAdminVehicleTypeId,
      this.description,
      this.price,
      this.cODCurrency,
      this.rate,
      this.finance,
      this.deliveryDateFormat,
      this.displayOrder,
      this.selected,
      this.workingCurrency,
      this.customProperties,
      this.friendlyPluginName});

  IcarryShipping.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    carrierModel = json['CarrierModel'] != null ? new CarrierModel.fromJson(json['CarrierModel']) : null;
    shippingRateComputationMethodSystemName = json['ShippingRateComputationMethodSystemName'];
    methodName = json['MethodName'];
    methodId = json['MethodId'];
    methodBodyInfo = json['MethodBodyInfo'];
    carrierTransportationTypeId = json['CarrierTransportationTypeId'];
    carrierAdminVehicleTypeId = json['CarrierAdminVehicleTypeId'];
    description = json['Description'];
    price = json['Price'];
    cODCurrency = json['CODCurrency'];
    rate = json['Rate'];
    finance = json['Finance'] != null ? new Finance.fromJson(json['Finance']) : null;
    deliveryDateFormat = json['DeliveryDateFormat'];
    displayOrder = json['DisplayOrder'];
    selected = json['Selected'];
    workingCurrency = json['WorkingCurrency'] != null ? new WorkingCurrency.fromJson(json['WorkingCurrency']) : null;
    // if (json['CustomProperties'] != null) {
    //   customProperties = <Null>[];
    //   json['CustomProperties'].forEach((v) {
    //     customProperties!.add(new Null.fromJson(v));
    //   });
    // }
    friendlyPluginName = json['friendlyPluginName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    if (this.carrierModel != null) {
      data['CarrierModel'] = this.carrierModel!.toJson();
    }
    data['ShippingRateComputationMethodSystemName'] = this.shippingRateComputationMethodSystemName;
    data['MethodName'] = this.methodName;
    data['MethodId'] = this.methodId;
    data['MethodBodyInfo'] = this.methodBodyInfo;
    data['CarrierTransportationTypeId'] = this.carrierTransportationTypeId;
    data['CarrierAdminVehicleTypeId'] = this.carrierAdminVehicleTypeId;
    data['Description'] = this.description;
    data['Price'] = this.price;
    data['CODCurrency'] = this.cODCurrency;
    data['Rate'] = this.rate;
    if (this.finance != null) {
      data['Finance'] = this.finance!.toJson();
    }
    data['DeliveryDateFormat'] = this.deliveryDateFormat;
    data['DisplayOrder'] = this.displayOrder;
    data['Selected'] = this.selected;
    if (this.workingCurrency != null) {
      data['WorkingCurrency'] = this.workingCurrency!.toJson();
    }
    // if (this.customProperties != null) {
    //   data['CustomProperties'] =
    //       this.customProperties!.map((v) => v.toJson()).toList();
    // }
    data['friendlyPluginName'] = this.friendlyPluginName;
    return data;
  }
}

class CarrierModel {
  dynamic id;
  bool? editShippigStatus;
  dynamic systemName;
  dynamic staticName;
  dynamic methodName;
  dynamic email;
  dynamic icon;
  dynamic carrierName;
  bool? isActive;
  bool? isOnline;
  bool? returnApplicable;
  bool? publicRate;
  dynamic shippingTripType;
  dynamic limitedToStore;
  List<Null>? shippingTripTypeIds;
  List<Null>? limitedToStoreIds;
  dynamic markUpPercentage;
  dynamic intlMarkUpPercentage;
  dynamic onDemandMarkUpPercentage;
  dynamic onDemandIntlMarkUpPercentage;
  dynamic customMarkUpPercentage;
  dynamic customIntlMarkUpPercentage;
  dynamic domesticDiscountPercentage;
  dynamic internationalDiscountPercentage;
  dynamic onDemandDomesticDiscountPercentage;
  dynamic onDemandInternationalDiscountPercentage;
  dynamic customDomesticDiscountPercentage;
  dynamic customInternationalDiscountPercentage;
  dynamic carrierCODPercentage;
  dynamic intlCODPercentage;
  dynamic carrierCODMinimalCharge;
  dynamic intlCODMinimalCharge;
  dynamic returnUponDeliveryRate;
  dynamic failedDeliveryRate;
  bool? configure;
  dynamic carrierAWBType;
  dynamic configureUrl;
  dynamic displayOrder;
  dynamic transitDays;
  dynamic totalRate;
  dynamic iconUrl;
  dynamic iconId;
  dynamic termsUrl;
  List<Null>? availableShippingTripType;
  List<Null>? availableStores;
  List<Null>? availableCarriersLibraries;
  dynamic vendorId;
  List<Null>? availableVendors;
  List<Null>? availableCountries;
  List<Null>? selectedVendors;
  List<Null>? selectedCountries;
  dynamic primaryStoreCurrencyCode;
  dynamic vatPercentage;
  bool? isICarryCarrier;
  bool? isAvailableForOnDemand;
  bool? isAvailableForAllVendors;
  bool? isCODProvided;
  bool? enableSchedule;
  bool? enableAutoPickupRequest;
  bool? hasRateAPI;
  bool? shippingProviderHasRateAPI;
  dynamic integrationType;
  List<Null>? proofDeliveryIds;
  dynamic gridPageSize;
  List<Null>? availablePageSizes;
  List<Null>? customProperties;
  dynamic friendlyPluginName;

  CarrierModel(
      {this.id,
      this.editShippigStatus,
      this.systemName,
      this.staticName,
      this.methodName,
      this.carrierName,
      this.email,
      this.icon,
      this.isActive,
      this.isOnline,
      this.returnApplicable,
      this.publicRate,
      this.shippingTripType,
      this.limitedToStore,
      this.shippingTripTypeIds,
      this.limitedToStoreIds,
      this.markUpPercentage,
      this.intlMarkUpPercentage,
      this.onDemandMarkUpPercentage,
      this.onDemandIntlMarkUpPercentage,
      this.customMarkUpPercentage,
      this.customIntlMarkUpPercentage,
      this.domesticDiscountPercentage,
      this.internationalDiscountPercentage,
      this.onDemandDomesticDiscountPercentage,
      this.onDemandInternationalDiscountPercentage,
      this.customDomesticDiscountPercentage,
      this.customInternationalDiscountPercentage,
      this.carrierCODPercentage,
      this.intlCODPercentage,
      this.carrierCODMinimalCharge,
      this.intlCODMinimalCharge,
      this.returnUponDeliveryRate,
      this.failedDeliveryRate,
      this.configure,
      this.carrierAWBType,
      this.configureUrl,
      this.displayOrder,
      this.transitDays,
      this.totalRate,
      this.iconUrl,
      this.iconId,
      this.termsUrl,
      this.availableShippingTripType,
      this.availableStores,
      this.availableCarriersLibraries,
      this.vendorId,
      this.availableVendors,
      this.availableCountries,
      this.selectedVendors,
      this.selectedCountries,
      this.primaryStoreCurrencyCode,
      this.vatPercentage,
      this.isICarryCarrier,
      this.isAvailableForOnDemand,
      this.isAvailableForAllVendors,
      this.isCODProvided,
      this.enableSchedule,
      this.enableAutoPickupRequest,
      this.hasRateAPI,
      this.shippingProviderHasRateAPI,
      this.integrationType,
      this.proofDeliveryIds,
      this.gridPageSize,
      this.availablePageSizes,
      this.customProperties,
      this.friendlyPluginName});

  CarrierModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    editShippigStatus = json['EditShippigStatus'];
    systemName = json['SystemName'];
    staticName = json['StaticName'];
    methodName = json['MethodName'];
    carrierName = json['CarrierName'];
    email = json['Email'];
    icon = json['Icon'];
    isActive = json['IsActive'];
    isOnline = json['IsOnline'];
    returnApplicable = json['ReturnApplicable'];
    publicRate = json['PublicRate'];
    shippingTripType = json['ShippingTripType'];
    limitedToStore = json['LimitedToStore'];
    // if (json['ShippingTripTypeIds'] != null) {
    //   shippingTripTypeIds = <Null>[];
    //   json['ShippingTripTypeIds'].forEach((v) {
    //     shippingTripTypeIds!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['LimitedToStoreIds'] != null) {
    //   limitedToStoreIds = <Null>[];
    //   json['LimitedToStoreIds'].forEach((v) {
    //     limitedToStoreIds!.add(new Null.fromJson(v));
    //   });
    // }
    markUpPercentage = json['MarkUpPercentage'];
    intlMarkUpPercentage = json['IntlMarkUpPercentage'];
    onDemandMarkUpPercentage = json['OnDemandMarkUpPercentage'];
    onDemandIntlMarkUpPercentage = json['OnDemandIntlMarkUpPercentage'];
    customMarkUpPercentage = json['CustomMarkUpPercentage'];
    customIntlMarkUpPercentage = json['CustomIntlMarkUpPercentage'];
    domesticDiscountPercentage = json['DomesticDiscountPercentage'];
    internationalDiscountPercentage = json['InternationalDiscountPercentage'];
    onDemandDomesticDiscountPercentage = json['OnDemandDomesticDiscountPercentage'];
    onDemandInternationalDiscountPercentage = json['OnDemandInternationalDiscountPercentage'];
    customDomesticDiscountPercentage = json['CustomDomesticDiscountPercentage'];
    customInternationalDiscountPercentage = json['CustomInternationalDiscountPercentage'];
    carrierCODPercentage = json['CarrierCODPercentage'];
    intlCODPercentage = json['IntlCODPercentage'];
    carrierCODMinimalCharge = json['CarrierCODMinimalCharge'];
    intlCODMinimalCharge = json['IntlCODMinimalCharge'];
    returnUponDeliveryRate = json['ReturnUponDeliveryRate'];
    failedDeliveryRate = json['FailedDeliveryRate'];
    configure = json['Configure'];
    carrierAWBType = json['CarrierAWBType'];
    configureUrl = json['ConfigureUrl'];
    displayOrder = json['DisplayOrder'];
    transitDays = json['TransitDays'];
    totalRate = json['TotalRate'];
    iconUrl = json['IconUrl'];
    iconId = json['IconId'];
    termsUrl = json['TermsUrl'];
    // if (json['AvailableShippingTripType'] != null) {
    //   availableShippingTripType = <Null>[];
    //   json['AvailableShippingTripType'].forEach((v) {
    //     availableShippingTripType!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['AvailableStores'] != null) {
    //   availableStores = <Null>[];
    //   json['AvailableStores'].forEach((v) {
    //     availableStores!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['AvailableCarriersLibraries'] != null) {
    //   availableCarriersLibraries = <Null>[];
    //   json['AvailableCarriersLibraries'].forEach((v) {
    //     availableCarriersLibraries!.add(new Null.fromJson(v));
    //   });
    // }
    vendorId = json['VendorId'];
    // if (json['AvailableVendors'] != null) {
    //   availableVendors = <Null>[];
    //   json['AvailableVendors'].forEach((v) {
    //     availableVendors!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['AvailableCountries'] != null) {
    //   availableCountries = <Null>[];
    //   json['AvailableCountries'].forEach((v) {
    //     availableCountries!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['SelectedVendors'] != null) {
    //   selectedVendors = <Null>[];
    //   json['SelectedVendors'].forEach((v) {
    //     selectedVendors!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['SelectedCountries'] != null) {
    //   selectedCountries = <Null>[];
    //   json['SelectedCountries'].forEach((v) {
    //     selectedCountries!.add(new Null.fromJson(v));
    //   });
    // }
    primaryStoreCurrencyCode = json['PrimaryStoreCurrencyCode'];
    vatPercentage = json['VatPercentage'];
    isICarryCarrier = json['isICarryCarrier'];
    isAvailableForOnDemand = json['IsAvailableForOnDemand'];
    isAvailableForAllVendors = json['IsAvailableForAllVendors'];
    isCODProvided = json['IsCODProvided'];
    enableSchedule = json['EnableSchedule'];
    enableAutoPickupRequest = json['EnableAutoPickupRequest'];
    hasRateAPI = json['HasRateAPI'];
    shippingProviderHasRateAPI = json['ShippingProviderHasRateAPI'];
    integrationType = json['IntegrationType'];
    // if (json['ProofDeliveryIds'] != null) {
    //   proofDeliveryIds = <Null>[];
    //   json['ProofDeliveryIds'].forEach((v) {
    //     proofDeliveryIds!.add(new Null.fromJson(v));
    //   });
    // }
    // gridPageSize = json['GridPageSize'];
    // if (json['AvailablePageSizes'] != null) {
    //   availablePageSizes = <Null>[];
    //   json['AvailablePageSizes'].forEach((v) {
    //     availablePageSizes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['CustomProperties'] != null) {
    //   customProperties = <Null>[];
    //   json['CustomProperties'].forEach((v) {
    //     customProperties!.add(new Null.fromJson(v));
    //   });
    // }
    friendlyPluginName = json['friendlyPluginName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EditShippigStatus'] = this.editShippigStatus;
    data['SystemName'] = this.systemName;
    data['StaticName'] = this.staticName;
    data['MethodName'] = this.methodName;
    data['CarrierName'] = this.carrierName;
    data['Email'] = this.email;
    data['Icon'] = this.icon;
    data['IsActive'] = this.isActive;
    data['IsOnline'] = this.isOnline;
    data['ReturnApplicable'] = this.returnApplicable;
    data['PublicRate'] = this.publicRate;
    data['ShippingTripType'] = this.shippingTripType;
    data['LimitedToStore'] = this.limitedToStore;
    // if (this.shippingTripTypeIds != null) {
    //   data['ShippingTripTypeIds'] =
    //       this.shippingTripTypeIds!.map((v) => v.toJson()).toList();
    // }
    // if (this.limitedToStoreIds != null) {
    //   data['LimitedToStoreIds'] =
    //       this.limitedToStoreIds!.map((v) => v.toJson()).toList();
    // }
    data['MarkUpPercentage'] = this.markUpPercentage;
    data['IntlMarkUpPercentage'] = this.intlMarkUpPercentage;
    data['OnDemandMarkUpPercentage'] = this.onDemandMarkUpPercentage;
    data['OnDemandIntlMarkUpPercentage'] = this.onDemandIntlMarkUpPercentage;
    data['CustomMarkUpPercentage'] = this.customMarkUpPercentage;
    data['CustomIntlMarkUpPercentage'] = this.customIntlMarkUpPercentage;
    data['DomesticDiscountPercentage'] = this.domesticDiscountPercentage;
    data['InternationalDiscountPercentage'] = this.internationalDiscountPercentage;
    data['OnDemandDomesticDiscountPercentage'] = this.onDemandDomesticDiscountPercentage;
    data['OnDemandInternationalDiscountPercentage'] = this.onDemandInternationalDiscountPercentage;
    data['CustomDomesticDiscountPercentage'] = this.customDomesticDiscountPercentage;
    data['CustomInternationalDiscountPercentage'] = this.customInternationalDiscountPercentage;
    data['CarrierCODPercentage'] = this.carrierCODPercentage;
    data['IntlCODPercentage'] = this.intlCODPercentage;
    data['CarrierCODMinimalCharge'] = this.carrierCODMinimalCharge;
    data['IntlCODMinimalCharge'] = this.intlCODMinimalCharge;
    data['ReturnUponDeliveryRate'] = this.returnUponDeliveryRate;
    data['FailedDeliveryRate'] = this.failedDeliveryRate;
    data['Configure'] = this.configure;
    data['CarrierAWBType'] = this.carrierAWBType;
    data['ConfigureUrl'] = this.configureUrl;
    data['DisplayOrder'] = this.displayOrder;
    data['TransitDays'] = this.transitDays;
    data['TotalRate'] = this.totalRate;
    data['IconUrl'] = this.iconUrl;
    data['IconId'] = this.iconId;
    data['TermsUrl'] = this.termsUrl;
    // if (this.availableShippingTripType != null) {
    //   data['AvailableShippingTripType'] =
    //       this.availableShippingTripType!.map((v) => v.toJson()).toList();
    // }
    // if (this.availableStores != null) {
    //   data['AvailableStores'] =
    //       this.availableStores!.map((v) => v.toJson()).toList();
    // }
    // if (this.availableCarriersLibraries != null) {
    //   data['AvailableCarriersLibraries'] =
    //       this.availableCarriersLibraries!.map((v) => v.toJson()).toList();
    // }
    // data['VendorId'] = this.vendorId;
    // if (this.availableVendors != null) {
    //   data['AvailableVendors'] =
    //       this.availableVendors!.map((v) => v.toJson()).toList();
    // }
    // if (this.availableCountries != null) {
    //   data['AvailableCountries'] =
    //       this.availableCountries!.map((v) => v.toJson()).toList();
    // }
    // if (this.selectedVendors != null) {
    //   data['SelectedVendors'] =
    //       this.selectedVendors!.map((v) => v.toJson()).toList();
    // }
    // if (this.selectedCountries != null) {
    //   data['SelectedCountries'] =
    //       this.selectedCountries!.map((v) => v.toJson()).toList();
    // }
    data['PrimaryStoreCurrencyCode'] = this.primaryStoreCurrencyCode;
    data['VatPercentage'] = this.vatPercentage;
    data['isICarryCarrier'] = this.isICarryCarrier;
    data['IsAvailableForOnDemand'] = this.isAvailableForOnDemand;
    data['IsAvailableForAllVendors'] = this.isAvailableForAllVendors;
    data['IsCODProvided'] = this.isCODProvided;
    data['EnableSchedule'] = this.enableSchedule;
    data['EnableAutoPickupRequest'] = this.enableAutoPickupRequest;
    data['HasRateAPI'] = this.hasRateAPI;
    data['ShippingProviderHasRateAPI'] = this.shippingProviderHasRateAPI;
    data['IntegrationType'] = this.integrationType;
    // if (this.proofDeliveryIds != null) {
    //   data['ProofDeliveryIds'] =
    //       this.proofDeliveryIds!.map((v) => v.toJson()).toList();
    // }
    // data['GridPageSize'] = this.gridPageSize;
    // if (this.availablePageSizes != null) {
    //   data['AvailablePageSizes'] =
    //       this.availablePageSizes!.map((v) => v.toJson()).toList();
    // }
    // if (this.customProperties != null) {
    //   data['CustomProperties'] =
    //       this.customProperties!.map((v) => v.toJson()).toList();
    // }
    data['friendlyPluginName'] = this.friendlyPluginName;
    return data;
  }
}

class Finance {
  dynamic shipmentID;
  dynamic orderID;
  dynamic deliveryRate;
  dynamic deliveryCharge;
  dynamic cODCharge;
  dynamic serviceFee;
  dynamic subscriptionplanVendorID;
  dynamic revenues;
  dynamic taxRate;
  dynamic taxValue;
  dynamic deliveryExpense;
  dynamic cODExpense;
  dynamic expenses;
  dynamic grossProfit;
  dynamic affiliateCost;
  dynamic fulfillmentCharge;
  dynamic fulfillmentCost;
  bool? isSpecialRate;
  dynamic originalRate;
  bool? deleted;
  bool? completed;
  dynamic id;

  Finance(
      {this.shipmentID,
      this.orderID,
      this.deliveryRate,
      this.deliveryCharge,
      this.cODCharge,
      this.serviceFee,
      this.subscriptionplanVendorID,
      this.revenues,
      this.taxRate,
      this.taxValue,
      this.deliveryExpense,
      this.cODExpense,
      this.expenses,
      this.grossProfit,
      this.affiliateCost,
      this.fulfillmentCharge,
      this.fulfillmentCost,
      this.isSpecialRate,
      this.originalRate,
      this.deleted,
      this.completed,
      this.id});

  Finance.fromJson(Map<String, dynamic> json) {
    shipmentID = json['ShipmentID'];
    orderID = json['OrderID'];
    deliveryRate = json['DeliveryRate'];
    deliveryCharge = json['DeliveryCharge'];
    cODCharge = json['CODCharge'];
    serviceFee = json['ServiceFee'];
    subscriptionplanVendorID = json['SubscriptionplanVendorID'];
    revenues = json['Revenues'];
    taxRate = json['TaxRate'];
    taxValue = json['TaxValue'];
    deliveryExpense = json['DeliveryExpense'];
    cODExpense = json['CODExpense'];
    expenses = json['Expenses'];
    grossProfit = json['GrossProfit'];
    affiliateCost = json['AffiliateCost'];
    fulfillmentCharge = json['FulfillmentCharge'];
    fulfillmentCost = json['FulfillmentCost'];
    isSpecialRate = json['IsSpecialRate'];
    originalRate = json['OriginalRate'];
    deleted = json['Deleted'];
    completed = json['Completed'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShipmentID'] = this.shipmentID;
    data['OrderID'] = this.orderID;
    data['DeliveryRate'] = this.deliveryRate;
    data['DeliveryCharge'] = this.deliveryCharge;
    data['CODCharge'] = this.cODCharge;
    data['ServiceFee'] = this.serviceFee;
    data['SubscriptionplanVendorID'] = this.subscriptionplanVendorID;
    data['Revenues'] = this.revenues;
    data['TaxRate'] = this.taxRate;
    data['TaxValue'] = this.taxValue;
    data['DeliveryExpense'] = this.deliveryExpense;
    data['CODExpense'] = this.cODExpense;
    data['Expenses'] = this.expenses;
    data['GrossProfit'] = this.grossProfit;
    data['AffiliateCost'] = this.affiliateCost;
    data['FulfillmentCharge'] = this.fulfillmentCharge;
    data['FulfillmentCost'] = this.fulfillmentCost;
    data['IsSpecialRate'] = this.isSpecialRate;
    data['OriginalRate'] = this.originalRate;
    data['Deleted'] = this.deleted;
    data['Completed'] = this.completed;
    data['Id'] = this.id;
    return data;
  }
}

class WorkingCurrency {
  dynamic name;
  dynamic currencyCode;
  dynamic rate;
  dynamic displayLocale;
  dynamic customFormatting;
  bool? limitedToStores;
  bool? published;
  dynamic displayOrder;
  dynamic createdOnUtc;
  dynamic updatedOnUtc;
  dynamic roundingTypeId;
  dynamic roundingType;
  dynamic id;

  WorkingCurrency(
      {this.name,
      this.currencyCode,
      this.rate,
      this.displayLocale,
      this.customFormatting,
      this.limitedToStores,
      this.published,
      this.displayOrder,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.roundingTypeId,
      this.roundingType,
      this.id});

  WorkingCurrency.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    currencyCode = json['CurrencyCode'];
    rate = json['Rate'];
    displayLocale = json['DisplayLocale'];
    customFormatting = json['CustomFormatting'];
    limitedToStores = json['LimitedToStores'];
    published = json['Published'];
    displayOrder = json['DisplayOrder'];
    createdOnUtc = json['CreatedOnUtc'];
    updatedOnUtc = json['UpdatedOnUtc'];
    roundingTypeId = json['RoundingTypeId'];
    roundingType = json['RoundingType'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['CurrencyCode'] = this.currencyCode;
    data['Rate'] = this.rate;
    data['DisplayLocale'] = this.displayLocale;
    data['CustomFormatting'] = this.customFormatting;
    data['LimitedToStores'] = this.limitedToStores;
    data['Published'] = this.published;
    data['DisplayOrder'] = this.displayOrder;
    data['CreatedOnUtc'] = this.createdOnUtc;
    data['UpdatedOnUtc'] = this.updatedOnUtc;
    data['RoundingTypeId'] = this.roundingTypeId;
    data['RoundingType'] = this.roundingType;
    data['Id'] = this.id;
    return data;
  }
}

class LocalShipping {
  dynamic id;
  dynamic name;
  dynamic value;
  dynamic vendorId;

  LocalShipping({this.id, this.name, this.value, this.vendorId});

  LocalShipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class ReturnData {
  dynamic startDate;
  dynamic timeSloat;
  dynamic sloatEndTime;
  dynamic quantity;

  ReturnData({this.startDate, this.timeSloat, this.sloatEndTime, this.quantity});

  ReturnData.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    timeSloat = json['time_sloat'];
    sloatEndTime = json['sloat_end_time'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['time_sloat'] = this.timeSloat;
    data['sloat_end_time'] = this.sloatEndTime;
    data['quantity'] = this.quantity;
    return data;
  }
}

class ProdcutData {
  dynamic id;
  dynamic vendorId;
  dynamic addressId;
  dynamic catId;
  dynamic catId2;
  dynamic jobCat;
  dynamic brandSlug;
  dynamic slug;
  dynamic storeName;
  dynamic pname;
  dynamic prodectImage;
  dynamic prodectName;
  dynamic prodectSku;
  dynamic views;
  dynamic code;
  dynamic bookingProductType;
  dynamic prodectPrice;
  dynamic prodectMinQty;
  dynamic prodectMixQty;
  dynamic prodectDescription;
  dynamic image;
  dynamic arabPname;
  dynamic productType;
  dynamic itemType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
  dynamic arabShortDescription;
  dynamic longDescription;
  dynamic arabLongDescription;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic virtualProductFileLanguage;
  dynamic featureImageApp;
  dynamic featureImageWeb;
  dynamic inStock;
  dynamic weight;
  dynamic weightUnit;
  dynamic time;
  dynamic timePeriod;
  dynamic stockAlert;
  dynamic shippingCharge;
  dynamic avgRating;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  dynamic metaTags;
  dynamic seoTags;
  dynamic parentId;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic serviceDuration;
  dynamic deliverySize;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic productCode;
  dynamic promotionCode;
  dynamic packageDetail;
  dynamic jobseekingOrOffering;
  dynamic jobType;
  dynamic jobModel;
  dynamic describeJobRole;
  dynamic linkdinUrl;
  dynamic experience;
  dynamic salary;
  dynamic aboutYourself;
  dynamic jobHours;
  dynamic jobCountryId;
  dynamic jobStateId;
  dynamic jobCityId;
  dynamic uploadCv;
  dynamic isOnsale;
  dynamic discountPercent;
  dynamic fixedDiscountPrice;
  dynamic shippingPay;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic limitedTimeDeal;
  dynamic returnDays;
  dynamic keyword;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;
  dynamic shippingPolicyDesc;
  dynamic pickupPolicyId;
  dynamic bookableProductLocation;
  dynamic spot;
  dynamic hostName;
  dynamic programName;
  dynamic programGoal;
  dynamic programDesc;
  dynamic eligibleMinAge;
  dynamic eligibleMaxAge;
  dynamic eligibleGender;
  dynamic fromLocation;
  dynamic toLocation;
  dynamic fromExtraNotes;
  dynamic toExtraNotes;
  dynamic timingExtraNotes;
  dynamic productSponsorsId;
  dynamic meetingPlatform;
  dynamic meetingLink;
  dynamic optionalLink;
  dynamic linkShareVia;
  bool? isShipping;
  dynamic discountPrice;
  dynamic shippingPolicy;
  dynamic variantPrice;
  ProdcutData(
      {this.id,
      this.vendorId,
      this.addressId,
      this.catId,
      this.catId2,
      this.jobCat,
      this.brandSlug,
      this.slug,
      this.pname,
      this.prodectImage,
      this.prodectName,
      this.prodectSku,
      this.storeName,
      this.views,
      this.code,
      this.bookingProductType,
      this.prodectPrice,
      this.prodectMinQty,
      this.prodectMixQty,
      this.prodectDescription,
      this.image,
      this.arabPname,
      this.productType,
      this.itemType,
      this.virtualProductType,
      this.skuId,
      this.pPrice,
      this.sPrice,
      this.commission,
      this.bestSaller,
      this.featured,
      this.taxApply,
      this.taxType,
      this.shortDescription,
      this.arabShortDescription,
      this.longDescription,
      this.arabLongDescription,
      this.featuredImage,
      this.galleryImage,
      this.virtualProductFile,
      this.virtualProductFileType,
      this.virtualProductFileLanguage,
      this.featureImageApp,
      this.featureImageWeb,
      this.inStock,
      this.weight,
      this.weightUnit,
      this.time,
      this.timePeriod,
      this.stockAlert,
      this.shippingCharge,
      this.avgRating,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.metaTags,
      this.seoTags,
      this.parentId,
      this.serviceStartTime,
      this.serviceEndTime,
      this.serviceDuration,
      this.deliverySize,
      this.serialNumber,
      this.productNumber,
      this.productCode,
      this.promotionCode,
      this.packageDetail,
      this.jobseekingOrOffering,
      this.jobType,
      this.jobModel,
      this.describeJobRole,
      this.linkdinUrl,
      this.experience,
      this.salary,
      this.aboutYourself,
      this.jobHours,
      this.jobCountryId,
      this.jobStateId,
      this.jobCityId,
      this.uploadCv,
      this.isOnsale,
      this.discountPercent,
      this.fixedDiscountPrice,
      this.shippingPay,
      this.createdAt,
      this.updatedAt,
      this.topHunderd,
      this.limitedTimeDeal,
      this.returnDays,
      this.keyword,
      this.isPublish,
      this.inOffer,
      this.forAuction,
      this.returnPolicyDesc,
      this.shippingPolicyDesc,
      this.pickupPolicyId,
      this.bookableProductLocation,
      this.spot,
      this.hostName,
      this.programName,
      this.programGoal,
      this.programDesc,
      this.eligibleMinAge,
      this.eligibleMaxAge,
      this.eligibleGender,
      this.fromLocation,
      this.toLocation,
      this.fromExtraNotes,
      this.toExtraNotes,
      this.timingExtraNotes,
      this.productSponsorsId,
      this.meetingPlatform,
      this.meetingLink,
      this.optionalLink,
      this.linkShareVia,
      this.isShipping,
      this.discountPrice,
      this.shippingPolicy,
      this.variantPrice
      });

  ProdcutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    jobCat = json['job_cat'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    prodectImage = json['prodect_image'];
    prodectName = json['prodect_name'];
    prodectSku = json['prodect_sku'];
    storeName = json['store_name'];
    views = json['views'];
    code = json['code'];
    bookingProductType = json['booking_product_type'];
    prodectPrice = json['prodect_price'];
    prodectMinQty = json['prodect_min_qty'];
    prodectMixQty = json['prodect_mix_qty'];
    prodectDescription = json['prodect_description'];
    image = json['image'];
    arabPname = json['arab_pname'];
    productType = json['product_type'];
    itemType = json['item_type'];
    virtualProductType = json['virtual_product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    commission = json['commission'];
    bestSaller = json['best_saller'];
    featured = json['featured'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    shortDescription = json['short_description'];
    arabShortDescription = json['arab_short_description'];
    longDescription = json['long_description'];
    arabLongDescription = json['arab_long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].cast<String>();
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    virtualProductFileLanguage = json['virtual_product_file_language'];
    featureImageApp = json['feature_image_app'];
    featureImageWeb = json['feature_image_web'];
    inStock = json['in_stock'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    time = json['time'];
    timePeriod = json['time_period'];
    stockAlert = json['stock_alert'];
    shippingCharge = json['shipping_charge'];
    avgRating = json['avg_rating'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    metaTags = json['meta_tags'];
    seoTags = json['seo_tags'];
    parentId = json['parent_id'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    serviceDuration = json['service_duration'];
    deliverySize = json['delivery_size'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    productCode = json['product_code'];
    promotionCode = json['promotion_code'];
    packageDetail = json['package_detail'];
    jobseekingOrOffering = json['jobseeking_or_offering'];
    jobType = json['job_type'];
    jobModel = json['job_model'];
    describeJobRole = json['describe_job_role'];
    linkdinUrl = json['linkdin_url'];
    experience = json['experience'];
    salary = json['salary'];
    aboutYourself = json['about_yourself'];
    jobHours = json['job_hours'];
    jobCountryId = json['job_country_id'];
    jobStateId = json['job_state_id'];
    jobCityId = json['job_city_id'];
    uploadCv = json['upload_cv'];
    isOnsale = json['is_onsale'];
    discountPercent = json['discount_percent'];
    fixedDiscountPrice = json['fixed_discount_price'];
    shippingPay = json['shipping_pay'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topHunderd = json['top_hunderd'];
    limitedTimeDeal = json['limited_time_deal'];
    returnDays = json['return_days'];
    keyword = json['keyword'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
    returnPolicyDesc = json['return_policy_desc'];
    shippingPolicyDesc = json['shipping_policy_desc'];
    pickupPolicyId = json['pickup_policy_id'];
    bookableProductLocation = json['bookable_product_location'];
    spot = json['spot'];
    hostName = json['host_name'];
    programName = json['program_name'];
    programGoal = json['program_goal'];
    programDesc = json['program_desc'];
    eligibleMinAge = json['eligible_min_age'];
    eligibleMaxAge = json['eligible_max_age'];
    eligibleGender = json['eligible_gender'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    fromExtraNotes = json['from_extra_notes'];
    toExtraNotes = json['to_extra_notes'];
    timingExtraNotes = json['timing_extra_notes'];
    productSponsorsId = json['product_sponsors_id'];
    meetingPlatform = json['meeting_platform'];
    meetingLink = json['meeting_link'];
    optionalLink = json['optional_link'];
    linkShareVia = json['link_share_via'];
    isShipping = json['is_shipping'];
    discountPrice = json['discount_price'];
    shippingPolicy = json['shipping_policy'];
    variantPrice = json['variant_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['address_id'] = this.addressId;
    data['cat_id'] = this.catId;
    data['cat_id_2'] = this.catId2;
    data['job_cat'] = this.jobCat;
    data['brand_slug'] = this.brandSlug;
    data['slug'] = this.slug;
    data['pname'] = this.pname;
    data['prodect_image'] = this.prodectImage;
    data['prodect_name'] = this.prodectName;
    data['prodect_sku'] = this.prodectSku;
    data['views'] = this.views;
    data['code'] = this.code;
    data['booking_product_type'] = this.bookingProductType;
    data['prodect_price'] = this.prodectPrice;
    data['store_name'] = this.storeName;
    data['prodect_min_qty'] = this.prodectMinQty;
    data['prodect_mix_qty'] = this.prodectMixQty;
    data['prodect_description'] = this.prodectDescription;
    data['image'] = this.image;
    data['arab_pname'] = this.arabPname;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['virtual_product_type'] = this.virtualProductType;
    data['sku_id'] = this.skuId;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['commission'] = this.commission;
    data['best_saller'] = this.bestSaller;
    data['featured'] = this.featured;
    data['tax_apply'] = this.taxApply;
    data['tax_type'] = this.taxType;
    data['short_description'] = this.shortDescription;
    data['arab_short_description'] = this.arabShortDescription;
    data['long_description'] = this.longDescription;
    data['arab_long_description'] = this.arabLongDescription;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['virtual_product_file'] = this.virtualProductFile;
    data['virtual_product_file_type'] = this.virtualProductFileType;
    data['virtual_product_file_language'] = this.virtualProductFileLanguage;
    data['feature_image_app'] = this.featureImageApp;
    data['feature_image_web'] = this.featureImageWeb;
    data['in_stock'] = this.inStock;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['time'] = this.time;
    data['time_period'] = this.timePeriod;
    data['stock_alert'] = this.stockAlert;
    data['shipping_charge'] = this.shippingCharge;
    data['avg_rating'] = this.avgRating;
    data['meta_title'] = this.metaTitle;
    data['meta_keyword'] = this.metaKeyword;
    data['meta_description'] = this.metaDescription;
    data['meta_tags'] = this.metaTags;
    data['seo_tags'] = this.seoTags;
    data['parent_id'] = this.parentId;
    data['service_start_time'] = this.serviceStartTime;
    data['service_end_time'] = this.serviceEndTime;
    data['service_duration'] = this.serviceDuration;
    data['delivery_size'] = this.deliverySize;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['product_code'] = this.productCode;
    data['promotion_code'] = this.promotionCode;
    data['package_detail'] = this.packageDetail;
    data['jobseeking_or_offering'] = this.jobseekingOrOffering;
    data['job_type'] = this.jobType;
    data['job_model'] = this.jobModel;
    data['describe_job_role'] = this.describeJobRole;
    data['linkdin_url'] = this.linkdinUrl;
    data['experience'] = this.experience;
    data['salary'] = this.salary;
    data['about_yourself'] = this.aboutYourself;
    data['job_hours'] = this.jobHours;
    data['job_country_id'] = this.jobCountryId;
    data['job_state_id'] = this.jobStateId;
    data['job_city_id'] = this.jobCityId;
    data['upload_cv'] = this.uploadCv;
    data['is_onsale'] = this.isOnsale;
    data['discount_percent'] = this.discountPercent;
    data['fixed_discount_price'] = this.fixedDiscountPrice;
    data['shipping_pay'] = this.shippingPay;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['top_hunderd'] = this.topHunderd;
    data['limited_time_deal'] = this.limitedTimeDeal;
    data['return_days'] = this.returnDays;
    data['keyword'] = this.keyword;
    data['is_publish'] = this.isPublish;
    data['in_offer'] = this.inOffer;
    data['for_auction'] = this.forAuction;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['shipping_policy_desc'] = this.shippingPolicyDesc;
    data['pickup_policy_id'] = this.pickupPolicyId;
    data['bookable_product_location'] = this.bookableProductLocation;
    data['spot'] = this.spot;
    data['host_name'] = this.hostName;
    data['program_name'] = this.programName;
    data['program_goal'] = this.programGoal;
    data['program_desc'] = this.programDesc;
    data['eligible_min_age'] = this.eligibleMinAge;
    data['eligible_max_age'] = this.eligibleMaxAge;
    data['eligible_gender'] = this.eligibleGender;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['from_extra_notes'] = this.fromExtraNotes;
    data['to_extra_notes'] = this.toExtraNotes;
    data['timing_extra_notes'] = this.timingExtraNotes;
    data['product_sponsors_id'] = this.productSponsorsId;
    data['meeting_platform'] = this.meetingPlatform;
    data['meeting_link'] = this.meetingLink;
    data['optional_link'] = this.optionalLink;
    data['link_share_via'] = this.linkShareVia;
    data['is_shipping'] = this.isShipping;
    data['discount_price'] = this.discountPrice;
    data['shipping_policy'] = this.shippingPolicy;
    data['variant_price'] = variantPrice;
    return data;
  }
}

class FedexShipping {
  dynamic transactionId;
  Output? output;

  FedexShipping({this.transactionId, this.output});

  FedexShipping.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    output = json['output'] != null ? new Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    if (this.output != null) {
      data['output'] = this.output!.toJson();
    }
    return data;
  }
}

class Output {
  List<RateReplyDetails>? rateReplyDetails;
  dynamic quoteDate;
  bool? encoded;

  Output({this.rateReplyDetails, this.quoteDate, this.encoded});

  Output.fromJson(Map<String, dynamic> json) {
    if (json['rateReplyDetails'] != null) {
      rateReplyDetails = <RateReplyDetails>[];
      json['rateReplyDetails'].forEach((v) {
        rateReplyDetails!.add(new RateReplyDetails.fromJson(v));
      });
    }
    quoteDate = json['quoteDate'];
    encoded = json['encoded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rateReplyDetails != null) {
      data['rateReplyDetails'] = this.rateReplyDetails!.map((v) => v.toJson()).toList();
    }
    data['quoteDate'] = this.quoteDate;
    data['encoded'] = this.encoded;
    return data;
  }
}

class RateReplyDetails {
  dynamic serviceType;
  dynamic serviceName;
  dynamic packagingType;
  Commit? commit;
  List<CustomerMessages>? customerMessages;
  List<RatedShipmentDetails>? ratedShipmentDetails;
  OperationalDetail? operationalDetail;
  dynamic signatureOptionType;
  ServiceDescription? serviceDescription;
  dynamic deliveryStation;

  RateReplyDetails(
      {this.serviceType,
      this.serviceName,
      this.packagingType,
      this.commit,
      this.customerMessages,
      this.ratedShipmentDetails,
      this.operationalDetail,
      this.signatureOptionType,
      this.serviceDescription,
      this.deliveryStation});

  RateReplyDetails.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    serviceName = json['serviceName'];
    packagingType = json['packagingType'];
    commit = json['commit'] != null ? new Commit.fromJson(json['commit']) : null;
    if (json['customerMessages'] != null) {
      customerMessages = <CustomerMessages>[];
      json['customerMessages'].forEach((v) {
        customerMessages!.add(new CustomerMessages.fromJson(v));
      });
    }
    if (json['ratedShipmentDetails'] != null) {
      ratedShipmentDetails = <RatedShipmentDetails>[];
      json['ratedShipmentDetails'].forEach((v) {
        ratedShipmentDetails!.add(new RatedShipmentDetails.fromJson(v));
      });
    }
    operationalDetail =
        json['operationalDetail'] != null ? new OperationalDetail.fromJson(json['operationalDetail']) : null;
    signatureOptionType = json['signatureOptionType'];
    serviceDescription =
        json['serviceDescription'] != null ? new ServiceDescription.fromJson(json['serviceDescription']) : null;
    deliveryStation = json['deliveryStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['serviceName'] = this.serviceName;
    data['packagingType'] = this.packagingType;
    if (this.commit != null) {
      data['commit'] = this.commit!.toJson();
    }
    if (this.customerMessages != null) {
      data['customerMessages'] = this.customerMessages!.map((v) => v.toJson()).toList();
    }
    if (this.ratedShipmentDetails != null) {
      data['ratedShipmentDetails'] = this.ratedShipmentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.operationalDetail != null) {
      data['operationalDetail'] = this.operationalDetail!.toJson();
    }
    data['signatureOptionType'] = this.signatureOptionType;
    if (this.serviceDescription != null) {
      data['serviceDescription'] = this.serviceDescription!.toJson();
    }
    data['deliveryStation'] = this.deliveryStation;
    return data;
  }
}

class Commit {
  DateDetail? dateDetail;
  dynamic label;
  dynamic commitMessageDetails;
  dynamic commodityName;
  List<String>? deliveryMessages;
  DerivedOriginDetail? derivedOriginDetail;
  DerivedDestinationDetail? derivedDestinationDetail;
  bool? saturdayDelivery;

  Commit(
      {this.dateDetail,
      this.label,
      this.commitMessageDetails,
      this.commodityName,
      this.deliveryMessages,
      this.derivedOriginDetail,
      this.derivedDestinationDetail,
      this.saturdayDelivery});

  Commit.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    dateDetail = json['dateDetail'] != null ? new DateDetail.fromJson(json['dateDetail']) : null;
    commitMessageDetails = json['commitMessageDetails'];
    commodityName = json['commodityName'];
    deliveryMessages = json['deliveryMessages'].cast<String>();
    derivedOriginDetail =
        json['derivedOriginDetail'] != null ? new DerivedOriginDetail.fromJson(json['derivedOriginDetail']) : null;
    derivedDestinationDetail = json['derivedDestinationDetail'] != null
        ? new DerivedDestinationDetail.fromJson(json['derivedDestinationDetail'])
        : null;
    saturdayDelivery = json['saturdayDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateDetail != null) {
      data['dateDetail'] = this.dateDetail!.toJson();
    }
    data['label'] = this.label;
    data['commitMessageDetails'] = this.commitMessageDetails;
    data['commodityName'] = this.commodityName;
    data['deliveryMessages'] = this.deliveryMessages;
    if (this.derivedOriginDetail != null) {
      data['derivedOriginDetail'] = this.derivedOriginDetail!.toJson();
    }
    if (this.derivedDestinationDetail != null) {
      data['derivedDestinationDetail'] = this.derivedDestinationDetail!.toJson();
    }
    data['saturdayDelivery'] = this.saturdayDelivery;
    return data;
  }
}

class DateDetail {
  String? dayOfWeek;
  String? dayFormat;

  DateDetail({this.dayOfWeek, this.dayFormat});

  DateDetail.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    dayFormat = json['dayFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfWeek'] = this.dayOfWeek;
    data['dayFormat'] = this.dayFormat;
    return data;
  }
}

class DerivedOriginDetail {
  dynamic countryCode;
  dynamic postalCode;
  dynamic serviceArea;
  dynamic locationId;
  dynamic locationNumber;

  DerivedOriginDetail({this.countryCode, this.postalCode, this.serviceArea, this.locationId, this.locationNumber});

  DerivedOriginDetail.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    postalCode = json['postalCode'];
    serviceArea = json['serviceArea'];
    locationId = json['locationId'];
    locationNumber = json['locationNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = this.countryCode;
    data['postalCode'] = this.postalCode;
    data['serviceArea'] = this.serviceArea;
    data['locationId'] = this.locationId;
    data['locationNumber'] = this.locationNumber;
    return data;
  }
}

class DerivedDestinationDetail {
  dynamic countryCode;
  dynamic postalCode;
  dynamic serviceArea;
  dynamic locationId;
  dynamic locationNumber;
  dynamic airportId;

  DerivedDestinationDetail(
      {this.countryCode, this.postalCode, this.serviceArea, this.locationId, this.locationNumber, this.airportId});

  DerivedDestinationDetail.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    postalCode = json['postalCode'];
    serviceArea = json['serviceArea'];
    locationId = json['locationId'];
    locationNumber = json['locationNumber'];
    airportId = json['airportId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = this.countryCode;
    data['postalCode'] = this.postalCode;
    data['serviceArea'] = this.serviceArea;
    data['locationId'] = this.locationId;
    data['locationNumber'] = this.locationNumber;
    data['airportId'] = this.airportId;
    return data;
  }
}

class CustomerMessages {
  dynamic code;
  dynamic message;

  CustomerMessages({this.code, this.message});

  CustomerMessages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class RatedShipmentDetails {
  dynamic rateType;
  dynamic ratedWeightMethod;
  dynamic totalDiscounts;
  dynamic totalBaseCharge;
  dynamic totalNetCharge;
  dynamic totalVatCharge;
  dynamic totalNetFedExCharge;
  dynamic totalDutiesAndTaxes;
  dynamic totalNetChargeWithDutiesAndTaxes;
  dynamic totalDutiesTaxesAndFees;
  dynamic totalAncillaryFeesAndTaxes;
  ShipmentRateDetail? shipmentRateDetail;
  List<RatedPackages>? ratedPackages;
  dynamic currency;

  RatedShipmentDetails(
      {this.rateType,
      this.ratedWeightMethod,
      this.totalDiscounts,
      this.totalBaseCharge,
      this.totalNetCharge,
      this.totalVatCharge,
      this.totalNetFedExCharge,
      this.totalDutiesAndTaxes,
      this.totalNetChargeWithDutiesAndTaxes,
      this.totalDutiesTaxesAndFees,
      this.totalAncillaryFeesAndTaxes,
      this.shipmentRateDetail,
      this.ratedPackages,
      this.currency});

  RatedShipmentDetails.fromJson(Map<String, dynamic> json) {
    rateType = json['rateType'];
    ratedWeightMethod = json['ratedWeightMethod'];
    totalDiscounts = json['totalDiscounts'];
    totalBaseCharge = json['totalBaseCharge'];
    totalNetCharge = json['totalNetCharge'];
    totalVatCharge = json['totalVatCharge'];
    totalNetFedExCharge = json['totalNetFedExCharge'];
    totalDutiesAndTaxes = json['totalDutiesAndTaxes'];
    totalNetChargeWithDutiesAndTaxes = json['totalNetChargeWithDutiesAndTaxes'];
    totalDutiesTaxesAndFees = json['totalDutiesTaxesAndFees'];
    totalAncillaryFeesAndTaxes = json['totalAncillaryFeesAndTaxes'];
    shipmentRateDetail =
        json['shipmentRateDetail'] != null ? new ShipmentRateDetail.fromJson(json['shipmentRateDetail']) : null;
    if (json['ratedPackages'] != null) {
      ratedPackages = <RatedPackages>[];
      json['ratedPackages'].forEach((v) {
        ratedPackages!.add(new RatedPackages.fromJson(v));
      });
    }
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateType'] = this.rateType;
    data['ratedWeightMethod'] = this.ratedWeightMethod;
    data['totalDiscounts'] = this.totalDiscounts;
    data['totalBaseCharge'] = this.totalBaseCharge;
    data['totalNetCharge'] = this.totalNetCharge;
    data['totalVatCharge'] = this.totalVatCharge;
    data['totalNetFedExCharge'] = this.totalNetFedExCharge;
    data['totalDutiesAndTaxes'] = this.totalDutiesAndTaxes;
    data['totalNetChargeWithDutiesAndTaxes'] = this.totalNetChargeWithDutiesAndTaxes;
    data['totalDutiesTaxesAndFees'] = this.totalDutiesTaxesAndFees;
    data['totalAncillaryFeesAndTaxes'] = this.totalAncillaryFeesAndTaxes;
    if (this.shipmentRateDetail != null) {
      data['shipmentRateDetail'] = this.shipmentRateDetail!.toJson();
    }
    if (this.ratedPackages != null) {
      data['ratedPackages'] = this.ratedPackages!.map((v) => v.toJson()).toList();
    }
    data['currency'] = this.currency;
    return data;
  }
}

class ShipmentRateDetail {
  dynamic rateZone;
  dynamic dimDivisor;
  dynamic fuelSurchargePercent;
  dynamic totalSurcharges;
  dynamic totalFreightDiscount;
  List<FreightDiscount>? freightDiscount;
  List<SurCharges>? surCharges;
  dynamic pricingCode;
  CurrencyExchangeRate? currencyExchangeRate;
  TotalBillingWeight? totalBillingWeight;
  dynamic dimDivisorType;
  dynamic currency;
  dynamic rateScale;
  TotalBillingWeight? totalRateScaleWeight;

  ShipmentRateDetail(
      {this.rateZone,
      this.dimDivisor,
      this.fuelSurchargePercent,
      this.totalSurcharges,
      this.totalFreightDiscount,
      this.freightDiscount,
      this.surCharges,
      this.pricingCode,
      this.currencyExchangeRate,
      this.totalBillingWeight,
      this.dimDivisorType,
      this.currency,
      this.rateScale,
      this.totalRateScaleWeight});

  ShipmentRateDetail.fromJson(Map<String, dynamic> json) {
    rateZone = json['rateZone'];
    dimDivisor = json['dimDivisor'];
    fuelSurchargePercent = json['fuelSurchargePercent'];
    totalSurcharges = json['totalSurcharges'];
    totalFreightDiscount = json['totalFreightDiscount'];
    if (json['freightDiscount'] != null) {
      freightDiscount = <FreightDiscount>[];
      json['freightDiscount'].forEach((v) {
        freightDiscount!.add(new FreightDiscount.fromJson(v));
      });
    }
    if (json['surCharges'] != null) {
      surCharges = <SurCharges>[];
      json['surCharges'].forEach((v) {
        surCharges!.add(new SurCharges.fromJson(v));
      });
    }
    pricingCode = json['pricingCode'];
    currencyExchangeRate =
        json['currencyExchangeRate'] != null ? new CurrencyExchangeRate.fromJson(json['currencyExchangeRate']) : null;
    totalBillingWeight =
        json['totalBillingWeight'] != null ? new TotalBillingWeight.fromJson(json['totalBillingWeight']) : null;
    dimDivisorType = json['dimDivisorType'];
    currency = json['currency'];
    rateScale = json['rateScale'];
    totalRateScaleWeight =
        json['totalRateScaleWeight'] != null ? new TotalBillingWeight.fromJson(json['totalRateScaleWeight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateZone'] = this.rateZone;
    data['dimDivisor'] = this.dimDivisor;
    data['fuelSurchargePercent'] = this.fuelSurchargePercent;
    data['totalSurcharges'] = this.totalSurcharges;
    data['totalFreightDiscount'] = this.totalFreightDiscount;
    if (this.freightDiscount != null) {
      data['freightDiscount'] = this.freightDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.surCharges != null) {
      data['surCharges'] = this.surCharges!.map((v) => v.toJson()).toList();
    }
    data['pricingCode'] = this.pricingCode;
    if (this.currencyExchangeRate != null) {
      data['currencyExchangeRate'] = this.currencyExchangeRate!.toJson();
    }
    if (this.totalBillingWeight != null) {
      data['totalBillingWeight'] = this.totalBillingWeight!.toJson();
    }
    data['dimDivisorType'] = this.dimDivisorType;
    data['currency'] = this.currency;
    data['rateScale'] = this.rateScale;
    if (this.totalRateScaleWeight != null) {
      data['totalRateScaleWeight'] = this.totalRateScaleWeight!.toJson();
    }
    return data;
  }
}

class FreightDiscount {
  dynamic type;
  dynamic description;
  dynamic amount;
  dynamic percent;

  FreightDiscount({this.type, this.description, this.amount, this.percent});

  FreightDiscount.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    amount = json['amount'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['percent'] = this.percent;
    return data;
  }
}

class SurCharges {
  dynamic type;
  dynamic description;
  dynamic level;
  dynamic amount;

  SurCharges({this.type, this.description, this.level, this.amount});

  SurCharges.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
    level = json['level'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['description'] = this.description;
    data['level'] = this.level;
    data['amount'] = this.amount;
    return data;
  }
}

class CurrencyExchangeRate {
  dynamic fromCurrency;
  dynamic intoCurrency;
  dynamic rate;

  CurrencyExchangeRate({this.fromCurrency, this.intoCurrency, this.rate});

  CurrencyExchangeRate.fromJson(Map<String, dynamic> json) {
    fromCurrency = json['fromCurrency'];
    intoCurrency = json['intoCurrency'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromCurrency'] = this.fromCurrency;
    data['intoCurrency'] = this.intoCurrency;
    data['rate'] = this.rate;
    return data;
  }
}

class TotalBillingWeight {
  dynamic units;
  dynamic value;

  TotalBillingWeight({this.units, this.value});

  TotalBillingWeight.fromJson(Map<String, dynamic> json) {
    units = json['units'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['units'] = this.units;
    data['value'] = this.value;
    return data;
  }
}

class RatedPackages {
  dynamic groupNumber;
  dynamic effectiveNetDiscount;
  PackageRateDetail? packageRateDetail;
  dynamic sequenceNumber;

  RatedPackages({this.groupNumber, this.effectiveNetDiscount, this.packageRateDetail, this.sequenceNumber});

  RatedPackages.fromJson(Map<String, dynamic> json) {
    groupNumber = json['groupNumber'];
    effectiveNetDiscount = json['effectiveNetDiscount'];
    packageRateDetail =
        json['packageRateDetail'] != null ? new PackageRateDetail.fromJson(json['packageRateDetail']) : null;
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupNumber'] = this.groupNumber;
    data['effectiveNetDiscount'] = this.effectiveNetDiscount;
    if (this.packageRateDetail != null) {
      data['packageRateDetail'] = this.packageRateDetail!.toJson();
    }
    data['sequenceNumber'] = this.sequenceNumber;
    return data;
  }
}

class PackageRateDetail {
  dynamic rateType;
  dynamic ratedWeightMethod;
  dynamic baseCharge;
  dynamic netFreight;
  dynamic totalSurcharges;
  dynamic netFedExCharge;
  dynamic totalTaxes;
  dynamic netCharge;
  dynamic totalRebates;
  TotalBillingWeight? billingWeight;
  dynamic totalFreightDiscounts;
  // List<FreightDiscounts>? freightDiscounts;
  // List<Surcharges>? surcharges;
  dynamic currency;

  PackageRateDetail(
      {this.rateType,
      this.ratedWeightMethod,
      this.baseCharge,
      this.netFreight,
      this.totalSurcharges,
      this.netFedExCharge,
      this.totalTaxes,
      this.netCharge,
      this.totalRebates,
      this.billingWeight,
      this.totalFreightDiscounts,
      // this.freightDiscounts,
      // this.surcharges,
      this.currency});

  PackageRateDetail.fromJson(Map<String, dynamic> json) {
    rateType = json['rateType'];
    ratedWeightMethod = json['ratedWeightMethod'];
    baseCharge = json['baseCharge'];
    netFreight = json['netFreight'];
    totalSurcharges = json['totalSurcharges'];
    netFedExCharge = json['netFedExCharge'];
    totalTaxes = json['totalTaxes'];
    netCharge = json['netCharge'];
    totalRebates = json['totalRebates'];
    billingWeight = json['billingWeight'] != null ? new TotalBillingWeight.fromJson(json['billingWeight']) : null;
    totalFreightDiscounts = json['totalFreightDiscounts'];
    // if (json['freightDiscounts'] != null) {
    //   freightDiscounts = <FreightDiscounts>[];
    //   json['freightDiscounts'].forEach((v) {
    //     freightDiscounts!.add(new FreightDiscounts.fromJson(v));
    //   });
    // }
    // if (json['surcharges'] != null) {
    //   surcharges = <Surcharges>[];
    //   json['surcharges'].forEach((v) {
    //     surcharges!.add(new Surcharges.fromJson(v));
    //   });
    // }
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateType'] = this.rateType;
    data['ratedWeightMethod'] = this.ratedWeightMethod;
    data['baseCharge'] = this.baseCharge;
    data['netFreight'] = this.netFreight;
    data['totalSurcharges'] = this.totalSurcharges;
    data['netFedExCharge'] = this.netFedExCharge;
    data['totalTaxes'] = this.totalTaxes;
    data['netCharge'] = this.netCharge;
    data['totalRebates'] = this.totalRebates;
    if (this.billingWeight != null) {
      data['billingWeight'] = this.billingWeight!.toJson();
    }
    data['totalFreightDiscounts'] = this.totalFreightDiscounts;
    // if (this.freightDiscounts != null) {
    //   data['freightDiscounts'] =
    //       this.freightDiscounts!.map((v) => v.toJson()).toList();
    // }
    // if (this.surcharges != null) {
    //   data['surcharges'] = this.surcharges!.map((v) => v.toJson()).toList();
    // }
    data['currency'] = this.currency;
    return data;
  }
}

class OperationalDetail {
  List<String>? originLocationIds;
  List<int>? originLocationNumbers;
  List<String>? originServiceAreas;
  List<String>? destinationLocationIds;
  List<int>? destinationLocationNumbers;
  List<String>? destinationServiceAreas;
  bool? ineligibleForMoneyBackGuarantee;
  dynamic astraDescription;
  List<String>? originPostalCodes;
  List<String>? countryCodes;
  dynamic airportId;
  dynamic serviceCode;
  dynamic destinationPostalCode;

  OperationalDetail(
      {this.originLocationIds,
      this.originLocationNumbers,
      this.originServiceAreas,
      this.destinationLocationIds,
      this.destinationLocationNumbers,
      this.destinationServiceAreas,
      this.ineligibleForMoneyBackGuarantee,
      this.astraDescription,
      this.originPostalCodes,
      this.countryCodes,
      this.airportId,
      this.serviceCode,
      this.destinationPostalCode});

  OperationalDetail.fromJson(Map<String, dynamic> json) {
    originLocationIds = json['originLocationIds'].cast<String>();
    originLocationNumbers = json['originLocationNumbers'].cast<int>();
    originServiceAreas = json['originServiceAreas'].cast<String>();
    destinationLocationIds = json['destinationLocationIds'].cast<String>();
    destinationLocationNumbers = json['destinationLocationNumbers'].cast<int>();
    destinationServiceAreas = json['destinationServiceAreas'].cast<String>();
    ineligibleForMoneyBackGuarantee = json['ineligibleForMoneyBackGuarantee'];
    astraDescription = json['astraDescription'];
    originPostalCodes = json['originPostalCodes'].cast<String>();
    countryCodes = json['countryCodes'].cast<String>();
    airportId = json['airportId'];
    serviceCode = json['serviceCode'];
    destinationPostalCode = json['destinationPostalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originLocationIds'] = this.originLocationIds;
    data['originLocationNumbers'] = this.originLocationNumbers;
    data['originServiceAreas'] = this.originServiceAreas;
    data['destinationLocationIds'] = this.destinationLocationIds;
    data['destinationLocationNumbers'] = this.destinationLocationNumbers;
    data['destinationServiceAreas'] = this.destinationServiceAreas;
    data['ineligibleForMoneyBackGuarantee'] = this.ineligibleForMoneyBackGuarantee;
    data['astraDescription'] = this.astraDescription;
    data['originPostalCodes'] = this.originPostalCodes;
    data['countryCodes'] = this.countryCodes;
    data['airportId'] = this.airportId;
    data['serviceCode'] = this.serviceCode;
    data['destinationPostalCode'] = this.destinationPostalCode;
    return data;
  }
}

class ServiceDescription {
  dynamic serviceId;
  dynamic serviceType;
  dynamic code;
  List<Names>? names;
  dynamic serviceCategory;
  dynamic description;
  dynamic astraDescription;

  ServiceDescription(
      {this.serviceId,
      this.serviceType,
      this.code,
      this.names,
      this.serviceCategory,
      this.description,
      this.astraDescription});

  ServiceDescription.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceType = json['serviceType'];
    code = json['code'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names!.add(new Names.fromJson(v));
      });
    }
    serviceCategory = json['serviceCategory'];
    description = json['description'];
    astraDescription = json['astraDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['serviceType'] = this.serviceType;
    data['code'] = this.code;
    if (this.names != null) {
      data['names'] = this.names!.map((v) => v.toJson()).toList();
    }
    data['serviceCategory'] = this.serviceCategory;
    data['description'] = this.description;
    data['astraDescription'] = this.astraDescription;
    return data;
  }
}

class Names {
  dynamic type;
  dynamic encoding;
  dynamic value;

  Names({this.type, this.encoding, this.value});

  Names.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    encoding = json['encoding'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['encoding'] = this.encoding;
    data['value'] = this.value;
    return data;
  }
}

class ShippingPolicy {
  dynamic id;
  dynamic vendorId;
  dynamic title;
  dynamic days;
  dynamic description;
  dynamic shippingType;
  Null freeFor;
  Null aboveShipping;
  Null shippingZone;
  Null range1Min;
  Null range1Max;
  Null range1Percent;
  Null range2Min;
  Null range2Max;
  Null range2Percent;
  Null priceLimit;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;

  ShippingPolicy(
      {this.id,
      this.vendorId,
      this.title,
      this.days,
      this.description,
      this.shippingType,
      this.freeFor,
      this.aboveShipping,
      this.shippingZone,
      this.range1Min,
      this.range1Max,
      this.range1Percent,
      this.range2Min,
      this.range2Max,
      this.range2Percent,
      this.priceLimit,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  ShippingPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    days = json['days'];
    description = json['description'];
    shippingType = json['shipping_type'];
    freeFor = json['free_for'];
    aboveShipping = json['above_shipping'];
    shippingZone = json['shipping_zone'];
    range1Min = json['range1_min'];
    range1Max = json['range1_max'];
    range1Percent = json['range1_percent'];
    range2Min = json['range2_min'];
    range2Max = json['range2_max'];
    range2Percent = json['range2_percent'];
    priceLimit = json['price_limit'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['description'] = this.description;
    data['shipping_type'] = this.shippingType;
    data['free_for'] = this.freeFor;
    data['above_shipping'] = this.aboveShipping;
    data['shipping_zone'] = this.shippingZone;
    data['range1_min'] = this.range1Min;
    data['range1_max'] = this.range1Max;
    data['range1_percent'] = this.range1Percent;
    data['range2_min'] = this.range2Min;
    data['range2_max'] = this.range2Max;
    data['range2_percent'] = this.range2Percent;
    data['price_limit'] = this.priceLimit;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
