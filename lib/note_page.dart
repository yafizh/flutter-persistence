import 'package:flutter/material.dart';
import 'package:persistence/models/Note.dart';
import 'package:persistence/services/database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool loading = true;
  List<Note> notes = [];

  Future<void> getNotes() async {
    setState(() {
      loading = true;
    });

    var tempNotes = await Database().notes();

    setState(() {
      notes = tempNotes;
      loading = false;
    });
  }

  Widget emptyNotes() {
    return Center(child: Text(loading ? 'Loading...' : 'Note not available'));
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Sqlite'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(18),
                    child: NoteForm(getNotes: getNotes),
                  );
                },
              );
            },
            child: const Icon(Icons.add)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: notes.isEmpty
              ? emptyNotes()
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lightBlue,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notes[index].title,
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    notes[index].desc,
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ],
                              )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(18),
                                              child: NoteForm(
                                                getNotes: getNotes,
                                                note: notes[index],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        await Database()
                                            .deleteNote(notes[index].id!);
                                        getNotes();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ],
                          )),
                    );
                  },
                ),
        ));
  }
}

class NoteForm extends StatefulWidget {
  final Note? note;
  final Function getNotes;

  const NoteForm({super.key, required this.getNotes, this.note});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final database = Database();

  String _title = '';
  String _desc = '';

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      setState(() {
        _title = widget.note!.title;
        _desc = widget.note!.desc;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Title"),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _title,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2))),
          onChanged: (val) {
            setState(() {
              _title = val;
            });
          },
        ),
        const SizedBox(height: 16),
        const Text("Description"),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _desc,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2))),
          onChanged: (val) {
            setState(() {
              _desc = val;
            });
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () async {
              (widget.note == null)
                  ? await database.insertNote(Note(title: _title, desc: _desc))
                  : await database.updateNote(
                      widget.note!.id!, Note(title: _title, desc: _desc));

              await widget.getNotes();
              Navigator.pop(context);
            },
            child: Text((widget.note == null) ? 'Add Note' : 'Update Note'))
      ],
    ));
  }
}
