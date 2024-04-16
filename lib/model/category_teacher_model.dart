// class CategoryTeacherModel {
//   bool? status;
//   String? message;
//   List<User>? user;
//   String? categoryName;
//   List<Null>? product;
//
//   CategoryTeacherModel(
//       {this.status, this.message, this.user, this.categoryName, this.product});
//
//   CategoryTeacherModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['user'] != null) {
//       user = <User>[];
//       json['user'].forEach((v) {
//         user!.add(new User.fromJson(v));
//       });
//     }
//     categoryName = json['category_name'];
//     if (json['product'] != null) {
//       product = <Null>[];
//
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.user != null) {
//       data['user'] = this.user!.map((v) => v.toJson()).toList();
//     }
//     data['category_name'] = this.categoryName;
//
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? storeLogo;
//   String? storeImage;
//   String? storeName;
//   String? email;
//   int? storePhone;
//   String? description;
//
//   User(
//       {this.id,
//         this.storeLogo,
//         this.storeImage,
//         this.storeName,
//         this.email,
//         this.storePhone,
//         this.description});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storeLogo = json['store_logo'];
//     storeImage = json['store_image'];
//     storeName = json['store_name'];
//     email = json['email'];
//     storePhone = json['store_phone'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['store_logo'] = this.storeLogo;
//     data['store_image'] = this.storeImage;
//     data['store_name'] = this.storeName;
//     data['email'] = this.email;
//     data['store_phone'] = this.storePhone;
//     data['description'] = this.description;
//     return data;
//   }
// }
