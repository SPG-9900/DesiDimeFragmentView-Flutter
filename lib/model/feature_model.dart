class WelcomeFeature {
  final SeoSettings seoSettings;
  final List<FeatureDeal> deals;

  WelcomeFeature({
    required this.seoSettings,
    required this.deals,
  });

  factory WelcomeFeature.fromJson(Map<String, dynamic> json) {
    return WelcomeFeature(
      seoSettings: SeoSettings.fromJson(json['seo_settings']),
      deals: List<FeatureDeal>.from(
          json['deals'].map((x) => FeatureDeal.fromJson(x))),
    );
  }
}

class FeatureDeal {
  final int commentsCount;
  final String imageMedium;
  final Store? store;

  FeatureDeal({
    required this.commentsCount,
    required this.imageMedium,
    this.store,
  });

  factory FeatureDeal.fromJson(Map<String, dynamic> json) {
    return FeatureDeal(
      commentsCount: json['comments_count'],
      imageMedium: json['image_medium'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
    );
  }
}

class Store {
  final String name;

  Store({
    required this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'],
    );
  }
}

class SeoSettings {
  final String seoTitle;
  final String seoDescription;
  final String webUrl;

  SeoSettings({
    required this.seoTitle,
    required this.seoDescription,
    required this.webUrl,
  });

  factory SeoSettings.fromJson(Map<String, dynamic> json) {
    return SeoSettings(
      seoTitle: json['seo_title'],
      seoDescription: json['seo_description'],
      webUrl: json['web_url'],
    );
  }
}
