import 'package:fakebook/src/model/story.dart';
import 'package:fakebook/src/model/user.dart';

class User_data {
  static User userData = User(
    id: "id",
    name: "Fakebook",
    avatar: "avatar",
    educations: [
      Education(
        majors: 'Software Engineering',
        school:
            'Đại học Bách khoa Hà Nội, Trường Công nghệ Thông tin và truyền thông',
      ),
    ],
    hometown: 'Hà Nội',
    followers: 4576,
    friends: "4548",
    hobbies: [
      '💻 Viết mã',
      '📚 Học tập',
      '⚽ Bóng đá',
      '🎮 Trò chơi điện tử',
      '🎧 Nghe nhạc',
      '📖 Đọc sách',
    ],
    socialMedias: [
      SocialMedia(
        icon: 'lib/src/assets/images/mail.png',
        name: 'ngoclinhnguyen@gmail.com',
        link: 'https://github.com/Dat-TG',
      ),
      SocialMedia(
          icon: 'lib/src/assets/images/menu.png',
          name: 'Linh Nguyen',
          link: 'https://www.linkedin.com/in/ddawst/'),
    ],
    stories: [
      Story(
        user: User(
          id: "id",
          name: 'Nguyễn Ngọc Linh',
          avatar: 'lib/src/assets/images/menu.png',
        ),
        image: ['lib/src/assets/images/menu.png'],
        time: ['5 giờ'],
        shareWith: 'friends-of-friends',
        name: 'Featured',
      ),
      Story(
        user: User(
          id: "id",
          name: 'Nguyễn Ngọc Linh',
          avatar: 'lib/src/assets/images/menu.png',
        ),
        image: [
          'lib/src/assets/images/menu.png',
          'lib/src/assets/images/menu.png',
          'lib/src/assets/images/menu.png',
          'lib/src/assets/images/menu.png',
        ],
        video: ['lib/src/assets/images/4.mp4', 'lib/src/assets/images/4.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '18+',
      ),
      Story(
        user: User(
          id: "id",
          name: 'Nguyễn Ngọc Linh',
          avatar: 'lib/src/assets/images/menu.png',
        ),
        video: ['lib/src/assets/images/4.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '20+',
      ),
    ],
  );
}
