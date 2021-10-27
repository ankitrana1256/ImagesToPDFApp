import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<File> images = [];

  @override
  Widget build(BuildContext context) {
    // bool isNull = true;
    final _size = MediaQuery.of(context).size;
    Future<void> getImage(ImageSource source) async {
      try {
        File imageFile = File(
          await ImagePicker().pickImage(source: source).then(
                (pickedFile) => pickedFile!.path,
              ),
        );

        setState(() {
          // isNull = false;
          images.insert(0, imageFile);
        });
      } on PlatformException catch (e) {
        print("Failed to get access");
      }
      return;
    }

    void clear() {
      setState(() {
        images = [];
        // isNull = true;
      });
    }

    // Future<List<int>> _readImageData(String name) async {
    //   final ByteData data = await rootBundle.load('images/$name');
    //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // }

    // Future<void> _convertImageToPDF() async {
    //   //Create the PDF document
    //   PdfDocument document = PdfDocument();
    //   //Add the page
    //   PdfPage page = document.pages.add();
    //   //Load the image.
    //   final PdfImage image =
    //       PdfBitmap(await _readImageData('Autumn Leaves.jpg'));
    //   //draw image to the first page
    //   page.graphics.drawImage(
    //       image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
    //   //Save the docuemnt
    //   List<int> bytes = document.save();
    //   //Dispose the document.
    //   document.dispose();
    // }

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        width: _size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.jpeg",
                  height: _size.height / 12,
                ),
                SizedBox(
                  width: _size.width / 40,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "The Hamas",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: _size.height / 30,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: Colors.black),
              height: _size.height / 2,
              width: _size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    // ? Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [

                    //       Icon(
                    //         Icons.hourglass_bottom,
                    //         color: Colors.white,
                    //         size: 50,
                    //       ),
                    //       Text(
                    //         "\nPlease select your files",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 24,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   )
                    // :
                    GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1.27,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: images.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.green,
                        image: DecorationImage(
                          image: FileImage(
                            images[index],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            Container(
              height: _size.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () => clear(),
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => getImage(ImageSource.camera),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: _size.height / 15,
                  width: _size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.deepPurpleAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 4),
                            blurRadius: 4)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: _size.height / 24,
                      ),
                      SizedBox(
                        width: _size.width / 40,
                      ),
                      const Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => getImage(ImageSource.gallery),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: _size.height / 15,
                  width: _size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: Colors.deepPurpleAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 4),
                            blurRadius: 4)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_sharp,
                        color: Colors.white,
                        size: _size.height / 24,
                      ),
                      SizedBox(
                        width: _size.width / 40,
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
