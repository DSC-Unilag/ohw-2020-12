class RecipieDetail {
  List<Tags> tags;
  List<Renditions> renditions;
  int createdAt;
  String description;
  String slug;
  int updatedAt;
  String cookTimeMinutes;
  String videoAdContent;
  Show show;
  String canonicalId;
  String aspectRatio;
  String inspiredByUrl;
  bool isShoppable;
  String yields;
  String brandId;
  String seoTitle;
  String thumbnailUrl;
  String promotion;
  String servingsNounPlural;
  String totalTimeMinutes;
  String brand;
  int buzzId;
  String keywords;
  String name;
  int numServings;
  List<Sections> sections;
  Nutrition nutrition;
  List<Null> facebookPosts;
  bool isOneTop;
  String servingsNounSingular;
  bool tipsAndRatingsEnabled;
  int videoId;
  String nutritionVisibility;
  List<Null> compilations;
  String totalTimeTier;
  String originalVideoUrl;
  int approvedAt;
  String country;
  String draftStatus;
  String language;
  String videoUrl;
  List<Instructions> instructions;
  UserRatings userRatings;
  List<Credits> credits;
  String beautyUrl;
  int id;
  String prepTimeMinutes;
  int showId;

  RecipieDetail(
      {this.tags,
      this.renditions,
      this.createdAt,
      this.description,
      this.slug,
      this.updatedAt,
      this.cookTimeMinutes,
      this.videoAdContent,
      this.show,
      this.canonicalId,
      this.aspectRatio,
      this.inspiredByUrl,
      this.isShoppable,
      this.yields,
      this.brandId,
      this.seoTitle,
      this.thumbnailUrl,
      this.promotion,
      this.servingsNounPlural,
      this.totalTimeMinutes,
      this.brand,
      this.buzzId,
      this.keywords,
      this.name,
      this.numServings,
      this.sections,
      this.nutrition,
      this.facebookPosts,
      this.isOneTop,
      this.servingsNounSingular,
      this.tipsAndRatingsEnabled,
      this.videoId,
      this.nutritionVisibility,
      this.compilations,
      this.totalTimeTier,
      this.originalVideoUrl,
      this.approvedAt,
      this.country,
      this.draftStatus,
      this.language,
      this.videoUrl,
      this.instructions,
      this.userRatings,
      this.credits,
      this.beautyUrl,
      this.id,
      this.prepTimeMinutes,
      this.showId});

  RecipieDetail.fromJson(Map<String, dynamic> json) {
    if (json['Tags'] != null) {
      tags = new List<Tags>();
      json['Tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    if (json['renditions'] != null) {
      renditions = new List<Renditions>();
      json['renditions'].forEach((v) {
        renditions.add(new Renditions.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    description = json['description'];
    slug = json['slug'];
    updatedAt = json['updated_at'];
    cookTimeMinutes = json['cook_time_minutes'];
    videoAdContent = json['video_ad_content'];
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
    canonicalId = json['canonical_id'];
    aspectRatio = json['aspect_ratio'];
    inspiredByUrl = json['inspired_by_url'];
    isShoppable = json['is_shoppable'];
    yields = json['yields'];
    brandId = json['brand_id'];
    seoTitle = json['seo_title'];
    thumbnailUrl = json['thumbnail_url'];
    promotion = json['promotion'];
    servingsNounPlural = json['servings_noun_plural'];
    totalTimeMinutes = json['total_time_minutes'];
    brand = json['brand'];
    buzzId = json['buzz_id'];
    keywords = json['keywords'];
    name = json['name'];
    numServings = json['num_servings'];
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
    nutrition = json['nutrition'] != null
        ? new Nutrition.fromJson(json['nutrition'])
        : null;
    if (json['facebook_posts'] != null) {
      facebookPosts = new List<Null>();
     
    }
    isOneTop = json['is_one_top'];
    servingsNounSingular = json['servings_noun_singular'];
    tipsAndRatingsEnabled = json['tips_and_ratings_enabled'];
    videoId = json['video_id'];
    nutritionVisibility = json['nutrition_visibility'];
    if (json['compilations'] != null) {
      compilations = new List<Null>();
     
  
    }
    totalTimeTier = json['total_time_tier'];
    originalVideoUrl = json['original_video_url'];
    approvedAt = json['approved_at'];
    country = json['country'];
    draftStatus = json['draft_status'];
    language = json['language'];
    videoUrl = json['video_url'];
    if (json['instructions'] != null) {
      instructions = new List<Instructions>();
      json['instructions'].forEach((v) {
        instructions.add(new Instructions.fromJson(v));
      });
    }
    userRatings = json['user_ratings'] != null
        ? new UserRatings.fromJson(json['user_ratings'])
        : null;
    if (json['credits'] != null) {
      credits = new List<Credits>();
      json['credits'].forEach((v) {
        credits.add(new Credits.fromJson(v));
      });
    }
    beautyUrl = json['beauty_url'];
    id = json['id'];
    prepTimeMinutes = json['prep_time_minutes'];
    showId = json['show_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tags != null) {
      data['Tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.renditions != null) {
      data['renditions'] = this.renditions.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['updated_at'] = this.updatedAt;
    data['cook_time_minutes'] = this.cookTimeMinutes;
    data['video_ad_content'] = this.videoAdContent;
    if (this.show != null) {
      data['show'] = this.show.toJson();
    }
    data['canonical_id'] = this.canonicalId;
    data['aspect_ratio'] = this.aspectRatio;
    data['inspired_by_url'] = this.inspiredByUrl;
    data['is_shoppable'] = this.isShoppable;
    data['yields'] = this.yields;
    data['brand_id'] = this.brandId;
    data['seo_title'] = this.seoTitle;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['promotion'] = this.promotion;
    data['servings_noun_plural'] = this.servingsNounPlural;
    data['total_time_minutes'] = this.totalTimeMinutes;
    data['brand'] = this.brand;
    data['buzz_id'] = this.buzzId;
    data['keywords'] = this.keywords;
    data['name'] = this.name;
    data['num_servings'] = this.numServings;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    if (this.nutrition != null) {
      data['nutrition'] = this.nutrition.toJson();
    }
   
    data['is_one_top'] = this.isOneTop;
    data['servings_noun_singular'] = this.servingsNounSingular;
    data['tips_and_ratings_enabled'] = this.tipsAndRatingsEnabled;
    data['video_id'] = this.videoId;
    data['nutrition_visibility'] = this.nutritionVisibility;
    
    data['total_time_tier'] = this.totalTimeTier;
    data['original_video_url'] = this.originalVideoUrl;
    data['approved_at'] = this.approvedAt;
    data['country'] = this.country;
    data['draft_status'] = this.draftStatus;
    data['language'] = this.language;
    data['video_url'] = this.videoUrl;
    if (this.instructions != null) {
      data['instructions'] = this.instructions.map((v) => v.toJson()).toList();
    }
    if (this.userRatings != null) {
      data['user_ratings'] = this.userRatings.toJson();
    }
    if (this.credits != null) {
      data['credits'] = this.credits.map((v) => v.toJson()).toList();
    }
    data['beauty_url'] = this.beautyUrl;
    data['id'] = this.id;
    data['prep_time_minutes'] = this.prepTimeMinutes;
    data['show_id'] = this.showId;
    return data;
  }
}

class Tags {
  String name;
  String displayName;
  String type;
  int id;

  Tags({this.name, this.displayName, this.type, this.id});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['display_name'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}

class Renditions {
  String posterUrl;
  String name;
  int bitRate;
  String contentType;
  int duration;
  int fileSize;
  int maximumBitRate;
  int minimumBitRate;
  String aspect;
  String container;
  int height;
  int width;
  String url;

  Renditions(
      {this.posterUrl,
      this.name,
      this.bitRate,
      this.contentType,
      this.duration,
      this.fileSize,
      this.maximumBitRate,
      this.minimumBitRate,
      this.aspect,
      this.container,
      this.height,
      this.width,
      this.url});

  Renditions.fromJson(Map<String, dynamic> json) {
    posterUrl = json['poster_url'];
    name = json['name'];
    bitRate = json['bit_rate'];
    contentType = json['content_type'];
    duration = json['duration'];
    fileSize = json['file_size'];
    maximumBitRate = json['maximum_bit_rate'];
    minimumBitRate = json['minimum_bit_rate'];
    aspect = json['aspect'];
    container = json['container'];
    height = json['height'];
    width = json['width'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_url'] = this.posterUrl;
    data['name'] = this.name;
    data['bit_rate'] = this.bitRate;
    data['content_type'] = this.contentType;
    data['duration'] = this.duration;
    data['file_size'] = this.fileSize;
    data['maximum_bit_rate'] = this.maximumBitRate;
    data['minimum_bit_rate'] = this.minimumBitRate;
    data['aspect'] = this.aspect;
    data['container'] = this.container;
    data['height'] = this.height;
    data['width'] = this.width;
    data['url'] = this.url;
    return data;
  }
}

class Show {
  int id;
  String name;

  Show({this.id, this.name});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Sections {
  String name;

  Sections({this.name});

  Sections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Nutrition {
  int protein;
  int sugar;
  int fiber;
  String updatedAt;
  int calories;
  int carbohydrates;
  int fat;

  Nutrition(
      {this.protein,
      this.sugar,
      this.fiber,
      this.updatedAt,
      this.calories,
      this.carbohydrates,
      this.fat});

  Nutrition.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    sugar = json['sugar'];
    fiber = json['fiber'];
    updatedAt = json['updated_at'];
    calories = json['calories'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['sugar'] = this.sugar;
    data['fiber'] = this.fiber;
    data['updated_at'] = this.updatedAt;
    data['calories'] = this.calories;
    data['carbohydrates'] = this.carbohydrates;
    data['fat'] = this.fat;
    return data;
  }
}

class Instructions {
  int id;
  String displayText;
  int position;
  int startTime;
  int endTime;
  String temperature;
  String appliance;

  Instructions(
      {this.id,
      this.displayText,
      this.position,
      this.startTime,
      this.endTime,
      this.temperature,
      this.appliance});

  Instructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayText = json['display_text'];
    position = json['position'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    temperature = json['temperature'];
    appliance = json['appliance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_text'] = this.displayText;
    data['position'] = this.position;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['temperature'] = this.temperature;
    data['appliance'] = this.appliance;
    return data;
  }
}

class UserRatings {
  int countPositive;
  int countNegative;
  double score;

  UserRatings({this.countPositive, this.countNegative, this.score});

  UserRatings.fromJson(Map<String, dynamic> json) {
    countPositive = json['count_positive'];
    countNegative = json['count_negative'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_positive'] = this.countPositive;
    data['count_negative'] = this.countNegative;
    data['score'] = this.score;
    return data;
  }
}

class Credits {
  String name;
  String type;

  Credits({this.name, this.type});

  Credits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
