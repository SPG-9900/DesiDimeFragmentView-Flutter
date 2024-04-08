class WelcomeTop {
  final SeoSettings seoSettings;
  final List<Deal> deals;

  WelcomeTop({
    required this.seoSettings,
    required this.deals,
  });

  factory WelcomeTop.fromJson(Map<String, dynamic> json) {
    return WelcomeTop(
      seoSettings: SeoSettings.fromJson(json['seo_settings']),
      deals: List<Deal>.from(json['deals'].map((x) => Deal.fromJson(x))),
    );
  }
}

class Deal {
  final int id;
  final int commentsCount;
  final DateTime createdAt;
  final int createdAtInMillis;
  final String imageMedium;
  final Store? store;

  Deal({
    required this.id,
    required this.commentsCount,
    required this.createdAt,
    required this.createdAtInMillis,
    required this.imageMedium,
    this.store,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      commentsCount: json['comments_count'],
      createdAt: DateTime.parse(json['created_at']),
      createdAtInMillis: json['created_at_in_millis'],
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
