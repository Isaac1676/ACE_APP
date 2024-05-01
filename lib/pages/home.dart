import 'package:ace_app/components/list_tile.dart';
import 'package:ace_app/components/text_field.dart';
import 'package:ace_app/database/ace_database.dart';
import 'package:ace_app/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  bool isConfirmed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ACEDatabase>().fetchUsers();
    });
  }

  void performSearch(String searchTerm) {
    if (searchTerm.isEmpty) {
      context.read<ACEDatabase>().fetchUsers();
    } else {
      context.read<ACEDatabase>().searchByName(searchTerm);
    }
  }

  @override
  Widget build(BuildContext context) {
    //database options
    final aceDatabase = context.watch<ACEDatabase>();
    final currentUsers = aceDatabase.aceList;

    //getting heigth and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.church_sharp, color: Colors.white,),
        actions: [
          IconButton(
              onPressed: () => context.read<ACEDatabase>().refreshConfirm(),
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ))
        ],
        title: Text(
          "A C C U E I L",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: screenWidth * 0.055,
            color: Colors.white,
          ),
        ),
        toolbarHeight: screenHeight * 0.08,
        backgroundColor: Colors.grey[850],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPage()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.person_add_alt_rounded),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),

          //Textfield
          Textfield(controller: searchController, onChanged: performSearch),

          //List of User
          Expanded(
              child: ListView.builder(
                  itemCount: currentUsers.length,
                  itemBuilder: (context, index) {
                    final user = currentUsers[index];
                    final classe = user.classe;
                    final promotion = user.promotion;
                    SizedBox(
                      height: screenHeight * 0.01,
                    );
                    return MyListile(
                        title: user.name,
                        subtitle: "$promotion | $classe",
                        isConfirmed: user.isConfirm,
                        onPressed: () {
                          aceDatabase.updateConfirm(index, !user.isConfirm);
                        });
                  }))
        ],
      )),
    );
  }
}
