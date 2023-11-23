import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:fakebook/src/pages/authPages/register_pages/gender.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class BirthdayRegisterPage extends StatefulWidget {
  const BirthdayRegisterPage({Key? key}) : super(key: key);

  @override
  BirthdayRegisterPageState createState() => BirthdayRegisterPageState();
}

class BirthdayRegisterPageState extends State<BirthdayRegisterPage> {
  DateTime selectedDate = DateTime.now();
  // bool checkValidBirthday = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    // Hàm để tính tuổi từ ngày sinh
    int calculateAge(DateTime birthDate) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }
      return age;
    }

    bool checkValidBirthday(DateTime birthday){
      DateTime currentDate = DateTime.now();
      if(selectedDate.isAfter(currentDate)){
        return false;
      }
      return true;
    }

    void onBirthdayChange(DateTime birthday) {
      setState(() {
        selectedDate = birthday;
      });
    }

    void showFutureDateWarning() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chọn ngày không hợp lệ'),
            content: const Text('Bạn không thể chọn ngày ở tương lai.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng', style: TextStyle(color: Colors.black),),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Ngày sinh của bạn là khi nào?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Chọn ngày sinh của bạn. Bạn luôn có thể đặt thông tin này ở chế độ riêng tư vào lúc khác.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Ngày sinh: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        checkValidBirthday(selectedDate)
                            ? "(${calculateAge(selectedDate)} tuổi)"
                            : "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CupertinoDateTextBox(
                    initialValue: selectedDate,
                    onDateChange: (DateTime newDate) {
                      onBirthdayChange(newDate);
                    },
                    hintText: DateFormat.yMd().format(selectedDate)),
                ),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (checkValidBirthday(selectedDate)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const GenderRegisterPage()));
                      } else {
                        showFutureDateWarning();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(370, 50),
                      padding: EdgeInsets.zero,
                      // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      backgroundColor: Colors.blue,
                      // Đặt màu nền của nút
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 68, 255), // Đặt màu đường viền
                        width: 0.4, // Đặt độ dày của đường viền
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Tiếp",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 390,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        'Bạn có tài khoản rồi ư?',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
