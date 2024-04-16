class HomeModal {
  bool? status;
  dynamic message;
  Home? home;

  HomeModal({this.status, this.message, this.home});

  HomeModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (home != null) {
      data['home'] = home!.toJson();
    }
    return data;
  }
}

class Home {
  dynamic content;
  List<Slider>? slider;
  dynamic bannerImg;
  dynamic saleBannerAltTag;
  dynamic saleBannerUrl;

  Home({this.content, this.slider, this.bannerImg, this.saleBannerAltTag, this.saleBannerUrl});

  Home.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(Slider.fromJson(v));
      });
    }
    bannerImg = json['banner_img'];
    saleBannerAltTag = json['sale_banner_alt_tag'];
    saleBannerUrl = json['sale_banner_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    if (slider != null) {
      data['slider'] = slider!.map((v) => v.toJson()).toList();
    }
    data['banner_img'] = bannerImg;
    data['sale_banner_alt_tag'] = saleBannerAltTag;
    data['sale_banner_url'] = saleBannerUrl;
    return data;
  }
}

class Slider {
  dynamic image;
  dynamic bannerMobile;
  dynamic url;
  dynamic sliderAlt;

  Slider({this.image, this.bannerMobile, this.url, this.sliderAlt});

  Slider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    bannerMobile = json['banner_mobile'];
    url = json['url'];
    sliderAlt = json['slider_alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['banner_mobile'] = bannerMobile;
    data['url'] = url;
    data['slider_alt'] = sliderAlt;
    return data;
  }
}
