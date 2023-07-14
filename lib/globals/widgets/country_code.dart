import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/models/country_model.dart';

/// This is the stateful widget that the main application instantiates.
class ChooseCountry extends StatefulWidget {
  final Function onTap;
  ChooseCountry(this.onTap);
  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ChooseCountryState extends State<ChooseCountry> {
  List<CscPicker> countries = [];
  List<CscPicker> search = [];
  TextEditingController searchController = TextEditingController();
  var loading = false;
  @override
  void initState() {
    rootBundle.loadString('assets/countries.json').then((jsonStr) {
      countries = cscPickerFromMap(jsonStr);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
                  // style: TextStyle(height: 1, fontSize: 15),
                  onChanged: (val) {
                    setState(() {
                      search = countries
                          .where((city) => city.name
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search country...',
                      isDense: true,
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? countries.length
                        : search.length,
                    itemBuilder: (context, index) {
                      CscPicker city = searchController.text.isEmpty
                          ? countries[index]
                          : search[index];
                      return ListTile(
                          title: Text(city.name),
                          onTap: () async {
                            widget.onTap(city.name, city.code);
                          });
                    }),
              )
            ],
          ),
          loading ? AppViews.showLoading() : Container()
        ],
      ),
    );
  }
}
