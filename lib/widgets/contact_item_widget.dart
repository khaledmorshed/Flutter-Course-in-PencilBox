import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitual_visiting_card/models/contact_model.dart';
import 'package:vitual_visiting_card/providers/contact_provider.dart';
import 'package:vitual_visiting_card/screens/contact_details_screen.dart';

class ContactItemWidget extends StatefulWidget {
  final  ContactModel contactModel;
  ContactItemWidget(this.contactModel);

  @override
  State<ContactItemWidget> createState() => _ContactItemWidgetState();
}

class _ContactItemWidgetState extends State<ContactItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red,),
      confirmDismiss: ShowConfirmDialog,
      //this onDismissed method will be called when confirmDismiss return true
      onDismissed: (_){
      //this widget is the object of statfullwidget
        Provider.of<ContactProvider>(context, listen:false).deleteContactByIdInProvider(widget.contactModel.id);
      },
      child: Card(
          elevation: 6,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          title: Text(widget.contactModel.name),
          subtitle: Text(widget.contactModel.mobile),
          trailing: Consumer<ContactProvider>(
            builder:(context, provider, _)=> IconButton(
              onPressed: (){
                final value = widget.contactModel.favorite ? 0 : 1;
                //(1) == go to contact_provider.dart
                // provider.updateContactFavoriteByIdInProvider(widget.contactModel.id, value).then((value){
                //   setState((){
                //     //toggle
                //     widget.contactModel.favorite = !widget.contactModel.favorite;
                //   });
                // });

                //(2) == go to contact_provider.dart
                provider.updateContactFavoriteByIdInProvider(widget.contactModel.id, value);
              },
              icon: widget.contactModel.favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, ContactDetailsScreen.path, arguments: [widget.contactModel.id, widget.contactModel.name]);
          },
        ),
      ),
    );
  }

  Future<bool?>ShowConfirmDialog(DismissDirection direction){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
      title: Text("Delete contact"),
      content: Text("Are you sure to delete this contact"),
      actions: [
        TextButton(onPressed: (){
          // //this false will return from Future<bool?>
          Navigator.pop(context, false);
        }, child: Text("No")),
        TextButton(onPressed: (){
          //this true will return from Future<bool?>
          Navigator.pop(context, true);
        }, child: Text("Yes")),
      ],
    )
    );
  }
}
