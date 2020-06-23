import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:memester/helper/colors.dart';
import 'package:memester/models/user.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      


     body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 150,
            floating: true,
            pinned: true,

            flexibleSpace: FlexibleSpaceBar(
              
              background: Image.asset(
                "images/c.gif",
                fit: BoxFit.cover,
              ),
            ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainSearch()));
                      },
                      child: Card(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 45.0,
                          width: 330.0,
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Feather.search,color: Colors.white,),
                                SizedBox(width:15),
                                Center(
                                  child: Text('Search...',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),),
                                )
                            ],),
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            
          ),
         
         
           

        ],
              ),
    );
    
  }
}








class MainSearch extends StatefulWidget {
  @override
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> with AutomaticKeepAliveClientMixin<MainSearch>{
   final userReference = Firestore.instance.collection("users");
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;


  emptySearchField(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchTextEditingController.clear());
    setState(() {
      futureSearchResults = null;
    });
  }

  controlSearching(String str){
    Future<QuerySnapshot> allUsers =userReference.where("profileName", isGreaterThanOrEqualTo: str).getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  Container displayNoSearchResult(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(FontAwesome.group,color:Colors.grey[400],size: 100,),
            SizedBox(height:10),
            Center(
              child: Text(
                'Search Results',
                style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,fontSize: 20),
              ),
            )

          ],
        ),
      )
    );
  }


 displayUserFound(){
    return FutureBuilder(
      future:futureSearchResults ,
      builder: (context,AsyncSnapshot dataSnapshot){

        if(!dataSnapshot.hasData){
          return Center(child: CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(secondaryColor),
          ));
        }
        else if(dataSnapshot.data.documents.length == 0){
          return Center(
            child: Text('No users found with this name',style: TextStyle(
              color: Colors.black87
            ),),
          );
        }
        List<UserResults> searchUserResult =[];
        dataSnapshot.data.documents.forEach((document){
          User eachUser = User.fromDocument(document);
          UserResults userResults = UserResults(eachUser);
          searchUserResult.add(userResults);
        });

        return ListView(
          children: searchUserResult
          );
      }
      );
  }
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: TextFormField(
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87
            ),
            controller: searchTextEditingController,
            decoration: InputDecoration(
              hintText: 'Search here',
              hintStyle: TextStyle(color:Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey
                )
              ),
              focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black
                )
              ),
              prefixIcon: IconButton(icon: Icon(Icons.arrow_back,color:Colors.black87), onPressed: ()=>Navigator.pop(context)),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 30,color: Colors.grey,),
                onPressed: emptySearchField,
                )
            ),
            onFieldSubmitted: (str){
              if(str.isNotEmpty){
                controlSearching(str);
              }
            },
          ),
        ),
        body: futureSearchResults == null ? displayNoSearchResult() :displayUserFound(),
      ),
    );
  }

  
}



class UserResults extends StatelessWidget {
  final User eachUser;
  UserResults(this.eachUser);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: ()=>print('Tapped'),
              child:  ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(
                    eachUser.url ?? '',

                  ),
                  
                ),
                title: Text(eachUser.profileName,style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                subtitle: Text(eachUser.username ?? '',style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}