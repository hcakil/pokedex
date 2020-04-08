import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;


  PokemonDetail(this.pokemon);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}



class _PokemonDetailState extends State<PokemonDetail> {

  Color baskinRenk=Colors.blueAccent;
  PaletteGenerator paletteGenerator;

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
    PaletteGenerator.fromImageProvider(
        NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //secilenBurc = BurcListesi.tumBurclar[widget.gelenIndex];
    baskinRengiBul();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,//Colors.blueAccent.shade100,
      appBar: AppBar(
        elevation: 0,

        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
        backgroundColor: baskinRenk,//Colors.green,
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return dikeyBody(context);
        } else {
          return yatayBody(context);
        }
      }),
    );
  }

  Widget yatayBody(BuildContext context) {
    return  Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 5),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Hero(
                  tag: widget.pokemon.img,
                  child: Container(
                    //height: 200,
                    width: 250,
                    child: Image.network(
                      widget.pokemon.img,
                      fit: BoxFit.fill,
                    ),
                  )),
              flex: 2,
            ),
            Expanded(child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    "Height  : " + widget.pokemon.height,
                  ),
                  Text(
                    "Weight  : " + widget.pokemon.weight,
                  ),
                  Text(
                    "Types : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //burda liste olarak her pokemon için tipler geliyor
                    //MAPPING YAPILIYOR...
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                      backgroundColor: Colors.deepPurpleAccent.shade100,
                      label: Text(
                        tip,
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                        .toList(),
                  ),
                  Text(
                    "Pre Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                        .map((evolution) => Chip(
                        backgroundColor: Colors.purpleAccent,
                        label: Text(
                          evolution.name,
                          style: TextStyle(color: Colors.white),
                        )))
                        .toList()
                        : [Text("İlk hali")],
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                        .map((evolution) => Chip(
                        backgroundColor: Colors.deepOrange.shade300,
                        label: Text(
                          evolution.name,
                          style: TextStyle(color: Colors.white),
                        )))
                        .toList()
                        : [Text("Son hali")],
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ?
                    //BU KULANIM CHIP YAPISI
                    widget.pokemon.weaknesses
                        .map((weakness) => Chip(
                        backgroundColor: Colors.red.shade300,
                        label: Text(
                          weakness,
                          style: TextStyle(color: Colors.white),
                        )))
                        .toList()
                        : [Text("Zayıflığı yok")],
                  ),
                ],
              ),
            ) ,flex: 4,)
          ],
        ),
      );
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * 0.66,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    "Height  : " + widget.pokemon.height,
                  ),
                  Text(
                    "Weight  : " + widget.pokemon.weight,
                  ),
                  Text(
                    "Types : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //burda liste olarak her pokemon için tipler geliyor
                    //MAPPING YAPILIYOR...
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                              backgroundColor: Colors.deepPurpleAccent.shade100,
                              label: Text(
                                tip,
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  ),
                  Text(
                    "Pre Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((evolution) => Chip(
                                backgroundColor: Colors.purpleAccent,
                                label: Text(
                                  evolution.name,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("İlk hali")],
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  evolution.name,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("Son hali")],
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ?
                        //BU KULANIM CHIP YAPISI
                        widget.pokemon.weaknesses
                            .map((weakness) => Chip(
                                backgroundColor: Colors.red.shade300,
                                label: Text(
                                  weakness,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("Zayıflığı yok")],
                  ),
                ],
              ),),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                height: 200,
                width: 200,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }
}
