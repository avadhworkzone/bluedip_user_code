class AddPaymentReqModel {
  String? action;
  String? orderId;
  String? restaurantId;
  String? subTotal;
  String? grandTotal;
  String? gst;
  String? cgst;
  String? sgst;
  String? gstAmount;
  String? netPayable;
  String? items;
  String? savings;
  String? packingCharges;

  AddPaymentReqModel(
      {this.action,
      this.orderId,
      this.restaurantId,
      this.subTotal,
      this.grandTotal,
      this.gst,
      this.cgst,
      this.sgst,
      this.gstAmount,
      this.netPayable,
      this.items,
      this.savings,
      this.packingCharges});

  AddPaymentReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    orderId = json['order_id'];
    restaurantId = json['restaurant_id'];
    subTotal = json['sub_total'];
    grandTotal = json['grand_total'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    gstAmount = json['gst_amount'];
    netPayable = json['net_payable'];
    items = json['items'];
    savings = json['savings'];
    packingCharges = json['packing_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['order_id'] = this.orderId;
    data['restaurant_id'] = this.restaurantId;
    data['sub_total'] = this.subTotal;
    data['grand_total'] = this.grandTotal;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['gst_amount'] = this.gstAmount;
    data['net_payable'] = this.netPayable;
    data['items'] = this.items;
    data['savings'] = this.savings;
    data['packing_charges'] = this.packingCharges;
    return data;
  }
}
