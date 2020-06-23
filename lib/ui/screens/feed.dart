// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:ui';
// import 'package:memester/helper/colors.dart';
// import 'package:memester/providers/auth.dart';
// import 'package:provider/provider.dart';

// class Feed extends StatefulWidget {
//   @override
//   _FeedState createState() => _FeedState();
// }

// class _FeedState extends State<Feed>  with SingleTickerProviderStateMixin{
//   TabController _tabController;
//   ScrollController _scrollController;
  
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _scrollController = ScrollController();
//   }


//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     // TODO: implement dispose
//     super.dispose();

//   }
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     return Scaffold(
//       body: NestedScrollView(
//         controller: _scrollController,
//         headerSliverBuilder: (BuildContext context,bool boxIsScrolled){
//           return <Widget>[
//             SliverAppBar(
//               backgroundColor: secondaryColor,
//               centerTitle: true,
//               title: Text(
//                 'Memester',
//                style: GoogleFonts.monoton(
//                  textStyle:TextStyle(
//                               color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20
//                           ),
//                )
                  
              
//               ),

//               leading: GestureDetector(
//                 onTap: (){
//                    auth.gLoggedIn ? auth.gSignOut(context):auth.signOut(context);
//                 },
//                 child: Icon(Icons.sort,color: Colors.white,size: 25,)),
              
//               pinned: true,
//               floating: true,
//               snap: false,
//               forceElevated: boxIsScrolled,
//               bottom: TabBar(
                
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 tabs: <Widget>[
                
                   
//                    Container(
//                        alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width /4,
//                       child: Tab(
//                         text: "Explore" ?? '',

//                       )
//                     ),
//                     Container(
//                        alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width /4,
//                       child: Tab(
//                         text: "Feed" ?? '',

//                       )
//                     ),
//                     Container(
//                        alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width / 4,
//                       child: Tab(
//                         text: "Dashboard" ?? '',

//                       )
//                     )

//                 ],
//                 controller: _tabController,

                
//               ),
//             ),
            
            
//           ];
//         },
//         body: TabBarView(
          
//           children: <Widget>[
           
//             Explore(),
//             Videos(),
//             DashBoard()
//           ],
//           controller: _tabController,
//         ),
//         ),
//     );
//   }
// }


// class Explore extends StatefulWidget {
//   @override
//   _ExploreState createState() => _ExploreState();
// }

// class _ExploreState extends State<Explore> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }


// class Videos extends StatefulWidget {
//   @override
//   _VideosState createState() => _VideosState();
// }

// class _VideosState extends State<Videos> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }


// class DashBoard extends StatefulWidget {
//   @override
//   _DashBoardState createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }


import 'package:flutter/material.dart';


class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}