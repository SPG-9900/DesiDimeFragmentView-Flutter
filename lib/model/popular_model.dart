class WelcomePopular {
  final SeoSettings seoSettings;
  final List<PopularDeal> deals;

  WelcomePopular({
    required this.seoSettings,
    required this.deals,
  });

  factory WelcomePopular.fromJson(Map<String, dynamic> json) {
    return WelcomePopular(
      seoSettings: SeoSettings.fromJson(json['seo_settings']),
      deals: List<PopularDeal>.from(
          json['deals'].map((x) => PopularDeal.fromJson(x))),
    );
  }
}

class PopularDeal {
  final int commentsCount;
  final String imageMedium;
  final Store? store;

  PopularDeal({
    required this.commentsCount,
    required this.imageMedium,
    this.store,
  });

  factory PopularDeal.fromJson(Map<String, dynamic> json) {
    return PopularDeal(
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
