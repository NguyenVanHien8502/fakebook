import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/model/story.dart';

class User {
  final String id;
  final String name;
  final String avatar;
  final String? friends;
  bool? verified;
  final String? description;
  final String? address;
  final String? hometown;
  final String? cover;
  final int? likes;
  final String? isFriend;
  final int? followers;
  final List<String>? hobbies;
  final List<Story>? stories;
  final List<User>? topFriends;
  List<SocialMedia>? socialMedias;
  final String? bio;
  final String? type;
  final List<Education>? educations;
  final bool? guard;
  final List<Post>? posts;
  User({
    required this.id,
    required this.name,
    required this.avatar,
    this.verified,
    this.description,
    this.cover,
    this.friends,
    this.likes,
    this.followers,
    this.hobbies,
    this.stories,
    this.topFriends,
    this.hometown,
    this.socialMedias,
    this.bio,
    this.type,
    this.educations,
    this.guard,
    this.posts,
    this.isFriend,
    this.address,
  });

  User copyWith({
    String? id,
    String? name,
    String? avatar,
    bool? verified,
    String? description,
    String? cover,
    String? friends,
    int? likes,
    int? followers,
    List<String>? hobbies,
    List<Story>? stories,
    List<User>? topFriends,
    String? hometown,
    List<SocialMedia>? socialMedias,
    String? bio,
    String? type,
    List<Education>? educations,
    bool? guard,
    List<Post>? posts,
    String? pageType,
    String? address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      verified: verified ?? this.verified,
      description: description ?? this.description,
      cover: cover ?? this.cover,
      friends: friends ?? this.friends,
      likes: likes ?? this.likes,
      followers: followers ?? this.followers,
      hobbies: hobbies ?? this.hobbies,
      stories: stories ?? this.stories,
      topFriends: topFriends ?? this.topFriends,
      hometown: hometown ?? this.hometown,
      socialMedias: socialMedias ?? this.socialMedias,
      bio: bio ?? this.bio,
      type: type ?? this.type,
      educations: educations ?? this.educations,
      guard: guard ?? this.guard,
      posts: posts ?? this.posts,
      isFriend: pageType ?? this.isFriend,
      address: address ?? this.address,
    );
  }
}

class Education {
  final String majors;
  final String school;
  Education({
    required this.majors,
    required this.school,
  });
}

class SocialMedia {
  final String icon;
  final String name;
  final String link;
  SocialMedia({
    required this.icon,
    required this.name,
    required this.link,
  });
}
