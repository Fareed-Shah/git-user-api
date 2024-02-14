import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController userController = TextEditingController();
  String? userName;
  String? bio;
  String? _image;
  callApi() async {
    // String url = "https://api.github.com/users/fareed-shah";
    String url = "https://api.github.com/users/";
    String completeUrl = url + userController.text;
    var uri = Uri.parse(completeUrl);
    try {
      var responce = await http.get(uri);
      Map<String, dynamic> jsonParsed = jsonDecode(responce.body);
      userName = jsonParsed['name'];
      bio = jsonParsed['bio'];
      _image = jsonParsed['avatar_url'];
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('git user api'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(userName == null
            //     ? "fetching data from api..."
            //     : userName.toString()),
            // if (userName != null) Text(userName!),
            // if (userName == null) CircularProgressIndicator(),
            ListTile(
              title: Text(
                userName == null ? "username..." : userName.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(bio == null ? "bio..." : bio.toString()),
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: _image == null
                    ? const NetworkImage(
                        "https://images.pexels.com/photos/103123/pexels-photo-103123.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
                    : NetworkImage(_image.toString()),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                controller: userController,
                decoration: const InputDecoration(
                    hintText: "enter git user name", border: InputBorder.none),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  callApi();
                  userController.clear();
                },
                child: const Text('Call Api'))
          ],
        ),
      ),
    );
  }
}
