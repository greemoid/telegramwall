import 'package:durovswall/features/wall/domain/post.dart';


/// avatarUrl : "https://cdn4.cdn-telegram.org/file/SfPHzoMmYsofBSCGslR45rslKEYNYz9gOgXDJYdiFAxJJ2i4nRQL5MEtvFdzRvZg_imgwmkxu14Tf8U2Z7vro-mrxkjyJ8CYFdQcSfXLrlqpYd-RwTTvwHorEMgoUayyuLlXPBnQCk_GQzodo2QYwQSEDMqANMOyaa8iqSLOOIjDQbCnDFYwIweWDXzCAd_EaE39qTr4m3-IJZ5RUzesQOvIysp3_Yz3zTIXV5t73NNbJYFqgQG9-0uS4dPVk8BuxxQvdlNsFFRol8lneUIL5t2zNfSFK9DzPgPtvF4HjaNBv-hXBPtrwy3rgzeaQ4drO-jLv7XIEsoYzlVO4DBrcw.jpg"
/// channel : "Книги українською 🇺🇦"
/// dateTime : "2024-03-21T07:03:21+00:00"
/// imageUrl : ""
/// postTextHtml : "&lt;b&gt;Стоїцизм на кожен день. День 151&lt;br/&gt;&lt;br/&gt;Працювати старанно чи абияк?&lt;/b&gt;&lt;br/&gt;&lt;br/&gt;&lt;i&gt;Тому я не можу назвати працьовитою людину, якщо почую тільки про те, що вона читає або пише, і навіть якщо додадуть, що цілими ночами, я поки що не називаю, якщо не довідаюся, до якої це віднесено мети. &#x27;...&#x27; А якщо він відносить мету своєї старанної праці до своєї верховної частини душі, щоб вона перебувала в стані відповідності з природою, тільки тоді я називаю його працьовитим[228].&lt;br/&gt;&lt;br/&gt;&lt;b&gt;Епіктет. Бесіди. 4.4.41, 43&lt;/b&gt;&lt;/i&gt;&lt;br/&gt;&lt;br/&gt;Які шанси, що найзайнятіша людина з ваших знайомих буде також і найпродуктивнішою? Ми схильні пов&#x27;язувати зайнятість із благом і вважаємо, що тривала робота має винагороджуватися. Однак оцініть, що ви робите, чому ви це робите і до чого приведе вас результат. Якщо у вас немає хорошої відповіді - зупиніться."
/// videoUrl : ""
/// viewsCount : "3.6K"


class PostModel extends Post {
  PostModel(
    super.postTextHtml,
    super.channel,
    super.avatarUrl,
    super.dateTime,
    super.imageUrl,
    super.videoUrl,
    super.viewsCount,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        json['postTextHtml'] as String,
        json['channel'] as String,
        json['avatarUrl'] as String,
        json['dateTime'] as String,
        json['imageUrl'] as String,
        json['videoUrl'] as String,
        json['viewsCount'] as String);
  }

  @override
  String toString() {
    return 'PostModel{$postTextHtml $channel $avatarUrl $dateTime $imageUrl $videoUrl $viewsCount}';
  }

  Post toPost() {
    return Post(postTextHtml, channel, avatarUrl, dateTime, imageUrl, videoUrl,
        viewsCount);
  }
}
