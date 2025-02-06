class Output {
  final int id;
  final String type;
  final int price;

  Output({required this.id, required this.type, required this.price});

  factory Output.fromjson(Map<String, dynamic> json) {
    return Output(
        id: json['id'], type: json['output_type'], price: json['price']);
  }
}
