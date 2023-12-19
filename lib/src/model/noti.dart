import 'package:fakebook/src/model/feel.dart';
import 'package:fakebook/src/model/user.dart';

class Noti {
  final String type;
  final String object_id;
  final String title;
  final String noti_id;
  final String created;
  final String avatar;
  final String read;
  final String bold;
  final String group;
  final User user;
  final Feels feels;
  final String idPost;

  Noti(
      {required this.type,
      required this.object_id,
      required this.title,
      required this.noti_id,
      required this.created,
      required this.avatar,
      required this.read,
      required this.bold,
      required this.group,
      required this.user,
      required this.feels,
      required this.idPost});
}


/* NOTIFICATIONS TYPES:

1. page
2. group
3. comment
4. friend
5. security
6. date
7. badge
8-14: reactions: like, haha, love, lovelove, sad, wow, angry
15: memory
 */
