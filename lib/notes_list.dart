

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/edit.dart';
import 'package:note_app/note_provider.dart';
import 'package:provider/provider.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {


  bool isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    final NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: true);

    return Expanded(
        child: noteNotifier.notestoshow.length > 0
            ? GridView.custom(
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: const [
                    QuiltedGridTile(1, 2),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(2, 1),
                    QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, id) {
                  //  final GlobalKey key = GlobalKey(debugLabel: index.toString());
                  return GestureDetector(
                    //key: key,
                    onTap: () {
                      // await NotesDatabase.instance.update(notee);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Edit(
                                    note: noteNotifier.notestoshow[id],
                                    index: id,
                                  )));
                    },



                    child: Padding(
                      //   key: key,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                     child: Dismissible(

                        //background: Container(color: Colors.black,),

                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: UniqueKey(),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            noteNotifier.notestoshow.removeAt(id);
                            noteNotifier.notes.removeAt(id);
                          });

                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(' dismissed')));
                        },
                        // Show a red background as the item is swiped away.

                        child:Container(
                          decoration: BoxDecoration(
                              color:
                              Colors.primaries[id % 18].withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  noteNotifier.notestoshow[id].title,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    noteNotifier.notestoshow[id].datetime,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.grey),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                    ),
                  );
                }, childCount: noteNotifier.notestoshow.length),
              )
            : const Center(
                child: Text("NO NOTES HERE",style: TextStyle(color: Colors.white,fontSize: 20),),
              ));
  }
}

/*
 */
