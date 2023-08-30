import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentapp/pages/EnteredList.dart';
import 'package:studentapp/pages/editPage.dart';

import 'Details.dart';
import 'functions/db_functions.dart';
import 'model/StudentModel.dart';

class ListStudent extends StatelessWidget {
  ListStudent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          return ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentList,
                Widget? child) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0,
                  vertical: mediaQuery.size.height * 0,
                ),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = studentList[index];
                    return GestureDetector(
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Container(
                            child: GestureDetector(
                              onTap: () {
                                navigateToDetails(context, data);
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 158, 222, 252),
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 28, 29, 29),
                                  radius: 30,
                                  backgroundImage:
                                      FileImage(File(data.imagePath)),
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  deletStudent(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => edit_student(
                                        index: index,
                                        name: data.name,
                                        age: data.age,
                                        Class: data.className,
                                        address: data.address,
                                        dob: data.dob,
                                        imagePath: data.imagePath),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          title: Text(data.name),
                          subtitle: Text(
                            'Click on the picture',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Color.fromARGB(255, 222, 224, 224),
                    );
                  },
                  itemCount: studentList.length,
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gobackTodetails(context);
        },
        backgroundColor: const Color.fromARGB(255, 34, 90, 136),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> gobackTodetails(BuildContext context) async {
    await Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => ListEnter()), (route) => false);
  }

  void navigateToDetails(BuildContext context, StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Details(
                student: student,
              )),
    );
  }
}
