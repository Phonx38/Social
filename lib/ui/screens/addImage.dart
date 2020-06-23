import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:memester/ui/widgets/videopreview.dart';
import 'package:memester/ui/widgets/imagePreview.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:memester/providers/camProvider.dart';


class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with TickerProviderStateMixin{
    TabController _tabController;
  ScrollController _scrollController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
  }


  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black
    ));
    return Scaffold(  
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: Container(
        height: 30,
        child: TabBar(
                  
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  tabs: <Widget>[
                    Container(
                         alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width/5.5,
                        child: Tab(
                          text: "Memes" ?? '',
                          // iconMargin: EdgeInsets.all(3),
                          // icon: Icon(FontAwesome.smile_o,color: Colors.yellow,size: 20,),

                        )
                      ),
                  
                     
                     Container(
                         alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width /5.5,
                        child: Tab(
                          text: "Gallery" ?? '',
                          // iconMargin: EdgeInsets.all(3),
                          // icon: Icon(Feather.image,size: 20,),

                        )
                      ),
                      Container(
                         alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width /5.5,
                        child: Tab(
                          text: "Camera" ?? '',
                          // iconMargin: EdgeInsets.all(3),
                          // icon: Icon(FontAwesome.camera,size: 20,),

                        )
                      ),
                      Container(
                         alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width /5.5,
                        child: Tab(
                          text: "Text" ?? '',
                          // iconMargin: EdgeInsets.all(3),
                          // icon: Icon(Icons.format_quote,size: 20,),

                        )
                      )

                  ],
                  controller: _tabController,

                  
                ),
      ),
              body: TabBarView(   
                      
                children: <Widget>[
                  Memes(),
                  Gallery(),
                  MyCamera(),
                  Quotes()
                 
                ],
                controller: _tabController,
              ),
        
    
    );
  }
}


class MyCamera extends StatefulWidget {
  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  @override
  Widget build(BuildContext context) {
     final CamController camController = Provider.of<CamController>(context);

    var size = MediaQuery.of(context).size;
    if (camController.getController() != null) {
      if (!camController.getController().value.isInitialized) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
                width: size.width,
                height: size.height,
                child: GestureDetector(
                    onDoubleTap: () => camController.reverseCam(),
                    child: CameraPreview(camController.getController()))),
            Positioned(
                right: 20,
                child: IconButton(
                    icon: Icon(Icons.switch_camera, color: Colors.white),
                    onPressed: () {
                      camController.reverseCam();
                    }))
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: Colors.white,
      );
  }
}



// class MyCamera extends StatefulWidget {
  
//   @override
//   _MyCameraState createState() => _MyCameraState();
// }

// class _MyCameraState extends State<MyCamera> {
//   List<CameraDescription> cameras;
//   CameraController controller;
//   bool _isReady = false;
//   bool isvid = false;
//    String videoPath = '';
//   String tempPath = '';
//   bool _buttonPressed = false;
//   bool _loopActive = false;
//   int _counter = 0;


//    @override
//   void initState() {
//     super.initState();
//     _setupCameras();
//   }


//     void _increaseCounterWhilePressed() async {
//     // make sure that only one loop is active
//     if (_loopActive) return;

//     _loopActive = true;

//     while (_buttonPressed && _counter < 100) {
//       // do your thing
//       setState(() {
//         _counter++;
//         // print(_counter.toString());
//       });

//       // wait a bit
//       await Future.delayed(Duration(milliseconds: 40));
//     }

//     _loopActive = false;
//   }

//       takePicture(context) async {
//       try {
//         final path = join(tempPath, 'snap_cam_${DateTime.now()}.jpg');

//         await controller.takePicture(path); //take photo
//         print('Image taken and saved to ' + path);
//         var imgFile = File(path);

//         var res = await Navigator.push(context, MaterialPageRoute(builder: (_) {
//           return ImagePreview(
//             imageFile: imgFile,
//           );
//         }));

//         if (res == null) {
//           print('deleting ' + path);
//           imgFile.deleteSync();
//         }
//       } catch (e) {
//         print(e);
//       }
//     }

//     takeVideo() async {
//       print('taking video');
//       try {
//         controller.prepareForVideoRecording()
//             .then((_) async {
//           final path = join(
//             tempPath, //Temporary path
//             'snap_cam_${DateTime.now()}.mp4',
//           );
//           setState(() {
//             videoPath = path;
//             print("video path: " + path);
//           });

          
              
//               controller.startVideoRecording(path)
//               .then((value) {});
//         });
//       } catch (e) {
//         print('error while taking video');
//       }
//     }


//     stopRecording(context) async {
//       if (!controller.value.isRecordingVideo) return;
//       setState(() {
//         _counter = 0;
//         _buttonPressed = false;
//       });
//       await controller.stopVideoRecording();
//       print('recording stopped');
//       var res = await Navigator.push(context, MaterialPageRoute(builder: (_) {
//         return VideoPreview(videoFile: File(videoPath));
//       }));
//       if (res == null) {
//         File(videoPath).delete();
//       }
//     }

//    Future<void> _setupCameras() async {
//     try {
//       // initialize cameras.
//       cameras = await availableCameras();
//       // initialize camera controllers.
//       controller = new CameraController(cameras[0], ResolutionPreset.veryHigh);
//       await controller.initialize();
//     } on CameraException catch (_) {
//       // do something on error.
//     }
//     if (!mounted) return;
//     setState(() {
//       _isReady = true;
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//   Widget cameraWidget(context) {
//     // get screen size
//     final size = MediaQuery.of(context).size;

//     // calculate scale for aspect ratio widget
//     var scale = controller.value.aspectRatio / size.aspectRatio;

//     // check if adjustments are needed...
//     if (controller.value.aspectRatio < size.aspectRatio) {
//       scale = 1 / scale;
//     }

//     return Transform.scale(
//       scale: scale,
//       child: Center(
//         child: AspectRatio(
//           aspectRatio: controller.value.aspectRatio,
//           child: CameraPreview(controller),
//         ),
//       ),
//     );
//    }

//   @override
//   Widget build(BuildContext context) {
//     if(!_isReady){
//       return new Container();
//     }
//     return Stack(
//       children: <Widget>[
//         Scaffold(
          
//           backgroundColor: Colors.black,
//           floatingActionButton: Listener(
//               onPointerDown: (_counter >= 100) ?
//               (_){
//                 stopRecording(context);
//               }
//               :(details){
//                 _buttonPressed = true;
//                 Future.delayed(Duration(seconds: 200),(){
//                   if(_buttonPressed){
//                     if(!controller.value.isRecordingVideo){
//                       _increaseCounterWhilePressed();
//                         takeVideo();
//                     }
//                     else{
//                       takePicture(context);
//                     }
//                   }
//                 });
//               },
//               onPointerUp: (details)async{
//                 _buttonPressed = false;
//               print('released');

//               if (controller.value.isRecordingVideo) {
//                 await stopRecording(context);
//               }

//               },
          
            
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//                 shape: BoxShape.circle
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: FloatingActionButton(
//                   backgroundColor: Colors.white,
//                   onPressed: (){
                    
//                   },
//                   elevation: 10,
//                   child: isvid?Icon(Feather.video,color: Colors.black,size: 25,):Icon(Feather.camera,color: Colors.black,size: 25,),
//                   ),
//               ),
//             ),
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//           body:cameraWidget(context)
//         ),
//       ],
//     );
//   }
// }

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}


class Memes extends StatefulWidget {
  @override
  _MemesState createState() => _MemesState();
}

class _MemesState extends State<Memes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Memes',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      )
    );
  }
}


class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Quotes',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      )
    );
  }
}