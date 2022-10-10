
import 'package:flutter/material.dart';
import '/widgets/navigationdrawerwidget.dart';
import '/pages/project_page.dart';
import '/pages/project_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}
class _ProjectListState extends State<ProjectList> {

  addEncabezadoPubli(String texto, double fontSize) {
    return (Row(children: [
      const SizedBox(
        width: 30,
      ),
      Text(
        texto,
        //textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: fontSize, decorationStyle: TextDecorationStyle.dotted),
      ),
      const SizedBox(
        width: 40,
      ),

    ]));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Project List"),
        ),
        body: Center(
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: const Icon(Icons.article),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProjectCreate(),
                        ));
                      },
                      label: const Text("Create Project"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
    child: Column(
        children: [
          addEncabezadoPubli("Ongoing Projects", 24),
          Expanded(
                child: StreamBuilder<List<Project>>(
                  stream: readProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text ('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final projects = snapshot.data!;

                      return ListView(
                        children: projects.map(buildProject).toList(),
                         );
                    } else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                ),)]),
            height: 300,
                //color: Colors.deepOrangeAccent,
                ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100, width: 5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    addEncabezadoPubli("Completed Projects", 24),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: <Widget>[
                          ListTile(
                            title: const Text("Completed Project 1"),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProjectPage(),));
                            },
                          ),
                          ListTile(
                            title: const Text("Completed Project 2"),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProjectPage(),));
                            },
                          ),
                          ListTile(
                            title: const Text("Completed Project 3"),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProjectPage(),));
                            },
                          ),
                          ListTile(
                            title: const Text("Completed Project 4"),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProjectPage(),));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                height: 300,
                //color: Colors.deepOrangeAccent,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )));
  }
  Widget buildProject(Project project) => ListTile(
      title: Text(project.title),
      trailing: IconButton(
        icon: const Icon(
          Icons.library_books_outlined,
          color: Colors.blueGrey,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProjectPage(),));
        },
      )
  );
}


Stream<List<Project>> readProjects() => FirebaseFirestore.instance
    .collection('projects')
    .snapshots()
    .map((snapshot) =>
    snapshot.docs.map((doc) => Project.fromJson(doc.data())).toList());