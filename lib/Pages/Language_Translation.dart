import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {

  var languages = ['English', 'Hindi', 'Malayalam'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translates(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return "en";
    } else if (language == "Hindi") {
      return "hi";
    } else if (language == "Malayalam") {
      return "ml";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Language Translator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            hint: Text(
                              originLanguage,
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: languages.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                child: Text(dropDownStringItem, style: TextStyle(color: Colors.deepPurple)),
                                value: dropDownStringItem,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                originLanguage = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 40),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.white,
                            hint: Text(
                              destinationLanguage,
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: languages.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                child: Text(dropDownStringItem, style: TextStyle(color: Colors.deepPurple)),
                                value: dropDownStringItem,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                destinationLanguage = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      autofocus: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Please Enter Your Text",
                        labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                        fillColor: Colors.white.withOpacity(0.2),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      controller: languageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter text to translate';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        translates(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
                      },
                      child: Text("Translate", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Text(
                      output,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
