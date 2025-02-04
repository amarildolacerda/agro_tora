 import 'package:flutter/material.dart';

import '../api/config_service.dart';
import '../api/root_service.dart';


 class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

   @override
   Widget build(BuildContext context) {
     return Drawer(
       child: ListView(
         padding: EdgeInsets.zero,
         children: <Widget>[
           DrawerHeader(
             decoration: BoxDecoration(color: Colors.blue),
             child: Text('Menu'),
           ),
           ListTile(
             title: Text('Áreas'),
             onTap: () {
              roots.goAreaList(context);
             },
           ),
           ListTile(
             title: Text('Ordens de Serviço'),
             onTap: () {
               Navigator.pop(context);
             //  Navigator.of(context).pushReplacement(
             //    MaterialPageRoute(builder: (_) => OSListScreen()),
             //  );
             },
           ),
        
        ListTile(
             title: Text('Sair'),
             onTap: () {
               Navigator.pop(context);
               Config().logado = false;
             //  Navigator.of(context).pushReplacement(
             //    MaterialPageRoute(builder: (_) => OSListScreen()),
             //  );
             },
           ),
         
        
        
         ],
       ),
     );
   }
 }
