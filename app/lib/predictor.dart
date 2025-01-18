// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path; // Import path package for file name
// import 'package:krishiguru/screens/result.dart'; // Import the result screen

// class UploadFileNextScreen extends StatefulWidget {
//   @override
//   _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
// }

// class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
//   File? _selectedFile;
//   String? _selectedCropType;

//   Future<void> _selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _submit() async {
//     if (_selectedFile == null || _selectedCropType == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please upload a file and select a crop type')),
//       );
//       return;
//     }

//     try {
//       var uri =
//           Uri.parse('http://192.168.222.240:3000/predict/file/random_forest');
//       var request = http.MultipartRequest('POST', uri)
//         ..files.add(await http.MultipartFile.fromPath(
//             'inputFile', _selectedFile!.path)) // Add the file
//         ..fields['cropType'] = _selectedCropType!; // Add cropType field

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Result(
//               value: 0,
//               score: 20,
//               resultText: responseData,
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Failed to upload file: ${response.reasonPhrase}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Scaffold(
//         appBar: AppBar(title: Text('Upload File and Select Crop Type')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.33,
//                 ),
//                 ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                   onPressed: _selectFile,
//                   child: Text('Select File',
//                       style: TextStyle(color: Colors.white)),
//                 ),
//                 SizedBox(height: 20),

//                 // Display the selected file name
//                 if (_selectedFile != null)
//                   Text('Selected File: ${path.basename(_selectedFile!.path)}'),

//                 SizedBox(height: 20),
//                 DropdownButton<String>(
//                   value: _selectedCropType,
//                   hint: Text('Select Crop Type'),
//                   items: <String>[
//                     'Wheat',
//                     'Rice',
//                     'Corn',
//                     'Barley'
//                   ] // Example crop types
//                       .map((String crop) {
//                     return DropdownMenuItem<String>(
//                       value: crop,
//                       child: Text(crop),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedCropType = newValue;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                   onPressed: _submit,
//                   child: Text('Submit', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//adding hectare in the screen
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path; // Import path package for file name
import 'package:responsive_builder/responsive_builder.dart';

class UploadFileNextScreen extends StatefulWidget {
  @override
  _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
}

class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
  File? _selectedFile;
  String? _selectedCropType;
  TextEditingController _landSizeController = TextEditingController();
  String _selectedUnit = 'Hectare'; // Default unit for land size

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedFile == null ||
        _selectedCropType == null ||
        _landSizeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please upload a file, select a crop type, and enter land size')),
      );
      return;
    }

    try {
      var uri =
          Uri.parse('http://192.168.222.240:3000/predict/file/random_forest');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
            'inputFile', _selectedFile!.path)) // Add the file
        ..fields['cropType'] = _selectedCropType!; // Add cropType field

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("hey there fr test" + responseData);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Result(
        //       value: 0,
        //       score: 20,
        //       resultText: responseData,
        //     ),
        //   ),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to upload file: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Center(
          child: Scaffold(
            appBar: AppBar(title: Text('Upload File and Select Crop Type')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.33,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: _selectFile,
                      child: Text('Select File',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 20),

                    // Display the selected file name
                    if (_selectedFile != null)
                      Text(
                          'Selected File: ${path.basename(_selectedFile!.path)}'),

                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedCropType,
                      hint: Text('Select Crop Type'),
                      items: <String>['Wheat', 'Rice', 'Corn', 'Barley']
                          .map((String crop) {
                        return DropdownMenuItem<String>(
                          value: crop,
                          child: Text(crop),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCropType = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Land Size TextField with Dropdown
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _landSizeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter Land Size',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _selectedUnit,
                          items: <String>['Hectare', 'Acre', 'Bigha']
                              .map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedUnit = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: _submit,
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
