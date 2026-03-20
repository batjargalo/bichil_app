class MenuTabModel {
  final String title;
  final List<MenuTabItemModel> items;

  MenuTabModel({required this.title, required this.items});
}

class MenuTabItemModel {
  final MenuTabItemType type;
  bool? value;

  MenuTabItemModel({required this.type, this.value});
}

enum MenuTabItemType {
  contract(title: 'Харилцагчийн гэрээ'),
  loanHistory(title: 'Зээлийн түүх'),
  savingHistory(title: 'Итгэлцлийн түүх'),
  // insurane(title: 'Даатгал'),

  changePassword(title: 'Нэвтрэх нууц үг солих'),
  changePin(title: 'Гүйлгээний нууц үг солих'),
  biometric(title: 'Био мэдээллээр нэвтрэх'),

  news(title: 'Мэдээ мэдээлэл'),
  operator(title: 'Холбоо барих'),
  branch(title: 'Салбарын байршил'),
  calculator(title: 'Тооцоолуур'),
  faq(title: 'Түгээмэл асуулт хариулт'),
  terms(title: 'Үйлчилгээний нөхцөл'),
  policy(title: 'Нууцлалын бодлого');

  const MenuTabItemType({required this.title});
  final String title;
}
