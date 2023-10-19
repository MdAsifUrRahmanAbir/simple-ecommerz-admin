class OrderModel{
  final String orderId;
  final String orderStatus;
  final String productName;
  final String productId;
  final String productPrice;
  final String customerAddress;

  OrderModel( {required this.orderStatus, required this.orderId, required this.productId, required this.productName, required this.productPrice, required this.customerAddress});
}

List<OrderModel> orders = [
  OrderModel(orderId: "1", productId: "1001", productName: "Mac", productPrice: "2000 USD", customerAddress: "Customer Address", orderStatus: 'Pending'),
  OrderModel(orderId: "2", productId: "1002", productName: "PC", productPrice: "1000 USD", customerAddress: "Customer Address", orderStatus: 'On The Way'),
  OrderModel(orderId: "3", productId: "1003", productName: "Phone", productPrice: "400 USD", customerAddress: "Customer Address", orderStatus: 'Delivered'),
];