import 'package:code_brew/code_brew.dart';
import 'package:code_brew_example/models/UserModel.dart';
import 'package:flutter/material.dart';

/// A simple searchable list that uses code_brew UIList
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-23
// ignore: must_be_immutable
class UserListScreen extends StatelessWidget {
  String url = "http://5e29f02192edd600140de156.mockapi.io/v1/users";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlatAppbar(
        title: "Searchable List",
      ),
      body: UIListView<UserModel>(
        model: UserModel(),
        itemBuilder: (BuildContext contxt, data) {
          return _buildItem(data);
        },
        urlModel: getUrl(),
        searchable: true,
      ),
    );
  }

  UrlModel getUrl() {
    return UrlModel(
        baseUrl: url, searchUrl: url, searchKey: "search", limit: 10, page: 1);
  }

  Widget _buildItem(dynamic data) {
    User user = data;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.avatar),
                backgroundColor: Colors.grey.withOpacity(.2),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${user.name}",
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[Expanded(child: Text(
                          "${user.address}",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300
                          ),)
                        )],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[Expanded(child: Text("${user.email}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300
                          ),
                        ))],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
