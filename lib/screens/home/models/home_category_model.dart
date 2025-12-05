enum HomeCategoryType {
  advice(title: 'Зөвлөгөө'),
  news(title: 'Дотоод мэдээ'),
  video(title: 'Видео бичлэг');

  const HomeCategoryType({required this.title});

  final String title;
}
