import 'package:flutter/material.dart';
import 'package:ace_app/components/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<User> _users = [
    User('Elliana Palacios', '0585456593', 'SRIT 2B', false),
    User('Kayley Dwyer', '0585456593', 'TWIN 2', false),
    User('Kathleen Mcdonough', '0585456593', 'SIGL2', false),
    User('Kathleen Dyer', '0585456593', 'RTEL 2', false),
    User('Mikayla Marquez', '0145857485', 'SRIT 2A', false),
    User('Kiersten Lange', '0225845632', 'RTEL 3', false),
    User('Carys Metz', '0125458745', 'TWIN 1', false),
    User('Ignacio Schmidt', '0485669545', 'SRIT 1A', false),
    User('Clyde Lucas', '0145884565', 'SIGL 3', false),
    User('Mikayla Marquez', '0125456593', 'SRIT 1B', false)
  ];

  late List<User> foundedUsers;

  @override
  void initState() {
    super.initState();
    foundedUsers = List.from(_users);
  }

  void onSearch(String search) {
    setState(() {
      foundedUsers = _users
          .where((user) => user.name.toLowerCase().contains(search))
          .toList();
    });
  }

  void resetConfirmation() {
    setState(() {
      for (var user in _users) {
        user.isConfirmed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "ACE PRESENCE",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.grey[850],
        actions: [
          IconButton(onPressed: resetConfirmation, icon: const Icon(Icons.refresh, color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 68,
              child: TextField(
                onChanged: onSearch,
                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintStyle:
                      TextStyle(fontSize: 15, color: Colors.grey.shade500),
                  hintText: "Search Users",
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: foundedUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: foundedUsers.length,
                      itemBuilder: (context, index) {
                        return userComponent(user: foundedUsers[index]);
                      },
                    )
                  : const Center(
                      child: Text(
                        "No users found",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userComponent({required User user}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white,),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${user.numPhone}[${user.classe}]",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (!user.isConfirmed) {
                  user.isConfirmed = true;
                }
              });
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: user.isConfirmed ? Colors.blue[700] : const Color(0x00ffffff),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: user.isConfirmed
                      ? Colors.transparent
                      : Colors.grey.shade700,
                ),
              ),
              child: Center(
                child: Text(
                  user.isConfirmed ? 'Confirmed' : 'Confirm',
                  style: TextStyle(
                    color: user.isConfirmed ? Colors.white : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
