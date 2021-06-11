import 'package:flutter/material.dart';
import 'package:word_list/data.dart';

class AllWords extends StatefulWidget {
  AllWords(Key k) : super(key: k);

  @override
  _AllWordsState createState() => _AllWordsState();
}

class _AllWordsState extends State<AllWords> {
  String foreignWord;
  String nativeWord;
  static int meter = 0;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    var _controller2 = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          if (GetData.ForeignList.length == 0)
            Center(
              child: Text(
                "Empty",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          else
            ListView.builder(
              itemExtent: 130,
              itemCount: GetData.ForeignList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    print(index);
                    var data = GetData.ForeignList[index];
                    var data1 = GetData.NativeList[index];
                    GetData.ForeignList.removeAt(index);
                    GetData.NativeList.removeAt(index);

                    debugPrint(GetData.ForeignList.toString());
                    setState(() {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        content: Text("${data.foreign} has been deleted"),
                        action: SnackBarAction(
                          label: "Undo",
                          onPressed: () {
                            setState(() {
                              GetData.ForeignList.add(
                                  WordForeign(data.foreign));
                              GetData.NativeList.add(WordNative(data1.native));
                            });
                          },
                        ),
                      ));
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                        child: ListTile(
                          title: Text(GetData.ForeignList[index].foreign != null
                              ? GetData.ForeignList[index].foreign
                              : 'Default Value'),
                          subtitle: Text(
                              GetData.NativeList[index].native != null
                                  ? GetData.NativeList[index].native
                                  : 'Default Value'),
                          /*title: Text(allWordsList[index].foreign),
                        subtitle: Text(allWordsList[index].native),*/
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.add),
                label: Text("New Word"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: 310,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          _controller.clear();
                                        },
                                      ),
                                      //border: InputBorder.none,
                                      hintText: "Foreign Language",
                                    ),
                                    validator: (inputValue) {
                                      if (inputValue.length > 0) {
                                        return null;
                                      } else {
                                        return "Can't be empty";
                                      }
                                    },
                                    onSaved: (saveValue) {
                                      foreignWord = saveValue;
                                      setState(() {
                                        GetData.ForeignList.add(
                                            WordForeign(foreignWord));
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: _controller2,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            _controller2.clear();
                                          },
                                        ),
                                        //border: InputBorder.none,
                                        hintText: "Native Language"),
                                    validator: (inputValue) {
                                      if (inputValue.length > 0) {
                                        return null;
                                      } else {
                                        return "Can't be empty";
                                      }
                                    },
                                    onSaved: (saveValue) {
                                      nativeWord = saveValue;
                                      setState(() {
                                        GetData.NativeList.add(
                                            WordNative(nativeWord));
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: 320,
                                    height: 50,
                                    child: RaisedButton(
                                      color: Color(0xFF1BC0C5),
                                      onPressed: () {
                                        meter++;
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          setState(() {
                                            _controller.clear();
                                            _controller2.clear();
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WordForeign {
  String foreign;

  WordForeign(this.foreign);
}

class WordNative {
  String native;

  WordNative(this.native);
}
