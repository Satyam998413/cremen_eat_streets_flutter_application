import 'package:equatable/equatable.dart';

/// One priced option for a product — e.g. a pack size or flavor. Mirrors one
/// entry of the `products.variants` jsonb array (see
/// plans/platform-overview.md, cremen_eat_streets, Step 4a).
class ProductVariant extends Equatable {
  const ProductVariant({required this.label, required this.price, this.wholesalePrice});

  final String label;
  final double price;

  /// Mirrors an optional `wholesalePrice` key the `products.variants` jsonb
  /// array objects may now carry alongside `label`/`price` (cremen_eat_streets
  /// B2B pricing) — falls back to [price] when null/absent, same as the
  /// product-level `wholesale_price` column falls back to `base_price`.
  final double? wholesalePrice;

  Map<String, dynamic> toMap() => {'label': label, 'price': price, 'wholesalePrice': wholesalePrice};

  factory ProductVariant.fromMap(Map<String, dynamic> map) {
    return ProductVariant(
      label: map['label'] as String,
      price: (map['price'] as num).toDouble(),
      wholesalePrice: (map['wholesalePrice'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [label, price, wholesalePrice];
}

class ProductMedia extends Equatable {
  const ProductMedia({required this.url, required this.isPrimary, this.altText});

  final String url;
  final bool isPrimary;
  final String? altText;

  Map<String, dynamic> toMap() => {'url': url, 'isPrimary': isPrimary, 'altText': altText};

  factory ProductMedia.fromMap(Map<String, dynamic> map) {
    return ProductMedia(
      url: map['url'] as String,
      isPrimary: map['isPrimary'] as bool? ?? false,
      altText: map['altText'] as String?,
    );
  }

  @override
  List<Object?> get props => [url, isPrimary, altText];
}

/// One "also available on" external listing — mirrors one entry of the
/// `products.marketplace_links` jsonb array (cremen_eat_streets, see
/// ProductForm > MarketplaceLinksEditor). [logoUrl] is resolved by the
/// repository from the separate `marketplace_logos` table (keyed by
/// lowercased [platform] name, shared across every product) — it is not
/// stored on the link itself, so it's null until that lookup has run.
class ProductMarketplaceLink extends Equatable {
  const ProductMarketplaceLink({required this.platform, required this.url, this.logoUrl});

  final String platform;
  final String url;
  final String? logoUrl;

  Map<String, dynamic> toMap() => {'platform': platform, 'url': url, 'logoUrl': logoUrl};

  factory ProductMarketplaceLink.fromMap(Map<String, dynamic> map) {
    return ProductMarketplaceLink(
      platform: map['platform'] as String,
      url: map['url'] as String,
      logoUrl: map['logoUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [platform, url, logoUrl];
}

/// Mirrors the columns of `products` this app actually displays — the
/// packaged-only label/nutrition fields (weight_label, ingredients, batch_no,
/// etc.) are Label Studio/admin-only and deliberately left out here.
class Product extends Equatable {
  const Product({
    required this.id,
    required this.productType,
    required this.slug,
    required this.name,
    required this.description,
    required this.basePrice,
    this.subtitle,
    this.compareAtPrice,
    this.wholesalePrice,
    this.variants = const [],
    this.requiresShipping = true,
    this.isVeg,
    this.isSpicy,
    this.prepTimeLabel,
    this.ratingAvg = 0,
    this.ratingCount = 0,
    this.media = const [],
    this.marketplaceLinks = const [],
  });

  final String id;
  final String productType; // 'packaged' | 'fresh_food'
  final String slug;
  final String name;
  final String? subtitle;
  final String description;
  final double basePrice;
  final double? compareAtPrice;

  /// Mirrors the nullable `products.wholesale_price` column (cremen_eat_streets
  /// B2B pricing) — falls back to [basePrice] for a salesman/wholesaler
  /// account when null; irrelevant, and never charged, for a retail customer.
  final double? wholesalePrice;
  final List<ProductVariant> variants;
  final bool requiresShipping;
  final bool? isVeg;
  final bool? isSpicy;
  final String? prepTimeLabel;
  final double ratingAvg;
  final int ratingCount;
  final List<ProductMedia> media;
  final List<ProductMarketplaceLink> marketplaceLinks;

  bool get isPackaged => productType == 'packaged';
  bool get hasVariants => variants.isNotEmpty;

  String get primaryImageUrl {
    if (media.isEmpty) return '';
    return media.firstWhere((m) => m.isPrimary, orElse: () => media.first).url;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productType': productType,
      'slug': slug,
      'name': name,
      'subtitle': subtitle,
      'description': description,
      'basePrice': basePrice,
      'compareAtPrice': compareAtPrice,
      'wholesalePrice': wholesalePrice,
      'variants': variants.map((v) => v.toMap()).toList(),
      'requiresShipping': requiresShipping,
      'isVeg': isVeg,
      'isSpicy': isSpicy,
      'prepTimeLabel': prepTimeLabel,
      'ratingAvg': ratingAvg,
      'ratingCount': ratingCount,
      'media': media.map((m) => m.toMap()).toList(),
      'marketplaceLinks': marketplaceLinks.map((m) => m.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      productType: map['productType'] as String,
      slug: map['slug'] as String,
      name: map['name'] as String,
      subtitle: map['subtitle'] as String?,
      description: map['description'] as String? ?? '',
      basePrice: (map['basePrice'] as num).toDouble(),
      compareAtPrice: (map['compareAtPrice'] as num?)?.toDouble(),
      wholesalePrice: (map['wholesalePrice'] as num?)?.toDouble(),
      variants: (map['variants'] as List<dynamic>? ?? const [])
          .map((v) => ProductVariant.fromMap(Map<String, dynamic>.from(v as Map)))
          .toList(),
      requiresShipping: map['requiresShipping'] as bool? ?? true,
      isVeg: map['isVeg'] as bool?,
      isSpicy: map['isSpicy'] as bool?,
      prepTimeLabel: map['prepTimeLabel'] as String?,
      ratingAvg: (map['ratingAvg'] as num?)?.toDouble() ?? 0,
      ratingCount: map['ratingCount'] as int? ?? 0,
      media: (map['media'] as List<dynamic>? ?? const [])
          .map((m) => ProductMedia.fromMap(Map<String, dynamic>.from(m as Map)))
          .toList(),
      marketplaceLinks: (map['marketplaceLinks'] as List<dynamic>? ?? const [])
          .map((m) => ProductMarketplaceLink.fromMap(Map<String, dynamic>.from(m as Map)))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        productType,
        slug,
        name,
        subtitle,
        description,
        basePrice,
        compareAtPrice,
        wholesalePrice,
        variants,
        requiresShipping,
        isVeg,
        isSpicy,
        prepTimeLabel,
        ratingAvg,
        ratingCount,
        media,
        marketplaceLinks,
      ];
}
