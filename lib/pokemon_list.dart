import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:flutter_pokedex/pokemon_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  Pokedex pokedex;
  Future<Pokedex> veri;


  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);

    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  //başta bir kez çalışsın başka gitmesi
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (context,orientation){
          if(orientation == Orientation.portrait){
           return FutureBuilder(
              //olaylar burda başlıyor eğer dönen değer beklenen brşeyse biz bunu FutureBuilder iile alıcaz
              //future ise json.body
                future: veri,
                //BURAYA DİKKAT context ve Snapshot var
                builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState == ConnectionState.done) {
                    //Eğer gelen veriler tam ve olduysa
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          //Tıklanabilmesi için
                          var poke = gelenPokedex.data.pokemon[index];
                          return InkWell(
                            onTap: (){
                              //burda detay sayfasına yönlendireceğiz
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokemonDetail(poke),),);
                            },
                            child: Hero(
                                tag: poke.img,
                                child: Card(
                                  elevation: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      //Bu Pokemonun resmi için
                                      Container(
                                        height: 150,
                                        width: 200,
                                        //Burda resim yüklenene kadar geçen sürede görünecek
                                        child: FadeInImage.assetNetwork(
                                          placeholder: "assets/loading.gif",
                                          image: poke.img,fit: BoxFit.contain,),
                                      ),
                                      Text(
                                        poke.name,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                          ); //Center(child: Text(gelenPokedex.data.pokemon[index].name));
                        });
                  } else {
                    return Center(
                      child: Text("Hata oluştu"),
                    );
                  }
                });
          }else{ return FutureBuilder(
            //olaylar burda başlıyor eğer dönen değer beklenen brşeyse biz bunu FutureBuilder iile alıcaz
            //future ise json.body
              future: veri,
              //BURAYA DİKKAT context ve Snapshot var
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState == ConnectionState.done) {
                  //Eğer gelen veriler tam ve olduysa
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        //Tıklanabilmesi için
                        var poke = gelenPokedex.data.pokemon[index];
                        return InkWell(
                          onTap: (){
                            //burda detay sayfasına yönlendireceğiz
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PokemonDetail(poke),),);
                          },
                          child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //Bu Pokemonun resmi için
                                    Container(
                                      height: 150,
                                      width: 200,
                                      //Burda resim yüklenene kadar geçen sürede görünecek
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poke.img,fit: BoxFit.contain,),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )),
                        ); //Center(child: Text(gelenPokedex.data.pokemon[index].name));
                      });
                } else {
                  return Center(
                    child: Text("Hata oluştu"),
                  );
                }
              });

          }
        },

      ),
    );
  }
}
