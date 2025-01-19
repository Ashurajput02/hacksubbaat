// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:path/path.dart' as path; // Import path package for file name
// // // import 'package:krishiguru/screens/result.dart'; // Import the result screen

// // // class UploadFileNextScreen extends StatefulWidget {
// // //   @override
// // //   _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
// // // }

// // // class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
// // //   File? _selectedFile;
// // //   String? _selectedCropType;

// // //   Future<void> _selectFile() async {
// // //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// // //       type: FileType.custom,
// // //       allowedExtensions: ['pdf'],
// // //     );

// // //     if (result != null) {
// // //       setState(() {
// // //         _selectedFile = File(result.files.single.path!);
// // //       });
// // //     }
// // //   }

// // //   Future<void> _submit() async {
// // //     if (_selectedFile == null || _selectedCropType == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Please upload a file and select a crop type')),
// // //       );
// // //       return;
// // //     }

// // //     try {
// // //       var uri =
// // //           Uri.parse('http://192.168.222.240:3000/predict/file/random_forest');
// // //       var request = http.MultipartRequest('POST', uri)
// // //         ..files.add(await http.MultipartFile.fromPath(
// // //             'inputFile', _selectedFile!.path)) // Add the file
// // //         ..fields['cropType'] = _selectedCropType!; // Add cropType field

// // //       var response = await request.send();

// // //       if (response.statusCode == 200) {
// // //         var responseData = await response.stream.bytesToString();

// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (context) => Result(
// // //               value: 0,
// // //               score: 20,
// // //               resultText: responseData,
// // //             ),
// // //           ),
// // //         );
// // //       } else {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //               content: Text('Failed to upload file: ${response.reasonPhrase}')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('An error occurred: $e')),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Center(
// // //       child: Scaffold(
// // //         appBar: AppBar(title: Text('Upload File and Select Crop Type')),
// // //         body: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Center(
// // //             child: Column(
// // //               children: [
// // //                 SizedBox(
// // //                   height: screenHeight * 0.33,
// // //                 ),
// // //                 ElevatedButton(
// // //                   style:
// // //                       ElevatedButton.styleFrom(backgroundColor: Colors.black),
// // //                   onPressed: _selectFile,
// // //                   child: Text('Select File',
// // //                       style: TextStyle(color: Colors.white)),
// // //                 ),
// // //                 SizedBox(height: screenHeight * 0.03),),

// // //                 // Display the selected file name
// // //                 if (_selectedFile != null)
// // //                   Text('Selected File: ${path.basename(_selectedFile!.path)}'),

// // //                 SizedBox(height: screenHeight * 0.03),),
// // //                 DropdownButton<String>(
// // //                   value: _selectedCropType,
// // //                   hint: Text('Select Crop Type'),
// // //                   items: <String>[
// // //                     'Wheat',
// // //                     'Rice',
// // //                     'Corn',
// // //                     'Barley'
// // //                   ] // Example crop types
// // //                       .map((String crop) {
// // //                     return DropdownMenuItem<String>(
// // //                       value: crop,
// // //                       child: Text(crop),
// // //                     );
// // //                   }).toList(),
// // //                   onChanged: (String? newValue) {
// // //                     setState(() {
// // //                       _selectedCropType = newValue;
// // //                     });
// // //                   },
// // //                 ),
// // //                 SizedBox(height: screenHeight * 0.03),),
// // //                 ElevatedButton(
// // //                   style:
// // //                       ElevatedButton.styleFrom(backgroundColor: Colors.black),
// // //                   onPressed: _submit,
// // //                   child: Text('Submit', style: TextStyle(color: Colors.white)),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // //adding hectare in the screen
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:path/path.dart' as path; // Import path package for file name
// // import 'package:responsive_builder/responsive_builder.dart';

// // class UploadFileNextScreen extends StatefulWidget {
// //   @override
// //   _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
// // }

// // class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
// //   File? _selectedFile;
// //   String? _selectedCropType;
// //   TextEditingController _landSizeController = TextEditingController();
// //   String _selectedUnit = 'Hectare'; // Default unit for land size

// //   Future<void> _selectFile() async {
// //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// //       type: FileType.custom,
// //       allowedExtensions: ['pdf'],
// //     );

// //     if (result != null) {
// //       setState(() {
// //         _selectedFile = File(result.files.single.path!);
// //       });
// //     }
// //   }

// //   Future<void> _submit() async {
// //     if (_selectedFile == null ||
// //         _selectedCropType == null ||
// //         _landSizeController.text.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //             content: Text(
// //                 'Please upload a file, select a crop type, and enter land size')),
// //       );
// //       return;
// //     }

// //     try {
// //       var uri = Uri.parse(
// //           'http://172.22.0.150:3000/predict/file/random_forest'); //doubt
// //       var request = http.MultipartRequest('POST', uri)
// //         ..files.add(await http.MultipartFile.fromPath(
// //             'inputFile', _selectedFile!.path)) // Add the file
// //         ..fields['cropType'] = _selectedCropType!; // Add cropType field

// //       var response = await request.send(); //prediction

// //       if (response.statusCode == 200) {
// //         var responseData = await response.stream.bytesToString();
// //         print("hey there fr test" + responseData);
// //         // Navigator.push(
// //         //   context,
// //         //   MaterialPageRoute(
// //         //     builder: (context) => Result(
// //         //       value: 0,
// //         //       score: 20,
// //         //       resultText: responseData,
// //         //     ),
// //         //   ),
// //         // );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //               content: Text('Failed to upload file: ${response.reasonPhrase}')),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('An error occurred: $e')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ResponsiveBuilder(
// //       builder: (context, sizingInformation) {
// //         return Center(
// //           child: Scaffold(
// //             appBar: AppBar(title: Text('Upload File and Select Crop Type')),
// //             body: SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   children: [
// //                     SizedBox(
// //                       height: screenHeight * 0.33,
// //                     ),
// //                     ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.black),
// //                       onPressed: _selectFile,
// //                       child: Text('Select File',
// //                           style: TextStyle(color: Colors.white)),
// //                     ),
// //                     SizedBox(height: screenHeight * 0.03),),

// //                     // Display the selected file name
// //                     if (_selectedFile != null)
// //                       Text(
// //                           'Selected File: ${path.basename(_selectedFile!.path)}'),

// //                     SizedBox(height: screenHeight * 0.03),),
// //                     DropdownButton<String>(
// //                       value: _selectedCropType,
// //                       hint: Text('Select Crop Type'),
// //                       items: <String>['Wheat', 'Rice', 'Corn', 'Barley']
// //                           .map((String crop) {
// //                         return DropdownMenuItem<String>(
// //                           value: crop,
// //                           child: Text(crop),
// //                         );
// //                       }).toList(),
// //                       onChanged: (String? newValue) {
// //                         setState(() {
// //                           _selectedCropType = newValue;
// //                         });
// //                       },
// //                     ),
// //                     SizedBox(height: screenHeight * 0.03),),

// //                     // Land Size TextField with Dropdown
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: TextField(
// //                             controller: _landSizeController,
// //                             keyboardType: TextInputType.number,
// //                             decoration: InputDecoration(
// //                               labelText: 'Enter Land Size',
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(width: 10),
// //                         DropdownButton<String>(
// //                           value: _selectedUnit,
// //                           items: <String>['Hectare', 'Acre', 'Bigha']
// //                               .map((String unit) {
// //                             return DropdownMenuItem<String>(
// //                               value: unit,
// //                               child: Text(unit),
// //                             );
// //                           }).toList(),
// //                           onChanged: (String? newValue) {
// //                             setState(() {
// //                               _selectedUnit = newValue!;
// //                             });
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: screenHeight * 0.03),),

// //                     ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.black),
// //                       onPressed: _submit,
// //                       child:
// //                           Text('Submit', style: TextStyle(color: Colors.white)),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// //adding the changes :
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path; // Import path package for file name
// import 'package:responsive_builder/responsive_builder.dart';

// class UploadFileNextScreen extends StatefulWidget {
//   @override
//   _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
// }

// class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
//   File? _selectedFile;
//   String? _selectedCropType;
//   String? _selectedSoilType;
//   TextEditingController _landSizeController = TextEditingController();
//   String _selectedUnit = 'Hectare'; // Default unit for land size

//   // Helper function for primary buttons
//   Widget primaryButton({required VoidCallback func, required String text}) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//       onPressed: func,
//       child: Text(text, style: TextStyle(color: Colors.white)),
//     );
//   }

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
//     if (_selectedFile == null ||
//         _selectedCropType == null ||
//         _selectedSoilType == null ||
//         _landSizeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 'Please upload a file, select a crop type, soil type, and enter land size')),
//       );
//       return;
//     }

//     try {
//       var uri = Uri.parse(
//           'http://172.22.0.150:3000/predict/file/random_forest'); // API endpoint
//       var request = http.MultipartRequest('POST', uri)
//         ..files.add(await http.MultipartFile.fromPath(
//             'inputFile', _selectedFile!.path)) // Add the file
//         ..fields['cropType'] = _selectedCropType! // Add cropType field
//         ..fields['soilType'] = _selectedSoilType!; // Add soilType field

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         print("Response: $responseData");
//         // Handle navigation or display the result here
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
//     return ResponsiveBuilder(
//       builder: (context, sizingInformation) {
//         return Center(
//           child: Scaffold(
//             appBar: AppBar(title: Text('Upload File and Select Crop Type')),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: screenHeight * 0.33,
//                     ),
//                     primaryButton(func: _selectFile, text: 'Select File'),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Display the selected file name
//                     if (_selectedFile != null)
//                       Text(
//                           'Selected File: ${path.basename(_selectedFile!.path)}'),

//                     SizedBox(height: screenHeight * 0.03),),
//                     DropdownButton<String>(
//                       value: _selectedCropType,
//                       hint: Text('Select Crop Type'),
//                       items: <String>['Wheat', 'Rice', 'Corn', 'Barley']
//                           .map((String crop) {
//                         return DropdownMenuItem<String>(
//                           value: crop,
//                           child: Text(crop),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedCropType = newValue;
//                         });
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Soil Type Dropdown
//                     DropdownButton<String>(
//                       value: _selectedSoilType,
//                       hint: Text('Select Soil Type'),
//                       items: <String>['Sandy', 'Loamy', 'Clay', 'Silt', 'Peaty']
//                           .map((String soil) {
//                         return DropdownMenuItem<String>(
//                           value: soil,
//                           child: Text(soil),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedSoilType = newValue;
//                         });
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Land Size TextField with Dropdown
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _landSizeController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               labelText: 'Enter Land Size',
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         DropdownButton<String>(
//                           value: _selectedUnit,
//                           items: <String>['Hectare', 'Acre', 'Bigha']
//                               .map((String unit) {
//                             return DropdownMenuItem<String>(
//                               value: unit,
//                               child: Text(unit),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedUnit = newValue!;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     primaryButton(func: _submit, text: 'Submit'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

//adding geolocator and passing temp , humidity and mositure

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:geolocator/geolocator.dart'; // Import geolocator
// import 'package:responsive_builder/responsive_builder.dart';

// class UploadFileNextScreen extends StatefulWidget {
//   @override
//   _UploadFileNextScreenState createState() => _UploadFileNextScreenState();
// }

// class _UploadFileNextScreenState extends State<UploadFileNextScreen> {
//   File? _selectedFile;
//   String? _selectedCropType;
//   String? _selectedSoilType;
//   TextEditingController _landSizeController = TextEditingController();
//   String _selectedUnit = 'Hectare';
//   double? _temperature;
//   double? _humidity;
//   double? _moisture;

//   // Helper function for primary buttons
//   Widget primaryButton({required VoidCallback func, required String text}) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//       onPressed: func,
//       child: Text(text, style: TextStyle(color: Colors.white)),
//     );
//   }

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

//   // Get user location and fetch weather data
//   Future<void> _getWeatherData() async {
//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     // Fetch weather data from WeatherAPI
//     final url = Uri.parse(
//         'http://api.weatherapi.com/v1/current.json?key=d5a3e4558bba482181f131308251801&q=${position.latitude},${position.longitude}');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = response.body;
//       // Parse temperature, humidity, and moisture
//       setState(() {
//         _temperature = _parseWeatherData(data, 'temp_c');
//         _humidity = _parseWeatherData(data, 'humidity');
//         _moisture = _parseWeatherData(
//             data, 'precip_mm'); // Assuming moisture is precipitation
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch weather data')),
//       );
//     }
//   }

//   double _parseWeatherData(String data, String key) {
//     final regex = RegExp('"$key":(.*?),');
//     final match = regex.firstMatch(data);
//     return match != null ? double.tryParse(match.group(1)!) ?? 0.0 : 0.0;
//   }

//   Future<void> _submit() async {
//     if (_selectedFile == null ||
//         _selectedCropType == null ||
//         _selectedSoilType == null ||
//         _landSizeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 'Please upload a file, select a crop type, soil type, and enter land size')),
//       );
//       return;
//     }

//     try {
//       var uri = Uri.parse(
//           'http://172.22.0.150:3000/predict/file/random_forest'); // API endpoint
//       var request = http.MultipartRequest('POST', uri)
//         ..files.add(await http.MultipartFile.fromPath(
//             'inputFile', _selectedFile!.path)) // Add the file
//         ..fields['cropType'] = _selectedCropType! // Add cropType field
//         ..fields['soilType'] = _selectedSoilType!; // Add soilType field

//       // Add weather data to the request
//       if (_temperature != null) {
//         request.fields['temperature'] = _temperature.toString();
//       }
//       if (_humidity != null) {
//         request.fields['humidity'] = _humidity.toString();
//       }
//       if (_moisture != null) {
//         request.fields['moisture'] = _moisture.toString();
//       }

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         print("Response: $responseData");
//         // Handle navigation or display the result here
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
//     return ResponsiveBuilder(
//       builder: (context, sizingInformation) {
//         return Center(
//           child: Scaffold(
//             appBar: AppBar(title: Text('Upload File and Select Crop Type')),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: screenHeight * 0.33,
//                     ),
//                     primaryButton(func: _selectFile, text: 'Select File'),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Display the selected file name
//                     if (_selectedFile != null)
//                       Text(
//                           'Selected File: ${path.basename(_selectedFile!.path)}'),

//                     SizedBox(height: screenHeight * 0.03),),
//                     DropdownButton<String>(
//                       value: _selectedCropType,
//                       hint: Text('Select Crop Type'),
//                       items: <String>['Wheat', 'Rice', 'Corn', 'Barley']
//                           .map((String crop) {
//                         return DropdownMenuItem<String>(
//                           value: crop,
//                           child: Text(crop),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedCropType = newValue;
//                         });
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Soil Type Dropdown
//                     DropdownButton<String>(
//                       value: _selectedSoilType,
//                       hint: Text('Select Soil Type'),
//                       items: <String>['Sandy', 'Loamy', 'Clay', 'Silt', 'Peaty']
//                           .map((String soil) {
//                         return DropdownMenuItem<String>(
//                           value: soil,
//                           child: Text(soil),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedSoilType = newValue;
//                         });
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     // Land Size TextField with Dropdown
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _landSizeController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               labelText: 'Enter Land Size',
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         DropdownButton<String>(
//                           value: _selectedUnit,
//                           items: <String>['Hectare', 'Acre', 'Bigha']
//                               .map((String unit) {
//                             return DropdownMenuItem<String>(
//                               value: unit,
//                               child: Text(unit),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedUnit = newValue!;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: screenHeight * 0.03),),

//                     primaryButton(func: _submit, text: 'Submit'),

//                     // Optionally fetch weather data when page loads
//                     ElevatedButton(
//                       onPressed: _getWeatherData,
//                       child: Text('Get Weather Data'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

//submit pe click karte hi api call ho jaa rhi hai :

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:geolocator/geolocator.dart'; // Import geolocator
import 'package:piwot2/components/fertilizer.dart';
import 'package:piwot2/components/primaryButton.dart';
import 'package:responsive_builder/responsive_builder.dart';


class Fertilizer extends StatefulWidget {
  @override
  _FertilizerState createState() => _FertilizerState();
}

class _FertilizerState extends State<Fertilizer> {
  File? _selectedFile;
  String? _selectedCropType;
  String? _selectedSoilType;
  TextEditingController _landSizeController = TextEditingController();
  String _selectedUnit = 'Hectare';
  double? _temperature;
  double? _humidity;
  double? _moisture;

 
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

  double _parseWeatherData(String data, String key) {
    final regex = RegExp('"$key":(.*?),');
    final match = regex.firstMatch(data);
    return match != null ? double.tryParse(match.group(1)!) ?? 0.0 : 0.0;
  }

  // Future<void> _submit() async {
  //   if (_selectedFile == null ||
  //       _selectedCropType == null ||
  //       _selectedSoilType == null ||
  //       _landSizeController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //               'Please upload a file, select a crop type, soil type, and enter land size')),
  //     );
  //     return;
  //   }

  //   try {
  //     // Get the user's current location and fetch weather data
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     final weatherUrl = Uri.parse(
  //         'http://api.weatherapi.com/v1/current.json?key=d5a3e4558bba482181f131308251801&q=${position.latitude},${position.longitude}');
  //     final weatherResponse = await http.get(weatherUrl);

  //     if (weatherResponse.statusCode == 200) {
  //       final weatherData = weatherResponse.body;

  //       // Parse temperature, humidity, and moisture
  //       _temperature = _parseWeatherData(weatherData, 'temp_c');
  //       _humidity = _parseWeatherData(weatherData, 'humidity');
  //       _moisture = _parseWeatherData(
  //           weatherData, 'precip_mm'); // Precipitation as moisture
  //     } else {
  //       throw Exception('Failed to fetch weather data');
  //     }

  //     // Prepare the request to the backend API
  //     var uri = Uri.parse(
  //         'http://172.22.0.150:3000/predict/file/random_forest'); // Your API endpoint
  //     var request = http.MultipartRequest('POST', uri)
  //       ..files.add(await http.MultipartFile.fromPath(
  //           'inputFile', _selectedFile!.path)) // Add the file
  //       ..fields['cropType'] = _selectedCropType! // Add cropType field
  //       ..fields['soilType'] = _selectedSoilType! // Add soilType field
  //       ..fields['landSize'] = _landSizeController.text // Add land size
  //       ..fields['unit'] = _selectedUnit; // Add unit of land size

  //     // Add weather data to the request
  //     if (_temperature != null) {
  //       request.fields['temperature'] = _temperature.toString();
  //     }
  //     if (_humidity != null) {
  //       request.fields['humidity'] = _humidity.toString();
  //     }
  //     if (_moisture != null) {
  //       request.fields['moisture'] = _moisture.toString();
  //     }

  //     // Send the request
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.bytesToString();
  //       print("Response: $responseData");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('File uploaded successfully!')),
  //       );
  //       // Optionally navigate or handle the response data
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             content: Text('Failed to upload file: ${response.reasonPhrase}')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred: $e')),
  //     );
  //   }
  // }

  //submit buton ko modify kara to have output screen alag se

  bool _isLoading = false;
  Future<void> _submit() async {
    if (_selectedFile == null ||
        _selectedCropType == null ||
        _selectedSoilType == null ||
        _landSizeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please upload a file, select a crop type, soil type, and enter land size')),
      );
      return;
    }
    setState(() {
      _isLoading = true; // Start the loading indicator
    });

    try {
      // Get the user's current location and fetch weather data
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final weatherUrl = Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=d5a3e4558bba482181f131308251801&q=${position.latitude},${position.longitude}');
      final weatherResponse = await http.get(weatherUrl);

      if (weatherResponse.statusCode == 200) {
        final weatherData = weatherResponse.body;

        // Parse temperature, humidity, and moisture
        _temperature = _parseWeatherData(weatherData, 'temp_c');
        _humidity = _parseWeatherData(weatherData, 'humidity');
        _moisture = _parseWeatherData(weatherData, 'precip_mm');
      } else {
        throw Exception('Failed to fetch weather data');
      }

      // Prepare the request to the backend API
      var uri = Uri.parse(
          'http://172.22.0.150:3000/predict/file/random_forest'); // Your API endpoint
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
            'inputFile', _selectedFile!.path)) // Add the file
        ..fields['cropType'] = _selectedCropType! // Add cropType field
        ..fields['soilType'] = _selectedSoilType! // Add soilType field
        ..fields['landSize'] = _landSizeController.text // Add land size
        ..fields['unit'] = _selectedUnit; // Add unit of land size

      // Add weather data to the request
      if (_temperature != null) {
        request.fields['temperature'] = _temperature.toString();
      }
      if (_humidity != null) {
        request.fields['humidity'] = _humidity.toString();
      }
      if (_moisture != null) {
        request.fields['moisture'] = _moisture.toString();
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("Response: $responseData");

        setState(() {
          _isLoading = false; // Stop the loading indicator
        });

        // Navigate to OutputScreen with the response data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FertilizerScreen(responseData: responseData),
          ),
        );
      } else {
        setState(() {
          _isLoading = false; // Stop the loading indicator
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to upload file: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop the loading indicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return _isLoading? Scaffold(body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: screenHeight * 0.03),
            Text('Predicting best fertilizer...', style: TextStyle(fontSize: screenWidth * 0.05)),
          ],
        ))) : 
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Upload File and Select Crop Type', style: TextStyle(color: Colors.white),)),
          body: Stack(
            children:[ 
              Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgrounds/Home.png'),
                  fit: BoxFit.cover,
                ),
              )
              ),
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  Icon(Icons.upload_file, size: screenHeight * 0.2),
                  SizedBox(height: screenHeight * 0.03),
                  Primarybutton(
                        func: _selectFile,
                        ButtonText: Text(
                          'Select File',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainer,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.8,
                      ),
                  SizedBox(height: screenHeight * 0.03),
        
                  // Display the selected file name
                  if (_selectedFile != null)
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                          'Selected File: ${path.basename(_selectedFile!.path)}',textAlign: TextAlign.center,),),
                    
        
                  SizedBox(height: screenHeight * 0.03),
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
                  SizedBox(height: screenHeight * 0.03),
        
                  // Soil Type Dropdown
                  DropdownButton<String>(
                    value: _selectedSoilType,
                    hint: Text('Select Soil Type'),
                    items: <String>['Sandy', 'Loamy', 'Clay', 'Silt', 'Peaty']
                        .map((String soil) {
                      return DropdownMenuItem<String>(
                        value: soil,
                        child: Text(soil),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSoilType = newValue;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
        
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.1),
                          ),
                          child: TextField(
                            controller: _landSizeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Land Size',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                              ),
                              prefixIcon: Icon(
                                Icons.agriculture_rounded,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
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
                  SizedBox(height: screenHeight * 0.03),
                  Primarybutton(
                        func: _submit,
                        ButtonText: Text(
                          'Submit',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainer,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.8,
                      ),
              
                ],
              ),
            ),
            ],
          ),
        );
  }
    );
  }
}
