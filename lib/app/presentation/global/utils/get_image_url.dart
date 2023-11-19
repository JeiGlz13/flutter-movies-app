getImageUrl(
  String path,
  { ImageQuality imageQuality = ImageQuality.w500 }
) {
  return 'http://image.tmdb.org/t/p/${imageQuality.name}$path';
}

enum ImageQuality {
  w300, w500, original,
}