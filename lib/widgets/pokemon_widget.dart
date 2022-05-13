import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/res/colours.dart';

class PokemonWidget extends StatelessWidget {

  final String name;
  final String desc;
  final bool? isFav;
  final Function()? onTapFav;

  const PokemonWidget({Key? key, required this.name, required this.desc, this.isFav = false, this.onTapFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(name, style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 20.0, color: Colours.colorPrimary),),
        ),
        collapsed: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(desc, style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 16.0, color: Colours.colorText),),
              ),
              const SizedBox(width: 8.0,),
              InkWell(onTap: onTapFav, child: Icon(Icons.favorite, color: isFav! ? Colours.colorFav : Colors.black.withOpacity(0.1),))
            ],
          ),
        ),
        expanded: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(desc, softWrap: true, style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 16.0, color: Colours.colorText),),
              ),
              const SizedBox(width: 8.0,),
              InkWell(onTap: onTapFav, child: Icon(Icons.favorite, color: isFav! ? Colours.colorFav : Colors.black.withOpacity(0.1),))
            ],
          ),
        ),
      ),
    );
  }
}