class Post {
  String? postTextHtml;
  String? channel;
  String? avatarUrl;
  String? dateTime;
  List<String>? imageUrls;
  String? videoUrl;
  String? viewsCount;

  Post(
    this.postTextHtml,
    this.channel,
    this.avatarUrl,
    this.dateTime,
    this.imageUrls,
    this.videoUrl,
    this.viewsCount,
  );
}
