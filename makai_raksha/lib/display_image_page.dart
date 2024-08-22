import 'dart:typed_data';
import 'package:flutter/material.dart';
//import 'package:maizeplant/generate_pdf.dart';
//import 'package:maizeplant/home_page.dart';
import 'package:makai_raksha/generate_pdf.dart';
import 'package:makai_raksha/home_page.dart';

class DisplayImagePage extends StatefulWidget {
  final Uint8List imageData;
  final String prediction;
  final double confidenceLevel;

  const DisplayImagePage({
    required this.imageData,
    required this.prediction,
    required this.confidenceLevel,
  });

  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  bool _showSymptoms = false;
  bool _showTreatments = false;

  String _getSymptoms(String disease) {
    Map<String, String> diseaseSymptoms = {
      // Blight    Common_Rust     Gray_Leaf_Spot   Healthy
      "Blight":
          "1. पातहरूमा पहेलो धब्बाहरू\n2. शिथिलता\n3. डाँडामा खैरो क्षेत्रहरू\n4. असमय पात पर्नु\n5. फलमा सानो काला धब्बाहरू\n6. कम उत्पादन",
      "Common_Rust":
          "1. पातहरूमा सुन्तला रंगका खामा\n2. पातहरूको पहेले हुन\n3. वृद्धि अवरुद्ध हुनु\n 4. मर्किएका र विकृत पातहरू\n5. डाँडामा पाउडरी सुन्तला बासिदहरू\n6. फलको गुणस्तरमा कमी",
      "Gray_Leaf_Spot":
          "1. पातहरूमा खरानी रंगका धब्बाहरू\n2. पुराना पातहरू पहेले हुनपातहरूको नसालगायत क्षेत्रहरूमा घाउ\n3. धब्बाहरू समयसँगै मृत भागमा परिणत हुनु\n4. असमय पात पर्नु\n5. बिरुवाको स्फूर्ति घट्नु",
      "Healthy": "लक्षणहरू छैनन्। बिरुवा स्वस्थ छ।",
    };

    return diseaseSymptoms[disease] ?? "लक्षणहरू उपलब्ध छैनन्।";
  }

  String _getTreatments(String disease) {
    Map<String, String> diseaseTreatments = {
      "Blight":
          "1. फफूंदनाशक प्रयोग गर्नुहोस्\n2. उचित सिंचाई सुनिश्चित गर्नुहोस्\n3. संक्रमण भएका बिरुवाहरू हटाएर फैलावट रोक्नुहोस्\n4. परतिरोधी प्रजातिका बिरुवाहरू प्रयोग गर्नुहोस्\n5. फसलको परिक्रमा लागू गर्नुहोस्\n6. आर्द्रता कम गर्न उचित बिरुवा दूरी कायम गर्नुहोस्",
      "Common_Rust":
          "1. फफूंदनाशक प्रयोग गर्नुहोस्\n2. प्रभावित पातहरू हटाउनुहोस्\n3. रस्ट प्रतिरोधी प्रजातिका बिरुवाहरू प्रयोग गर्नुहोस्\n4. बिरुवाको प्रतिरोध क्षमता बढाउन उपयुक्त मल प्रयोग गर्नुहोस्\n5. संक्रमण घटाउन फसलको परिक्रमा लागू गर्नुहोस्\n6. रस्ट रोगजनकलाई आश्रय दिन सक्ने झार-प्रबन्धन गर्नुहोस्",
      "Gray_Leaf_Spot":
          "1. फफूंदनाशक प्रयोग गर्नुहोस्\n2. संक्रमणको स्रोत कम गर्न बिरुवाका अवशेष व्यवस्थापन गर्नुहोस्\n3. प्रतिरोधी प्रजातिका बिरुवाहरू प्रयोग गर्नुहोस्\n4. रोगको चक्र तोड्न फसलको परिक्रमा लागू गर्नुहोस्\n5. हावाको प्रवाह सुधार गर्न उचित बिरुवा दूरी कायम गर्नुहोस्\n6. संक्रमणको पहिलो संकेतमा पातमा फफूंदनाशक प्रयोग गर्नुहोस्",
      "Healthy": "उपचार आवश्यक छैन। बिरुवा स्वस्थ छ।",
    };

    return diseaseTreatments[disease] ?? "उपचारहरू उपलब्ध छैनन्।";
  }

  confident() {
    if (widget.confidenceLevel > 71.1) {
      //better to use 51.1 or  85.1 for better not leaf solution

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.memory(widget.imageData),
          SizedBox(height: 20.0),
          //   if(widget.confidenceLevel>70){
          Text(
            'अनुमानित वर्ग: ${widget.prediction}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10.0),
          Text(
            'विश्वास स्तर: ${widget.confidenceLevel.toStringAsFixed(2)} %',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showSymptoms = !_showSymptoms;
              });
            },
            child: Text('लक्षणहरू देखाउनुहोस्'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          SizedBox(height: 10.0),
          if (_showSymptoms)
            Text(
              _getSymptoms(widget.prediction),
              style: TextStyle(fontSize: 16.0),
            ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showTreatments = !_showTreatments;
              });
            },
            child: Text('उपचारहरू देखाउनुहोस्'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          if (_showTreatments)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                _getTreatments(widget.prediction),
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              await GeneratePdfPage.generatePdf(
                imageData: widget.imageData,
                prediction: widget.prediction,
                confidenceLevel: widget.confidenceLevel,
                symptoms: _getSymptoms(widget.prediction),
                treatments: _getTreatments(widget.prediction),
              );
            },
            child: Text('पीडिएफ उत्पन्न गर्नुहोस्'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          SizedBox(height: 10.0),
        ],
      );
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.memory(widget.imageData),
        SizedBox(height: 20.0),
        //   if(widget.confidenceLevel>70){
        Text(
          'मान्य तस्विर होइन। पुन: प्रयास गर्नुहोस्।',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10.0),
        Text(
// 'Confidence Level: ${widget.confidenceLevel.toStringAsFixed(2)} %',
          " बिरुवाको पातको फोटो खिच्नुहोस्। ",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0)
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('तस्विर प्रदर्शन', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0), child: confident()
            /* Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(widget.imageData),
              SizedBox(height: 20.0),
              //   if(widget.confidenceLevel>70){
              Text(
                'Predicted Class: ${widget.prediction}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10.0),
              Text(
                'Confidence Level: ${widget.confidenceLevel.toStringAsFixed(2)} %',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSymptoms = !_showSymptoms;
                  });
                },
                child: Text('Show Symptoms'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              SizedBox(height: 10.0),
              if (_showSymptoms)
                Text(
                  _getSymptoms(widget.prediction),
                  style: TextStyle(fontSize: 16.0),
                ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showTreatments = !_showTreatments;
                  });
                },
                child: Text('Show Treatments'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              if (_showTreatments)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    _getTreatments(widget.prediction),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await GeneratePdfPage.generatePdf(
                    imageData: widget.imageData,
                    prediction: widget.prediction,
                    confidenceLevel: widget.confidenceLevel,
                    symptoms: _getSymptoms(widget.prediction),
                    treatments: _getTreatments(widget.prediction),
                  );
                },
                child: Text('Generate PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),               */
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        child: Icon(Icons.home, color: Colors.white),
        backgroundColor: Colors.green[700],
        tooltip: 'Home',
      ),
    );
  }
}
