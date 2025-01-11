// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ScanIDFunctionality extends StatefulWidget {
//   @override
//   _ScanIDFunctionalityState createState() => _ScanIDFunctionalityState();
// }

// class _ScanIDFunctionalityState extends State<ScanIDFunctionality> {
  
//   late TextRecognizer textRecognizer;
//   List<String> capturedTexts = []; 

//   @override
//   void initState() {
//     super.initState();
    
//     textRecognizer = GoogleMlKit.vision.textRecognizer();
//   }

//   Future<void> scanID() async {
    
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);

//     if (image == null) {
//       print('No image selected.');
//       return;
//     }

//     try {
//       final InputImage inputImage = InputImage.fromFilePath(image.path);
//       final RecognizedText recognizedText =
//           await textRecognizer.processImage(inputImage);

      
//       capturedTexts.clear();
      
      
//       for (TextBlock block in recognizedText.blocks) {
        
//         if (_isValidText(block.text)) {
//           capturedTexts.add(block.text);
//           print('Recognized Block: ${block.text}');
//         }

        
//         for (TextLine line in block.lines) {
//           if (_isValidText(line.text)) {
//             capturedTexts.add(line.text);
//             print('Recognized Line: ${line.text}');
//           }
//         }
//       }
      
      
//       setState(() {});
//     } catch (e) {
//       print('Text recognition error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error recognizing text: $e')),
//       );
//     }
//   }

  
//   bool _isValidText(String text) {
    
//     text = text.trim();
//     if (text.isEmpty) return false;

    
//     return 
      
//       RegExp(r'^[0-9]+$').hasMatch(text) ||
      
      
//       RegExp(r'^[A-Za-z\s]+$').hasMatch(text) ||
      
      
//       RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text) ||
      
      
//       RegExp(r'^[A-Za-z0-9\u0600-\u06FF\s]+$').hasMatch(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Scan ID')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: scanID,
//             child: Text('Start Scanning'),
//           ),
//           const SizedBox(height: 20),
          
//           Expanded(
//             child: ListView.builder(
//               itemCount: capturedTexts.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     capturedTexts[index],
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: _getTextColor(capturedTexts[index]),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  
//   Color _getTextColor(String text) {
//     if (RegExp(r'^[0-9]+$').hasMatch(text)) {
//       return Colors.blue; 
//     } else if (RegExp(r'^[A-Za-z\s]+$').hasMatch(text)) {
//       return Colors.green; 
//     } else if (RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text)) {
//       return Colors.red; 
//     }
//     return Colors.black; 
//   }

//   @override
//   void dispose() {
//     textRecognizer.close();
//     super.dispose();
//   }
// }