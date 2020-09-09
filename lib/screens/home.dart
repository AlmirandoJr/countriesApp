import 'package:challenge2ibi/models/country_model.dart';
import 'package:challenge2ibi/services/countries_service.dart';
import 'package:challenge2ibi/widgets/constants.dart';
import 'package:challenge2ibi/widgets/country_modal.dart';
import 'package:challenge2ibi/widgets/country_modal_content.dart';
import 'package:challenge2ibi/widgets/country_widget.dart';
import 'package:challenge2ibi/widgets/header_widget.dart';
import 'package:challenge2ibi/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  Future<List<CountryModel>> countryFuture;
  CountriesService _service;

  @override
  void initState() {
    _service = CountriesService();
    countryFuture = _service.getAllCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      body: CustomScrollView(
        slivers: <Widget>[
          header(context, title: "2iBi Software"),

          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 12, top: 5, right: 0, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(                   
                            'LISTA DE PAISES',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: textFont,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height*0.030
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.chevron_right,
                              color: appColor,
                            ), 
                            onPressed: null
                          )
                        ],
                      ),      
                    ),
                  ],
                ),
              ]
            )
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 2,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context,int index){
                return FutureBuilder(
                  future: countryFuture,

                  builder: (context, AsyncSnapshot<List<CountryModel>> snapshot){
                    var c = snapshot.data[index];
                    if(snapshot.hasError){
                      return Center(
                        child: Text('Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.grey)
                        ,),);
                    }
                    if(snapshot.hasData){
                      return GestureDetector(
                        onTap: (){
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
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 4
                          ),
                          child: countryWidget(
                            context, 
                            countryName: c.name ?? "Country",
                            countryRegion: c.region,
                            cover: c.flag
                          ),
                        ),
                      );
                    }else{
                      return circularProgress(context);
                    }
                  },
                ); 
              },
              childCount: 20,
            ),
          ),
          
          
        ],
      ),
    );
  }
}