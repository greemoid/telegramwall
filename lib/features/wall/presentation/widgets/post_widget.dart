import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
    required this.title,
    required this.postTextHtml,
    required this.avatarUrl,
  });

  String title;
  String postTextHtml;
  String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              // width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF182533),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    HtmlWidget(
                      postTextHtml,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const imageUrlMock =
    'https://cdn4.cdn-telegram.org/file/CoGwg_43c3FuS8RvBPVvM-riRLNnEz0jeaKbRV2uHKOVKo-VBzUADGxuw73Q67dzPN87o81J48Rm-yWQUiE15h61d5qorvbD0rDHuwKp5n63liTtEtW2h2l0WwlsXwQnaElr6yoRIRYae-ZEHaiimS5twqY0nv3QPmudhHctq3KB7LH7JJdepDPMyaNX_Uf2s2dizoTOgSMpwgTzLn5EJ_sXUvhjv772wYakX9hzpgRrYwq9zoxjS7nrrIORtLcluLL-dj3AiIz_WCzUsCUftVwoq3Vy1RpwMBjZzuYeJqLceRgj78mrlpC0EAyTYh0fcm7bnb_LFeRaEO6KYi-x2Q.jpg';
const blogText =
    'друзья я прекрасно понимаю что уже давно не выпускал новой музыки но это потому что все силы максимально брошены в альбом ХАН. Мне не хочется до альбома ХАН выпускать ничего что могло бы опустить уровень ожидания а потому прошу вас потерпеть еще совсем немного альбом почти готов';
