class ServiceModel {
  final String id;
  final String bus_id;
  final String service_title;
  final String service_price;
  final String promo_code;
  final double convenience_fee;
  final String service_discount;
  final String business_approxtime;
  final String categories;
  final String image;

  ServiceModel(
      this.id,
      this.bus_id,
      this.service_title,
      this.service_price,
      this.promo_code,
      this.convenience_fee,
      this.service_discount,
      this.business_approxtime,
      this.categories,
      this.image);
}
