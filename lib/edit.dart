import 'package:flutter/material.dart';
import 'package:note_app/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'note_model.dart';


class Edit extends StatefulWidget {
  const Edit({Key? key, this.note,this.index}) : super(key: key);
  final Note? note;
  final int? index;


  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

  late TextEditingController textEditingController;

  late TextEditingController titleEditingController = TextEditingController();
  late TextEditingController timeEditingController= TextEditingController(text: DateFormat.HOUR24.toString(),) ;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.note?.data ?? "");
    titleEditingController =
        TextEditingController(text: widget.note?.title ?? "");
    timeEditingController =
        TextEditingController(text: widget.note?.datetime ?? now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(titleEditingController.text!="") {
                          if (widget.note == null) {
                            Provider.of<NoteNotifier>(context, listen: false)
                                .addnote(Note(

                              data: textEditingController.text,
                              title: titleEditingController.text,
                              datetime: now,
                            ));
                          } else {
                           Provider.of<NoteNotifier>(context, listen: false)
                                .editnote(
                                Note(
                                  id: widget.note!.id,
                                  data: textEditingController.text,
                                  title: titleEditingController.text,
                                  datetime: now,
                                ),);
                          }
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  maxLines: null,
                  controller: titleEditingController,

                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 40)),
                ),
              ),

              Text(timeEditingController.text,style: const TextStyle(color: Colors.grey),),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  maxLines: null,
                  controller: textEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
            ],
          ),
        ));
  }


  String get now=>DateFormat.MMMd().format(DateTime.now());


}
