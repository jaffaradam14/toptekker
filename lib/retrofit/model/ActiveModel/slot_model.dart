class SlotModel {
  final String slot;
  final String slot_label;
  final String interval;
  final String booking_id;
  final bool is_booked;
  final String price;
  final int time_token;
  final String type;
  bool isSelected;

  SlotModel(this.slot, this.slot_label, this.interval, this.booking_id,
      this.is_booked, this.price, this.time_token, this.type, this.isSelected);
}
