import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApi extends StatefulWidget {
  const GetApi({super.key});
  
  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  List<photos> photoList= [];
  Future<List<photos>> getphoto() async{
    final Response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data= jsonDecode(Response.body.toString());
    print(data);
    if(Response.statusCode==200){
      for(Map i in data){
        photos photo= photos(id: i["id"], title: i["title"], url: i["url"]);
        photoList.add(photo);

      }

      return photoList;

    }else{

    }



    return photoList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APi Calling"),
        // backgroundColor: Color.red,
      ),
      body:  Padding(
          padding: EdgeInsets.only(top: 200), 
          child: SizedBox(
            height: 200,
            child:   Column(children: [
              Text("FOnt style apply",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
              // Image.asset('assets/image.png',scale: 1),




///api data show
Text("Data from api",style: TextStyle(fontSize: 30),),
Expanded(
  child: 
  FutureBuilder(future: getphoto(),builder: (context,AsyncSnapshot<List<photos>> snapshop){
    
    return ListView.builder(itemCount: photoList.length,itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(snapshop.data![index].url.toString())),
          title: Column(children: [
            Text(snapshop.data![index].title),
            Text("Photo Id : "+snapshop.data![index].id.toString())
          ]),
          
        );
    });
  }),
)







              // Container(child: Row(children: [
              //   Row(
                  
              //     children: [Text("1 row")],
              //   ),
              //   Row(
              //     children: [Text("2 row")],
              //   )
                
                
              //   ]),)
        
          ]),
            ),
        ),
      );
      
      
    
  }
}





class photos{
  int id;
  String title,url;
  photos({required this.id,required this.title,required this.url});


}