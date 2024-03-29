import 'package:challenge2ibi/core/controllers/home_controller.dart';
import 'package:challenge2ibi/core/models/country_model.dart';
import 'package:challenge2ibi/widgets/constants.dart';
import 'package:challenge2ibi/widgets/country_modal.dart';
import 'package:challenge2ibi/widgets/country_modal_content.dart';
import 'package:challenge2ibi/widgets/country_widget.dart';
import 'package:challenge2ibi/widgets/header_widget.dart';
import 'package:challenge2ibi/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  var listCount = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            listCount = listCount + 8;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: appColor,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          header(context, title: "Countries App"),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 12, top: 5, right: 0, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'LISTA DE PAISES',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: textFont,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.030),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: appColor,
                            size: 38,
                          ),
                          onPressed: null)
                    ],
                  ),
                ),
              ],
            ),
          ])),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 2,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder(
                  future: _homeController.countryFuture,
                  builder:
                      (context, AsyncSnapshot<List<CountryModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        var c = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            print("Tapped");
                            return showFloatingModalBottomSheet(
                              context: context,
                              builder: (context, scrollController) => ModalFit(
                                scrollController: scrollController,
                                cover: c.flag.toString(),
                                countryName: c.name.toString(),
                                countryCapital: c.capital.toString(),
                                countryRegion: c.region.toString(),
                                countrySubRegion: c.subregion.toString(),
                                countryArea: c.area.toString(),
                                countryPopulation: c.population.toString(),
                                countryNativeName: c.nativeName.toString(),
                                countryTimeZone: c.timezones.toString(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: countryWidget(
                              context,
                              countryName: c.name ?? "Country",
                              countryRegion: c.region,
                              cover: c.flag.toString(),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      } else {
                        return circularProgress(context);
                      }
                    }
                    return Center(
                      child: circularProgress(context),
                    );
                  },
                );
              },
              childCount: listCount,
            ),
          ),
        ],
      ),
    );
  }
}
