class HistoryModel {
  final bool status;
  final String message;
  final List<HistoryData> data;

  const HistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List).map((e) => HistoryData.fromJson(e)).toList(),
    );
  }
}

class HistoryData {
  final String payment;
  final String paidOn;
  final String slotDateTime;
  final String day;
  final String status;
  final String consulationFee;
  final String doctorName;
  final String doctorImage;

  const HistoryData({
    required this.payment,
    required this.paidOn,
    required this.slotDateTime,
    required this.day,
    required this.status,
    required this.consulationFee,
    required this.doctorName,
    required this.doctorImage,
  });
  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      payment: json['payment'],
      paidOn: json['paid_on'],
      slotDateTime: json['slot_datetime'],
      day: json['day'],
      status: json['status'],
      consulationFee: json['consultation_fee'],
      doctorName: json['doctor_name'],
      doctorImage: json['doctor_image'],
    );
  }
}
