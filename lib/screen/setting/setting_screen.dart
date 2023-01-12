import 'package:submiss_f3/screen/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:submiss_f3/data/source/api/rest_client.dart';
import 'package:submiss_f3/utils/resource/rescolor.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingScreen extends StatefulWidget {
  final RestClient restClient;
  SettingScreen({
    Key? key,
    required this.restClient,
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingCubit _settingCubit = SettingCubit();

  @override
  void initState() {
    _settingCubit..initialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => _settingCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 34,
                      color: ResColor.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () async {
                      await canLaunchUrlString(
                              "https://id.linkedin.com/in/subkh4n")
                          ? await launchUrlString(
                              "https://id.linkedin.com/in/subkh4n")
                          : throw 'Could not launch ';
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(
                          height: 60,
                          child: Image.asset(
                            "assets/subhan.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: Text(
                      "Moh Subhan",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/bookmark",
                                arguments: {"rest": widget.restClient});
                          },
                          leading: Icon(
                            Icons.bookmark,
                            color: ResColor.blue,
                            size: 35,
                          ),
                          title: Text("Bookmark"),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 35,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.notifications,
                            color: ResColor.blue,
                            size: 35,
                          ),
                          title: Text("Notification"),
                          subtitle: Text("Daily Notification at 11 AM"),
                          trailing: BlocBuilder<SettingCubit, bool>(
                            builder: (context, state) => Switch(
                              activeColor: ResColor.blue,
                              value: state,
                              onChanged: (value) {
                                setState(() {
                                  _settingCubit.notificationSwitch(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
