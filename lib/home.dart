import 'package:flutter/material.dart';
import 'package:note_app/note_provider.dart';
import 'package:provider/provider.dart';


import 'edit.dart';
import 'note_provider.dart';
import 'notes_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showappbar = false;
   late TextEditingController query;
   @override
  void initState() {
     query = TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NoteNotifier()..init(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            return Scaffold(
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const Edit()));
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.cyan,
                ),
              ),
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: !showappbar
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Notes",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showappbar = true;

                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ))
                            ],
                          )
                        :
                    Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: query,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.cyan),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  suffixIcon: IconButton(
                                    onPressed: () {

                                      Provider.of<NoteNotifier>(context, listen: false).search(query.text);
                                    },
                                    icon: const Icon(Icons.search),
                                  ),
                                  hintText: 'What are you looking for',
                                  fillColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.cyan)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.cyan)),
                                  hintStyle:
                                      const TextStyle(color: Colors.white)),
                              onEditingComplete: () {
                                setState(() {
                                  showappbar = false;
                                });
                              },
                            ),
                          ),

                  ),
                  const NotesList()
                ],
              ),
            );
          }),
        ));
  }
}

