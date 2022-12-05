import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  
  Future pickImage(ImageSource source) async{
    try{
    final image = await ImagePicker().pickImage(source: source);
    if (image ==null) return;

    final imageTemporary = File(image.path);
    setState(()=>this.image = imageTemporary);
    } on PlatformException catch(e){
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        child: Column(
          children:[
            Spacer(),
            image != null ? Image.file(image!, width: 160, height:160, fit:BoxFit.cover) : Container(),
          buildButton (
            title : 'Pick from gallery',
            icon: Icons.image_outlined,
            onClicked: () => pickImage(ImageSource.gallery),
          ),
          buildButton(
            title : 'Take a picture',
            icon: Icons.image_outlined,
            onClicked: () => pickImage(ImageSource.camera),
          ) ,
          Spacer()
          ],
        ),
          
        ),
    ); 
  }

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) => ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size.fromHeight(50),
    shape: StadiumBorder(),
    primary: Colors.green,
    onPrimary: Colors.white,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 28),
      const SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    ],
  ),
  onPressed: onClicked,
);