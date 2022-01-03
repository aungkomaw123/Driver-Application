import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/customer_db.dart';
import 'package:flutter_application_1/provider/location_provider.dart';
import 'package:provider/provider.dart';

class UseerList extends StatefulWidget {
  const UseerList({Key? key}) : super(key: key);

  @override
  _UseerListState createState() => _UseerListState();
}

class _UseerListState extends State<UseerList> {
  TextEditingController _searchcontroller = TextEditingController();
  List<User> customerList = [];
  List<User> _resultList = [];

  getData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('CustomerData').get();

    for (var element in snapshot.docs) {
      customerList.add(User(
          nrc: element.get("nrc"),
          address: element.get('address'),
          age: element.get("age"),
          img: element.get("img"),
          lat: element.get("lat"),
          log: element.get("log"),
          name: element.get("name"),
          phone: element.get("phone")));
      print(customerList.length);
    }
    setState(() {
      _resultList.addAll(customerList);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _searchcontroller.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    print(_searchcontroller.text);

    // _resultList.clear();

    if (_searchcontroller.text.isEmpty) {
      originalList();
    } else {
      searchList();
    }

    // customerList.contains(_searchcontroller.text)
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Customer List"),
        ),
        body: customerList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<LocationProvider>(
                builder: (context, LocationProvider loc, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchcontroller,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: "Search customer by name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40, bottom: 40),
                            child: InkWell(
                              onTap: () {
                                locationProvider.setLat(_resultList[index].lat);
                                locationProvider.setLog(_resultList[index].log);
                                print(locationProvider.lat);
                                print(locationProvider.log);
                                Navigator.of(context).pop();
                              },
                              child: Card(
                                color: const Color.fromRGBO(245, 238, 220, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, bottom: 20, right: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 75,
                                            backgroundImage: NetworkImage(
                                                _resultList[index].img),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Name: ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: _resultList[index].name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ])),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Age: ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: _resultList[index].age,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ])),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Address: ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: _resultList[index].address,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ])),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Phone ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: _resultList[index].phone,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ])),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _resultList.length,
                      ),
                    ),
                  ],
                );
              }));
  }

  List<User> originalList() {
    return _resultList = customerList;
  }

  List<User> searchList() {
    // _resultList.clear();
    _resultList = customerList
        .where((element) =>
            element.name.toLowerCase().contains(_searchcontroller.text))
        .toList();
    print(_resultList.length);
    return _resultList;
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }
}
