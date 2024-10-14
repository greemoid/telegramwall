// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//
// class PostWidget extends StatelessWidget {
//   PostWidget({
//     super.key,
//     required this.title,
//     required this.postTextHtml,
//     required this.avatarUrl,
//     required this.imageUrls,
//   });
//
//   String title;
//   String postTextHtml;
//   String avatarUrl;
//   List<String> imageUrls;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ClipOval(
//             child: Image.network(
//               avatarUrl,
//               height: 32,
//               width: 32,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Image.asset(
//                   'assets/placeholder.png',
//                   height: 32,
//                   width: 32,
//                   fit: BoxFit.cover,
//                 ); // Provide a placeholder image in your assets
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Container(
//               // width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF182533),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0).copyWith(right: 16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                           color: Colors.red,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     chooseCorrectForImages(imageUrls.isNotEmpty, imageUrls),
//                     HtmlWidget(
//                       postTextHtml,
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// Widget chooseCorrectForImages(bool imagesExist, List<String> imageUrls) {
//   if (imagesExist) {
//     return Expanded(
//       child: GridView.builder(
//           gridDelegate:
//               const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//           itemCount: imageUrls.length,
//           padding: const EdgeInsets.all(2),
//           itemBuilder: (context, index) {
//             Image.network(
//               imageUrls[index],
//               fit: BoxFit.cover,
//               // width: 120,
//               // height: 360,
//               loadingBuilder: (context, child, progress) {
//                 if (progress == null) return child; // Loaded successfully
//                 return Center(
//                   child: CircularProgressIndicator(
//                     value: progress.expectedTotalBytes != null
//                         ? progress.cumulativeBytesLoaded /
//                             (progress.expectedTotalBytes ?? 1)
//                         : null,
//                   ),
//                 );
//               },
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.error,
//                     color: Colors.red); // Show error icon if image fails
//               },
//             );
//             return null;
//           }),
//     );
//   }
//   return const SizedBox(height: 1);
// }
//
// const imageUrlMock =
//     'https://cdn4.cdn-telegram.org/file/CoGwg_43c3FuS8RvBPVvM-riRLNnEz0jeaKbRV2uHKOVKo-VBzUADGxuw73Q67dzPN87o81J48Rm-yWQUiE15h61d5qorvbD0rDHuwKp5n63liTtEtW2h2l0WwlsXwQnaElr6yoRIRYae-ZEHaiimS5twqY0nv3QPmudhHctq3KB7LH7JJdepDPMyaNX_Uf2s2dizoTOgSMpwgTzLn5EJ_sXUvhjv772wYakX9hzpgRrYwq9zoxjS7nrrIORtLcluLL-dj3AiIz_WCzUsCUftVwoq3Vy1RpwMBjZzuYeJqLceRgj78mrlpC0EAyTYh0fcm7bnb_LFeRaEO6KYi-x2Q.jpg';
// const blogText =
//     'друзья я прекрасно понимаю что уже давно не выпускал новой музыки но это потому что все силы максимально брошены в альбом ХАН. Мне не хочется до альбома ХАН выпускать ничего что могло бы опустить уровень ожидания а потому прошу вас потерпеть еще совсем немного альбом почти готов';


import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:full_screen_image/full_screen_image.dart';

class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
    required this.title,
    required this.postTextHtml,
    required this.avatarUrl,
    required this.imageUrls,
  });

  final String title;
  final String postTextHtml;
  final String avatarUrl;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/placeholder.png',
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF182533),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (imageUrls.isNotEmpty)
                      GridView.builder(
                        itemCount: imageUrls.length,
                        shrinkWrap: true, // Prevent GridView from taking infinite height
                        physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return FullScreenWidget(
                            disposeLevel: DisposeLevel.Low,
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                        (progress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 8),
                    HtmlWidget(
                      postTextHtml,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
