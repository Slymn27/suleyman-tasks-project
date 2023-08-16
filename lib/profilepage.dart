import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'widgets.dart';



const List<String> list = <String>['Prefere not to say','Male','Female','Non-Binary',]; //list of the gender options

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? profilePicture; // Image variable
  DateTime dateofbirth = DateTime.now(); // dateofbirth variable
  bool veganOrNot = false;
  bool studentOrNot = false;
  String dropdownValue = list.first; // dropdown Menu values

  Future getProfilePicture(ImageSource sourcepath) async { //get method for getting the profile picture 
    try {
      final image = await ImagePicker().pickImage(source: sourcepath); //getting the path of the image 
      if (image == null) return;

      final savedImage = await saveFilePermanently(image.path); //saving the image to the local directory
      setState(() {
        profilePicture = savedImage;// changing the profile picture 
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('faild to get image: $e');// showing the error message if we catch an error
      }
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {//method for saving the image to the directory
    final directory = await getApplicationDocumentsDirectory(); //getting the path
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');//accessing the image by its path

    return File(imagePath).copy(image.path);// finding the image from its path and returning the it 
  }

  Future<void> userDateOfBirth(BuildContext context) async { //method for picking a date from the calender
    final DateTime? pickedDate = await showDatePicker( 
      context: context, 
      initialDate: dateofbirth, 
      firstDate: DateTime(1900), //start is 20th century
      lastDate: DateTime(2100)); // end is 21th century 
    if (pickedDate != null && pickedDate != dateofbirth){ //if the user picked a date, change the widget state
      setState(() {
        dateofbirth = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( //making the page scrollable
        child: Column(
          children: [ 
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
               if (profilePicture != null)// if a picture is selected, show it
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: ClipRRect(// making the profile picture circular
                    borderRadius: BorderRadius.circular(45),
                    child: Image.file(profilePicture!, // showing the picture that we get from gallery or camera
                        width: 200, height: 200, fit: BoxFit.cover,
                      ),
                  ),
                )
              else //if the profile picture part is empty, showing the empty user image
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.network(
                      'https://img.freepik.com/free-icon/user_318-644324.jpg',//empty user image
                      width: 200,
                      height: 200
                    ),
                )
              ]
            ),
            Row( //showing 2 options for image selection
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: customButton(//button for selecting the image from the gallery
                    titleOfbutton: 'From Gallery',
                    iconOfbutton: Icons.image,
                    onClickFunction: () => getProfilePicture(ImageSource.gallery), //calling method that gets-->https://www.twitch.tv/lirik
                    //--> the image from the gallery
                  ),
                ),
                const SizedBox( //spacing between the 2 buttons
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: customButton( // button for taking the image by using the camera
                      titleOfbutton: 'Take Picture',
                      iconOfbutton: Icons.camera_enhance,
                      onClickFunction: () => getProfilePicture(ImageSource.camera), //calling method for taking the image
                    ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: SizedBox(//spacing 
                    width: 4,
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
              child: TextField( // text field for the name of the user
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Name',
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
              child: TextField( //text field for the surename of the user
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Surename',
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0,bottom: 15.0),
              child: TextField( //text field for the users nicnname
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                    )
                  ),
                  labelText: 'Nickname',
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider( // spacing by using a divider
              height: 30,
              thickness: 2.5,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( //creating a button that opens the calender
                  onPressed: ()=> userDateOfBirth(context), //calling the method for changing the date
                  child: const Text('Select birth of date',style: TextStyle(fontSize: 20,),),
                ),
                const SizedBox(width: 10,),
                Text('${dateofbirth.toLocal()}'.split(' ')[0], //saving the variable and writing it to the text
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,//creating a dropdown menu for the gender selection
            children: [const Padding(
              padding: EdgeInsets.only(right:15.0),
              child: Text('Gender:',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ,),
            ),
              DropdownButton<String>(
                value: dropdownValue, 
                elevation: 16, 
                style: const TextStyle(color: Color.fromARGB(255, 50, 109, 53),fontSize: 20),
                underline: Container(//simple styling the texts and menu
                  height: 2,
                  color: const Color.fromARGB(255, 50, 109, 53),
                ),
                onChanged: (String? value){
                  setState(() {//chaning the gender on user selection
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value, 
                    child: Text(value),);
                }).toList(),
                ),
            ],
          ),
            const Divider( // spacing by using a divider
              height: 30,
              thickness: 2.5,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
          Row( //creating two switch options for the vegan and student, yes or no questions. 
            mainAxisAlignment: MainAxisAlignment.center,
            children:[//asking if the user is vegan or not, the default value is false
              const Text('I am a Vegetarian/Vegan',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Switch(
                  value: veganOrNot, 
                  activeColor: Colors.green,
                  onChanged: (bool value){
                    setState(() {
                      veganOrNot= value;//changing the value if it is changed
                    });
                  }
                ),
              ),
            ]
            ),
              Row( //switch option for student or not question.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('I am a Student', style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                  Switch(
                    value: studentOrNot, 
                    activeColor: Colors.blue,
                    onChanged: (bool value){
                    setState(() { //changing the value if it is changed
                      studentOrNot= value;
                    });
                  }),
                ],
          )
          ],
        ),
      )),
    );
  }
}
