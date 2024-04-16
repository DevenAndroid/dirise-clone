import 'package:dirise/utils/helper.dart';
import 'package:collection/collection.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
class ModelCartResponse {
  dynamic status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
  Cart? cart;
  // String get totalProducts2 => cart!.getAllProducts.map((e) => e.map((e1) => e1.products!.map((e2) => e2.qty).toString().toNum).toList().getTotal).toList().getTotal.toString();
  dynamic totalProducts;



  ModelCartResponse(
      {this.status,
        this.message,
        this.subtotal,
        this.shipping,
        this.total,
        this.discount,
        this.cart});

  ModelCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    discount = json['discount'];
    cart = json['cart'] != null && json['cart'].toString() != "[]" ? Cart.fromJson(json['cart']) : Cart(carsShowroom: {});
    // cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;

    int a = 0;
    for(var item in cart!.carsShowroom!.entries.map((e) => e.value.products!)){
      for(var item1 in item ){
        a = a + int.parse(item1.qty.toString());
      }
    }
    cart != null ? totalProducts = a.toString() : totalProducts = '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    data['total'] = total;
    data['discount'] = discount;
    // if (cart != null) {
    //   data['cart'] = cart!.toJson();
    // }
    return data;
  }
}

class Cart {
  Map<String, StoreData>? carsShowroom = {};

  Cart({this.carsShowroom});

  Cart.fromJson(Map<String, dynamic> json) {
    for (var element in json.entries) {
      carsShowroom![element.key] = StoreData.fromJson(element.value);
    }
    // carsShowroom = json['cars showroom'] != null
    //     ? StoreData.fromJson(json['cars showroom'])
    //     : null;
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   if (carsShowroom != null) {
//     data['cars showroom'] = carsShowroom!.toJson();
//   }
//   return data;
// }
}

class StoreData {
  List<Products>? products;
  List<ShippingTypes>? shippingTypes;
  FedexShipping? fedexShipping;
  RxString fedexShippingOption = "".obs;
  List<ShippingTypes>? selectedContacts;
  RxString shippingOption = "".obs;
  RxInt shippingId = 0.obs;
  RxString shippingVendorName = "".obs;
  RxString vendorPrice = "".obs;
  RxInt vendorId = 0.obs;

  StoreData({this.products, this.shippingTypes});

  StoreData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['shipping_types'] != null) {
      shippingTypes = <ShippingTypes>[];
      json['shipping_types'].forEach((v) {
        shippingTypes!.add(ShippingTypes.fromJson(v));
      });
    }
    fedexShipping = json['fedex_shipping'] != null ? FedexShipping.fromJson(json['fedex_shipping']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (shippingTypes != null) {
      data['shipping_types'] =
          shippingTypes!.map((v) => v.toJson()).toList();
    }
    data['fedex_shipping'] = fedexShipping!.toJson();
    return data;
  }
}

class FedexShipping {
  dynamic transactionId;
  Output? output;

  FedexShipping({this.transactionId, this.output});

  FedexShipping.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    output = json['output'] != null ? Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['transactionId'] = transactionId;
    if (output != null) {
      data['output'] = output!.toJson();
    }
    return data;
  }
}

class Output {
  List<Alerts>? alerts;
  List<RateReplyDetails>? rateReplyDetails;
  dynamic quoteDate;
  dynamic encoded;

  Output({this.alerts, this.rateReplyDetails, this.quoteDate, this.encoded});

  Output.fromJson(Map<String, dynamic> json) {
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) { alerts!.add(Alerts.fromJson(v)); });
    }
    if (json['rateReplyDetails'] != null) {
      rateReplyDetails = <RateReplyDetails>[];
      json['rateReplyDetails'].forEach((v) { rateReplyDetails!.add(RateReplyDetails.fromJson(v)); });
    }
    quoteDate = json['quoteDate'];
    encoded = json['encoded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    if (rateReplyDetails != null) {
      data['rateReplyDetails'] = rateReplyDetails!.map((v) => v.toJson()).toList();
    }
    data['quoteDate'] = quoteDate;
    data['encoded'] = encoded;
    return data;
  }
}
class Alerts {
  dynamic code;
  dynamic message;
  dynamic alertType;

  Alerts({this.code, this.message, this.alertType});

  Alerts.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    alertType = json['alertType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['alertType'] = alertType;
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

  RateReplyDetails({this.serviceType, this.serviceName, this.packagingType, this.commit, this.customerMessages, this.ratedShipmentDetails, this.operationalDetail, this.signatureOptionType, this.serviceDescription, this.deliveryStation});

  RateReplyDetails.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    serviceName = json['serviceName'];
    packagingType = json['packagingType'];
    commit = json['commit'] != null ? Commit.fromJson(json['commit']) : null;
    if (json['customerMessages'] != null) {
      customerMessages = <CustomerMessages>[];
      json['customerMessages'].forEach((v) { customerMessages!.add(CustomerMessages.fromJson(v)); });
    }
    if (json['ratedShipmentDetails'] != null) {
      ratedShipmentDetails = <RatedShipmentDetails>[];
      json['ratedShipmentDetails'].forEach((v) { ratedShipmentDetails!.add(RatedShipmentDetails.fromJson(v)); });
    }
    operationalDetail = json['operationalDetail'] != null ? OperationalDetail.fromJson(json['operationalDetail']) : null;
    signatureOptionType = json['signatureOptionType'];
    serviceDescription = json['serviceDescription'] != null ? ServiceDescription.fromJson(json['serviceDescription']) : null;
    deliveryStation = json['deliveryStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceType'] = serviceType;
    data['serviceName'] = serviceName;
    data['packagingType'] = packagingType;
    if (commit != null) {
      data['commit'] = commit!.toJson();
    }
    if (customerMessages != null) {
      data['customerMessages'] = customerMessages!.map((v) => v.toJson()).toList();
    }
    if (ratedShipmentDetails != null) {
      data['ratedShipmentDetails'] = ratedShipmentDetails!.map((v) => v.toJson()).toList();
    }
    if (operationalDetail != null) {
      data['operationalDetail'] = operationalDetail!.toJson();
    }
    data['signatureOptionType'] = signatureOptionType;
    if (serviceDescription != null) {
      data['serviceDescription'] = serviceDescription!.toJson();
    }
    data['deliveryStation'] = deliveryStation;
    return data;
  }
}

class Commit {
  dynamic label;
  dynamic commitMessageDetails;
  dynamic commodityName;
  List<String>? deliveryMessages;
  DerivedOriginDetail? derivedOriginDetail;
  DerivedDestinationDetail? derivedDestinationDetail;
  dynamic saturdayDelivery;

  Commit({this.label, this.commitMessageDetails, this.commodityName, this.deliveryMessages, this.derivedOriginDetail, this.derivedDestinationDetail, this.saturdayDelivery});

  Commit.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    commitMessageDetails = json['commitMessageDetails'];
    commodityName = json['commodityName'];
    deliveryMessages = json['deliveryMessages'].cast<String>();
    derivedOriginDetail = json['derivedOriginDetail'] != null ? DerivedOriginDetail.fromJson(json['derivedOriginDetail']) : null;
    derivedDestinationDetail = json['derivedDestinationDetail'] != null ? DerivedDestinationDetail.fromJson(json['derivedDestinationDetail']) : null;
    saturdayDelivery = json['saturdayDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = label;
    data['commitMessageDetails'] = commitMessageDetails;
    data['commodityName'] = commodityName;
    data['deliveryMessages'] = deliveryMessages;
    if (derivedOriginDetail != null) {
      data['derivedOriginDetail'] = derivedOriginDetail!.toJson();
    }
    if (derivedDestinationDetail != null) {
      data['derivedDestinationDetail'] = derivedDestinationDetail!.toJson();
    }
    data['saturdayDelivery'] = saturdayDelivery;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['postalCode'] = postalCode;
    data['serviceArea'] = serviceArea;
    data['locationId'] = locationId;
    data['locationNumber'] = locationNumber;
    return data;
  }
}

class DerivedDestinationDetail {
  dynamic countryCode;
  dynamic stateOrProvinceCode;
  dynamic postalCode;
  dynamic serviceArea;
  dynamic locationId;
  dynamic locationNumber;
  dynamic airportId;

  DerivedDestinationDetail({this.countryCode, this.stateOrProvinceCode, this.postalCode, this.serviceArea, this.locationId, this.locationNumber, this.airportId});

  DerivedDestinationDetail.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    stateOrProvinceCode = json['stateOrProvinceCode'];
    postalCode = json['postalCode'];
    serviceArea = json['serviceArea'];
    locationId = json['locationId'];
    locationNumber = json['locationNumber'];
    airportId = json['airportId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['stateOrProvinceCode'] = stateOrProvinceCode;
    data['postalCode'] = postalCode;
    data['serviceArea'] = serviceArea;
    data['locationId'] = locationId;
    data['locationNumber'] = locationNumber;
    data['airportId'] = airportId;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
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
  dynamic currency;

  RatedShipmentDetails({this.rateType, this.ratedWeightMethod, this.totalDiscounts, this.totalBaseCharge, this.totalNetCharge, this.totalVatCharge, this.totalNetFedExCharge, this.totalDutiesAndTaxes, this.totalNetChargeWithDutiesAndTaxes, this.totalDutiesTaxesAndFees, this.totalAncillaryFeesAndTaxes, this.shipmentRateDetail, this.currency});

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
    shipmentRateDetail = json['shipmentRateDetail'] != null ? ShipmentRateDetail.fromJson(json['shipmentRateDetail']) : null;
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rateType'] = rateType;
    data['ratedWeightMethod'] = ratedWeightMethod;
    data['totalDiscounts'] = totalDiscounts;
    data['totalBaseCharge'] = totalBaseCharge;
    data['totalNetCharge'] = totalNetCharge;
    data['totalVatCharge'] = totalVatCharge;
    data['totalNetFedExCharge'] = totalNetFedExCharge;
    data['totalDutiesAndTaxes'] = totalDutiesAndTaxes;
    data['totalNetChargeWithDutiesAndTaxes'] = totalNetChargeWithDutiesAndTaxes;
    data['totalDutiesTaxesAndFees'] = totalDutiesTaxesAndFees;
    data['totalAncillaryFeesAndTaxes'] = totalAncillaryFeesAndTaxes;
    if (shipmentRateDetail != null) {
      data['shipmentRateDetail'] = shipmentRateDetail!.toJson();
    }
    data['currency'] = currency;
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

  ShipmentRateDetail({this.rateZone, this.dimDivisor, this.fuelSurchargePercent, this.totalSurcharges, this.totalFreightDiscount, this.freightDiscount, this.surCharges, this.pricingCode, this.currencyExchangeRate, this.totalBillingWeight, this.dimDivisorType, this.currency, this.rateScale, this.totalRateScaleWeight});

  ShipmentRateDetail.fromJson(Map<String, dynamic> json) {
    rateZone = json['rateZone'];
    dimDivisor = json['dimDivisor'];
    fuelSurchargePercent = json['fuelSurchargePercent'];
    totalSurcharges = json['totalSurcharges'];
    totalFreightDiscount = json['totalFreightDiscount'];
    if (json['freightDiscount'] != null) {
      freightDiscount = <FreightDiscount>[];
      json['freightDiscount'].forEach((v) { freightDiscount!.add(FreightDiscount.fromJson(v)); });
    }
    if (json['surCharges'] != null) {
      surCharges = <SurCharges>[];
      json['surCharges'].forEach((v) { surCharges!.add(SurCharges.fromJson(v)); });
    }
    pricingCode = json['pricingCode'];
    currencyExchangeRate = json['currencyExchangeRate'] != null ? CurrencyExchangeRate.fromJson(json['currencyExchangeRate']) : null;
    totalBillingWeight = json['totalBillingWeight'] != null ? TotalBillingWeight.fromJson(json['totalBillingWeight']) : null;
    dimDivisorType = json['dimDivisorType'];
    currency = json['currency'];
    rateScale = json['rateScale'];
    totalRateScaleWeight = json['totalRateScaleWeight'] != null ? TotalBillingWeight.fromJson(json['totalRateScaleWeight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rateZone'] = rateZone;
    data['dimDivisor'] = dimDivisor;
    data['fuelSurchargePercent'] = fuelSurchargePercent;
    data['totalSurcharges'] = totalSurcharges;
    data['totalFreightDiscount'] = totalFreightDiscount;
    if (freightDiscount != null) {
      data['freightDiscount'] = freightDiscount!.map((v) => v.toJson()).toList();
    }
    if (surCharges != null) {
      data['surCharges'] = surCharges!.map((v) => v.toJson()).toList();
    }
    data['pricingCode'] = pricingCode;
    if (currencyExchangeRate != null) {
      data['currencyExchangeRate'] = currencyExchangeRate!.toJson();
    }
    if (totalBillingWeight != null) {
      data['totalBillingWeight'] = totalBillingWeight!.toJson();
    }
    data['dimDivisorType'] = dimDivisorType;
    data['currency'] = currency;
    data['rateScale'] = rateScale;
    if (totalRateScaleWeight != null) {
      data['totalRateScaleWeight'] = totalRateScaleWeight!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['description'] = description;
    data['amount'] = amount;
    data['percent'] = percent;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['description'] = description;
    data['level'] = level;
    data['amount'] = amount;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fromCurrency'] = fromCurrency;
    data['intoCurrency'] = intoCurrency;
    data['rate'] = rate;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['units'] = units;
    data['value'] = value;
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
  List<String>? destinationLocationStateOrProvinceCodes;
  dynamic ineligibleForMoneyBackGuarantee;
  dynamic astraDescription;
  List<String>? originPostalCodes;
  List<String>? countryCodes;
  dynamic deliveryDate;
  dynamic deliveryDay;
  dynamic airportId;
  dynamic serviceCode;
  dynamic destinationPostalCode;

  OperationalDetail({this.originLocationIds, this.deliveryDate,this.deliveryDay,this.originLocationNumbers, this.originServiceAreas, this.destinationLocationIds, this.destinationLocationNumbers, this.destinationServiceAreas, this.destinationLocationStateOrProvinceCodes, this.ineligibleForMoneyBackGuarantee, this.astraDescription, this.originPostalCodes, this.countryCodes, this.airportId, this.serviceCode, this.destinationPostalCode});

  OperationalDetail.fromJson(Map<String, dynamic> json) {
    originLocationIds = json['originLocationIds'].cast<String>();
    originLocationNumbers = json['originLocationNumbers'].cast<int>();
    originServiceAreas = json['originServiceAreas'].cast<String>();
    destinationLocationIds = json['destinationLocationIds'].cast<String>();
    destinationLocationNumbers = json['destinationLocationNumbers'].cast<int>();
    destinationServiceAreas = json['destinationServiceAreas'].cast<String>();
    destinationLocationStateOrProvinceCodes = json['destinationLocationStateOrProvinceCodes'].cast<String>();
    ineligibleForMoneyBackGuarantee = json['ineligibleForMoneyBackGuarantee'];
    astraDescription = json['astraDescription'];
    originPostalCodes = json['originPostalCodes'].cast<String>();
    countryCodes = json['countryCodes'].cast<String>();
    airportId = json['airportId'];
    serviceCode = json['serviceCode'];
    deliveryDate = json['deliveryDate'];
    deliveryDay = json['deliveryDay'];
    destinationPostalCode = json['destinationPostalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['originLocationIds'] = originLocationIds;
    data['originLocationNumbers'] = originLocationNumbers;
    data['originServiceAreas'] = originServiceAreas;
    data['destinationLocationIds'] = destinationLocationIds;
    data['destinationLocationNumbers'] = destinationLocationNumbers;
    data['destinationServiceAreas'] = destinationServiceAreas;
    data['destinationLocationStateOrProvinceCodes'] = destinationLocationStateOrProvinceCodes;
    data['ineligibleForMoneyBackGuarantee'] = ineligibleForMoneyBackGuarantee;
    data['astraDescription'] = astraDescription;
    data['originPostalCodes'] = originPostalCodes;
    data['countryCodes'] = countryCodes;
    data['deliveryDate'] = deliveryDate;
    data['deliveryDay'] = deliveryDay;
    data['airportId'] = airportId;
    data['serviceCode'] = serviceCode;
    data['destinationPostalCode'] = destinationPostalCode;
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

  ServiceDescription({this.serviceId, this.serviceType, this.code, this.names, this.serviceCategory, this.description, this.astraDescription});

  ServiceDescription.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceType = json['serviceType'];
    code = json['code'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) { names!.add(Names.fromJson(v)); });
    }
    serviceCategory = json['serviceCategory'];
    description = json['description'];
    astraDescription = json['astraDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceId'] = serviceId;
    data['serviceType'] = serviceType;
    data['code'] = code;
    if (names != null) {
      data['names'] = names!.map((v) => v.toJson()).toList();
    }
    data['serviceCategory'] = serviceCategory;
    data['description'] = description;
    data['astraDescription'] = astraDescription;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['encoding'] = encoding;
    data['value'] = value;
    return data;
  }
}
class Products {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic catId2;
  dynamic catId3;
  dynamic brandSlug;
  dynamic slug;
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
  dynamic shippingType;
  dynamic shippingCharge;
  dynamic avgRating;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  dynamic parentId;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic serviceDuration;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic limitedTimeDeal;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;
  dynamic cartId;
  dynamic selectedSloatStart;
  dynamic selectedSloatEnd;
  dynamic selectedSloatDate;
  dynamic qty;
  dynamic isShipping;
  dynamic localShipping;
  dynamic inCart;
  dynamic inWishlist;
  dynamic currencySign;
  dynamic currencyCode;
  List<dynamic>? variantsComb;
  List<dynamic>? attributes;
  List<dynamic>? variants;
  dynamic vendorCountryId;

  Products(
      {this.id,
        this.vendorId,
        this.catId,
        this.catId2,
        this.catId3,
        this.brandSlug,
        this.slug,
        this.pname,
        this.prodectImage,
        this.prodectName,
        this.prodectSku,
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
        this.shippingType,
        this.shippingCharge,
        this.avgRating,
        this.metaTitle,
        this.metaKeyword,
        this.metaDescription,
        this.parentId,
        this.serviceStartTime,
        this.serviceEndTime,
        this.serviceDuration,
        this.createdAt,
        this.updatedAt,
        this.topHunderd,
        this.limitedTimeDeal,
        this.returnDays,
        this.isPublish,
        this.inOffer,
        this.forAuction,
        this.returnPolicyDesc,
        this.cartId,
        this.selectedSloatStart,
        this.selectedSloatEnd,
        this.selectedSloatDate,
        this.qty,
        this.isShipping,
        this.inCart,
        this.inWishlist,
        this.currencySign,
        this.currencyCode,
        this.variantsComb,
        this.localShipping,
        this.attributes,
        this.vendorCountryId,
        this.variants});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    catId3 = json['cat_id_3'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    prodectImage = json['prodect_image'];
    prodectName = json['prodect_name'];
    prodectSku = json['prodect_sku'];
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
    shippingType = json['shipping_type'];
    shippingCharge = json['shipping_charge'];
    avgRating = json['avg_rating'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    parentId = json['parent_id'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    serviceDuration = json['service_duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topHunderd = json['top_hunderd'];
    limitedTimeDeal = json['limited_time_deal'];
    returnDays = json['return_days'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
    returnPolicyDesc = json['return_policy_desc'];
    cartId = json['cart_id'];
    selectedSloatStart = json['selected_sloat_start'];
    selectedSloatEnd = json['selected_sloat_end'];
    selectedSloatDate = json['selected_sloat_date'];
    qty = json['qty'];
    isShipping = json['is_shipping'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
    currencySign = json['currency_sign'];
    currencyCode = json['currency_code'];
    localShipping = json['local_shipping'];
    vendorCountryId = json['vendor_country_id'];
    // if (json['variants_comb'] != null) {
    //   variantsComb = <Null>[];
    //   json['variants_comb'].forEach((v) {
    //     variantsComb!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['variants'] != null) {
    //   variants = <Null>[];
    //   json['variants'].forEach((v) {
    //     variants!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['cat_id_2'] = catId2;
    data['cat_id_3'] = catId3;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pname;
    data['prodect_image'] = prodectImage;
    data['prodect_name'] = prodectName;
    data['prodect_sku'] = prodectSku;
    data['views'] = views;
    data['code'] = code;
    data['booking_product_type'] = bookingProductType;
    data['prodect_price'] = prodectPrice;
    data['prodect_min_qty'] = prodectMinQty;
    data['prodect_mix_qty'] = prodectMixQty;
    data['prodect_description'] = prodectDescription;
    data['image'] = image;
    data['arab_pname'] = arabPname;
    data['product_type'] = productType;
    data['virtual_product_type'] = virtualProductType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['commission'] = commission;
    data['best_saller'] = bestSaller;
    data['featured'] = featured;
    data['tax_apply'] = taxApply;
    data['tax_type'] = taxType;
    data['short_description'] = shortDescription;
    data['arab_short_description'] = arabShortDescription;
    data['long_description'] = longDescription;
    data['arab_long_description'] = arabLongDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['virtual_product_file_language'] = virtualProductFileLanguage;
    data['feature_image_app'] = featureImageApp;
    data['feature_image_web'] = featureImageWeb;
    data['in_stock'] = inStock;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['time'] = time;
    data['time_period'] = timePeriod;
    data['stock_alert'] = stockAlert;
    data['shipping_type'] = shippingType;
    data['shipping_charge'] = shippingCharge;
    data['avg_rating'] = avgRating;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['meta_description'] = metaDescription;
    data['parent_id'] = parentId;
    data['service_start_time'] = serviceStartTime;
    data['service_end_time'] = serviceEndTime;
    data['service_duration'] = serviceDuration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_hunderd'] = topHunderd;
    data['limited_time_deal'] = limitedTimeDeal;
    data['return_days'] = returnDays;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    data['return_policy_desc'] = returnPolicyDesc;
    data['cart_id'] = cartId;
    data['selected_sloat_start'] = selectedSloatStart;
    data['selected_sloat_end'] = selectedSloatEnd;
    data['selected_sloat_date'] = selectedSloatDate;
    data['qty'] = qty;
    data['is_shipping'] = isShipping;
    data['in_cart'] = inCart;
    data['in_wishlist'] = inWishlist;
    data['currency_sign'] = currencySign;
    data['currency_code'] = currencyCode;
    data['local_shipping'] = localShipping;
    data['vendor_country_id'] = vendorCountryId;
    // if (this.variantsComb != null) {
    //   data['variants_comb'] =
    //       this.variantsComb!.map((v) => v.toJson()).toList();
    // }
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    // }
    // if (this.variants != null) {
    //   data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class ShippingTypes {
  dynamic id;
  dynamic name;
  dynamic value;
  dynamic vendorId;
  bool check = false;


  ShippingTypes({this.id, this.name, this.value,this.vendorId});

  ShippingTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['vendor_id'] = vendorId;
    return data;
  }
}
