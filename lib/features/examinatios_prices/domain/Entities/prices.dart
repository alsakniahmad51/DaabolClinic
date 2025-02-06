class Prices {
  final int priceId;
  final String descreption;
  final int price;
  Prices({
    required this.priceId,
    required this.descreption,
    required this.price,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
        priceId: json['price_id'],
        descreption: json['description'],
        price: json['price']);
  }
}
