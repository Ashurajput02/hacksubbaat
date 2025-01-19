import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../components/profileButton.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
          toolbarHeight: screenHeight * 0.2,
          centerTitle: true,
          title: Text('Profile',
              style: TextStyle(color: Theme.of(context).colorScheme.surface)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.1),
            child: Column(
              children: [
                CircleAvatar(
                  radius: screenHeight * 0.05,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: CircleAvatar(
                    radius: screenHeight * 0.048,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Text(
                        Hive.box('appBox')
                            .get('userData')['name'][0],
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(Hive.box('appBox').get('userData')['name'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface)),
                SizedBox(height: screenHeight * 0.02),
                Text(Hive.box('appBox').get('userData')['email'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface)),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.1),
            child: Text('Settings',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Column(
              children: [
                Profilebutton(
                    onPressed: () {
                    
                    },
                    title: 'About Us',
                    iconLeading: Icons.info,
                    iconTrailing: Icons.arrow_forward_ios),
                Profilebutton(
                    onPressed: () {
                    
                    },
                    title: 'Terms And Conditions',
                    iconLeading: Icons.star,
                    iconTrailing: Icons.arrow_forward_ios),
                Profilebutton(
                    onPressed: () {
                    
                    },
                    title: 'Privacy Policy',
                    iconLeading: Icons.privacy_tip,
                    iconTrailing: Icons.arrow_forward_ios),
                Profilebutton(
                  onPressed: () {
                  
                  },
                  title: 'Rate Us',
                  iconLeading: Icons.star,
                  iconTrailing: Icons.arrow_forward_ios,
                ),
                Profilebutton(
                  onPressed: () {
                  
                  },
                  title: 'Share',
                  iconLeading: Icons.share,
                  iconTrailing: Icons.arrow_forward_ios,
                ),
                Profilebutton(
                  onPressed: () {
                    Hive.box('appBox').delete('userEmail');
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  title: 'Logout',
                  iconLeading: Icons.logout,
                  iconTrailing: Icons.arrow_forward_ios,
                  iconColor: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
