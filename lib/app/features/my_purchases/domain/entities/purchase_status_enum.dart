enum PurchaseStatusEnum {
  listed,
  processingPayment,
  approvedPayment,
  pickedUp,
  onCourse,
  delivered,
  unknown;

  static PurchaseStatusEnum fromString(String status) {
    switch (status) {
      case 'listed':
        return PurchaseStatusEnum.listed;
      case 'processingPayment':
        return PurchaseStatusEnum.processingPayment;
      case 'approvedPayment':
        return PurchaseStatusEnum.approvedPayment;
      case 'pickedUp':
        return PurchaseStatusEnum.pickedUp;
      case 'onCourse':
        return PurchaseStatusEnum.onCourse;
      case 'delivered':
        return PurchaseStatusEnum.delivered;
      default:
        return PurchaseStatusEnum.unknown;
    }
  }
}
