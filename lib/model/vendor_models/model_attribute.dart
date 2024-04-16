class ModelAttributes {
  bool? status;
  String? message;
  List<AttributeData>? data;
  Map<String, GetAttrvalues> attributeMap = {};



  List<GetAttrvalues> get getAllAttributes{
    List<GetAttrvalues> kk = [];
    data!.map((e) => e.getAttrvalues ?? []).toList().forEach((element) {
      kk.addAll(element);
    });
    return kk;
  }

  ModelAttributes({this.status, this.message, this.data});

  ModelAttributes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AttributeData>[];
      json['data'].forEach((v) {
        data!.add(AttributeData.fromJson(v));
      });
    }
    for (var element in getAllAttributes) {
      attributeMap[element.id.toString()] = element;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeData {
  int? id;
  String? name;
  String? arabName;
  String? slug;
  String? createdAt;
  String? updatedAt;
  List<GetAttrvalues>? getAttrvalues;

  AttributeData(
      {this.id,
        this.name,
        this.arabName,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.getAttrvalues});

  AttributeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arabName = json['arab_name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_attrvalues'] != null) {
      getAttrvalues = <GetAttrvalues>[];
      json['get_attrvalues'].forEach((v) {
        getAttrvalues!.add(GetAttrvalues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['arab_name'] = arabName;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (getAttrvalues != null) {
      data['get_attrvalues'] =
          getAttrvalues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAttrvalues {
  String aboveParentSlug = "";
  int? id;
  bool selectedVariant = false;
  int? attrId;
  String? attrValueName;
  String? arabName;
  String? slug;
  String? createdAt;
  String? updatedAt;

  GetAttrvalues(
      {this.id,
        this.attrId,
        this.attrValueName,
        this.arabName,
        this.slug,
        this.createdAt,
        this.updatedAt});

  GetAttrvalues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attrId = json['attr_id'];
    attrValueName = json['attr_value_name'];
    arabName = json['arab_name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  GetAttrvalues.fromJsonItself(Map<String, dynamic> json, String aboveSlug) {
    aboveParentSlug = aboveSlug;
    id = json['id'];
    attrId = json['attr_id'];
    attrValueName = json['attr_value_name'];
    arabName = json['arab_name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aboveParentSlug'] = aboveParentSlug;
    data['attr_id'] = attrId;
    data['attr_value_name'] = attrValueName;
    data['arab_name'] = arabName;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
