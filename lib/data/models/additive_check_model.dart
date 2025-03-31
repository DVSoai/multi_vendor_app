import 'hook_models/food_model.dart';

class AdditiveCheckModel {
  final int id;
  final String title;
  final String price;
  final bool isChecked; // Để giữ tính bất biến, sửa thành `final`

  AdditiveCheckModel({
    required this.id,
    required this.title,
    required this.price,
    this.isChecked = false,
  });

  // Factory tạo từ Additive
  factory AdditiveCheckModel.fromAdditive(Additive additive, {bool checked = false}) {
    return AdditiveCheckModel(
      id: additive.id,
      title: additive.title,
      price: additive.price,
      isChecked: checked,
    );
  }

  // Hàm copyWith để cập nhật trạng thái mà không cần tạo thủ công
  AdditiveCheckModel copyWith({
    int? id,
    String? title,
    String? price,
    bool? isChecked,
  }) {
    return AdditiveCheckModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      isChecked: isChecked ?? this.isChecked, // Cập nhật trạng thái
    );
  }
}
