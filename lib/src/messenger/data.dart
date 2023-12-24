// users story list
List userStories = [
  {
    "id": 1,
    "name": "Ngoc Linh",
    "img":
        "https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "online": true,
    "story": true,
  },
  {
    "id": 2,
    "name": "Van Hiển",
    "img":
        "https://images.unsplash.com/photo-1536763843054-126cc2d9d3b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "online": false,
    "story": false,
  },
  {
    "id": 3,
    "name": "Ninh Thành Vinh",
    "img":
        "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
    "online": true,
    "story": false,
  },
  {
    "id": 4,
    "name": "Đỗ Minh Nghĩa",
    "img":
        "https://images.unsplash.com/photo-1523264939339-c89f9dadde2e?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
    "online": true,
    "story": true,
  },
  {
    "id": 5,
    "name": "Đỗ Bá Duy",
    "img":
        "https://images.unsplash.com/photo-1458696352784-ffe1f47c2edc?ixlib=rb-1.2.1&auto=format&fit=crop&w=1951&q=80",
    "online": false,
    "story": false,
  },
  {
    "id": 6,
    "name": "Nguyễn Ngọc Linh",
    "img":
        "https://images.unsplash.com/photo-1519531591569-b84b8174b508?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "online": false,
    "story": true,
  }
];

// users message list
List userMessages = [
  {
    "id": 1,
    "name": "Ngoc Linh",
    "img":
        "https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "online": true,
    "story": true,
    "message": "Cái gì?",
    "created_at": "1:00 pm"
  },
  {
    "id": 2,
    "name": "Nguyễn Bá Duy",
    "img":
        "https://images.unsplash.com/photo-1467272046618-f2d1703715b1?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "online": false,
    "story": false,
    "message": "Long time no see!!",
    "created_at": "12:00 am"
  },
  {
    "id": 3,
    "name": "Văn Hiển",
    "img":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80",
    "online": false,
    "story": true,
    "message": "Gật gật",
    "created_at": "3:30 pm"
  },
  {
    "id": 4,
    "name": "Ninh Vinh",
    "img":
        "https://images.unsplash.com/photo-1536763843054-126cc2d9d3b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "online": false,
    "story": false,
    "message": "Cái gì >>>>>",
    "created_at": "9:00 am"
  },
  {
    "id": 5,
    "name": "LeooooMessi",
    "img":
        "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
    "online": true,
    "story": false,
    "message": ":v",
    "created_at": "11:25 am"
  },
  {
    "id": 6,
    "name": "Đỗ Nghĩa",
    "img":
        "https://images.unsplash.com/photo-1523264939339-c89f9dadde2e?ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
    "online": true,
    "story": true,
    "message": "Nghĩa đang hạnh phúc",
    "created_at": "10:00 am"
  },
  {
    "id": 7,
    "name": "Luffy",
    "img":
        "https://images.unsplash.com/photo-1458696352784-ffe1f47c2edc?ixlib=rb-1.2.1&auto=format&fit=crop&w=1951&q=80",
    "online": false,
    "story": false,
    "message": "Sanji đâu",
    "created_at": "2:34 pm"
  },
  {
    "id": 8,
    "name": "Bá đạo",
    "img":
        "https://images.unsplash.com/photo-1519531591569-b84b8174b508?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "online": false,
    "story": true,
    "message": ":V vvvvvvvvvvv",
    "created_at": "1:12 am"
  }
];

// list of messages
List messages = [
  {
    "isMe": true,
    "messageType": 1,
    "message": "Ok anh bạn nhé",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": true,
    "messageType": 2,
    "message": "Bạn cần tôi gõ giúp đoạn code này không",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": true,
    "messageType": 3,
    "message": "Công việc thật tuyệt vời",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 1,
    "message": "Em ghét anh",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 2,
    "message": "bruh",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 3,
    "message": "-_-",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": true,
    "messageType": 1,
    "message": "Cái gì thế",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": true,
    "messageType": 3,
    "message": "M nói thật ak",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 1,
    "message": "M đang code bằng ubutu hay gì á",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 2,
    "message": "?????",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 3,
    "message": "Yess yess",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": true,
    "messageType": 4,
    "message": "hahahahahha",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  },
  {
    "isMe": false,
    "messageType": 4,
    "message": "oki nha",
    "profileImg":
        "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3319&q=80"
  }
];
