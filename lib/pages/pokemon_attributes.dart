// import 'dart:html';

import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_dictionary/services/pokemon.dart';
import 'package:pokemon_dictionary/values/colors/colors.dart';


class PokemonAttributes extends StatefulWidget {
  @override
  _PokemonAttributesState createState() => _PokemonAttributesState();
}

class _PokemonAttributesState extends State<PokemonAttributes> {

  Map data = {};
  String url, name;

  Map details;

  Future<Map> getPokemonDetails(String url) async {
    Pokemon allPokemon = Pokemon(url: url);

    return await allPokemon.getPokemonDetails();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get passed url
    data = ModalRoute.of(context).settings.arguments;

    name = data["name"];
    url = data["url"];



    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: colorPrimary,
      //   title: Text(name),
      // ),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: getPokemonDetails(url),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              Map info = snapshot.data;
              List<dynamic> abilities = info["abilities"];
              String id = info["id"].toString();
              // print(abilities[0].toString());
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.network(
                        "https://pokeres.bastionbot.org/images/pokemon/$id.png",
                        height: 350.0,
                        fit: BoxFit.fitWidth,
                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 350,
                            child: SpinKitFadingCircle(
                              color: colorPrimary,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: colorText,
                            fontSize: 35.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(height: 60, color: colorTextSecondary,),
                      Text(
                        "HEIGHT",
                        style: TextStyle(
                          color: colorTextSecondary,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        info["height"].toString()
                            + " inches",
                        style: TextStyle(
                          color: colorText,
                          fontSize: 22.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "WEIGHT",
                        style: TextStyle(
                          color: colorTextSecondary,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        info["weight"].toString()
                        + " lbs",
                        style: TextStyle(
                          color: colorText,
                          fontSize: 22.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "ABILITIES",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: colorSecondary,
                              ),
                            ),
                            Container(
                              height: 200.0,
                              child: new ListView.builder(
                                itemCount: abilities.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    abilities[index]["ability"]["name"],
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(
                  color: colorSecondary,
                  size: 80.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


