class BookingResponse {
  int? status;
  bool? success;
  String? message;
  String? bookingId;
  RzpOrder? rzpOrder;

  BookingResponse(
      {this.status, this.success, this.message, this.bookingId, this.rzpOrder});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    bookingId = json['bookingId'];
    rzpOrder = json['rzpOrder'] != null
        ? new RzpOrder.fromJson(json['rzpOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    data['bookingId'] = this.bookingId;
    if (this.rzpOrder != null) {
      data['rzpOrder'] = this.rzpOrder!.toJson();
    }
    return data;
  }
}

class RzpOrder {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? offerId;
  String? status;
  int? attempts;
  Notes? notes;
  int? createdAt;

  RzpOrder(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.offerId,
      this.status,
      this.attempts,
      this.notes,
      this.createdAt});

  RzpOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    status = json['status'];
    attempts = json['attempts'];
    notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['offer_id'] = this.offerId;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Notes {
  String? notesKey1;
  String? notesKey2;

  Notes({this.notesKey1, this.notesKey2});

  Notes.fromJson(Map<String, dynamic> json) {
    notesKey1 = json['notes_key_1'];
    notesKey2 = json['notes_key_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_key_1'] = this.notesKey1;
    data['notes_key_2'] = this.notesKey2;
    return data;
  }
}
