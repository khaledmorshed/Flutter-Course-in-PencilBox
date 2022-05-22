import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:vitual_visiting_card/models/contact_model.dart';

class DbHelper{
  //createTableContact = this is the table of database
  static final String _createTableContact = '''create table $tableContact(
  $tableContactColumnId integer primary key autoincrement,
  $tableContactColumnName text,
  $tableContactColumnEmail text,
  $tableContactColumnAddress text,
  $tableContactColumnMobile text,
  $tableContactColumnCompany text,
  $tableContactColumnDesignation text,
  $tableContactColumnWebsite text,
  $tableContactColumnFavorite integer,
  $tableContactColumnImage text)''';
  //open will call every time if we inser, delete, upadate something in database
  static Future<Database> open() async{
    //root diricetory indicating where the database will be installed in device
    final rootPath = await getDatabasesPath();
    //this is the actuall dircetory of database

    //and here contact_db will create inside of rootPath
    //contact_db = database name
    final dbPath = Path.join(rootPath, "contact_db");

    //it will return the database object
    //oncreate will be called when the users install the app at first in their device
    //but next time oncreate will not be called anymore
    //db = is obeject of database
    return openDatabase(dbPath, version: 2, onCreate: (db, version)async{
      //this table will create when users will install this app their device
      //here we can create many table as our wish
        await db.execute(_createTableContact);
        //(i)await db.execute(another table name);
        //next time if we create moere table then we have to increase version
      //number. so ther in updated version we will get total table = previous table + new created table
    //onUpgrade will be called when version will change.(name is database migration )
    }, onUpgrade: (db, oldVersion, newVersion){
      if(oldVersion == 1){
        db.execute("alter table $tableContact add column $tableContactColumnFavorite integer not null default 0");
      }
      //if we want to create more table not update just creating another table
      if(oldVersion == 2){
        //here code will be new creating table code. And also add this code (i)
        //db.execute("alter table $tableContact add create some thing like that just do google");
      }
    });
  }

  //insert data into table of database
  static Future<int> insertContactIntoTableInDb(ContactModel contactModel) async{
    //to insert at first we have to call open method to get object(db) of database
    final db = await open();
    //here insert method return an integer. data will insert in which row, that row id wll return
    return db.insert(tableContact, /*here reqired a map.so converting model into map*/contactModel.toMap());
  }

  //get all contactList from table of database
  static Future<List<ContactModel>> getAllContactsInDb()async{
    final db = await open();
    //table er prottek ta row theke map return kore akta list akare return kore(mapList)
    final List<Map<String, dynamic>> mapList = await db.query(tableContact/*table name*/);
    //akhon ei mapList a loop chalate hobe abong protteka mapke ak ak ta
    //ContactModel a convert korte hobe ContactModel.fromMap() etar maddhome.
    //  Abong prottekta ContactModel List akare return korbe
    return List.generate(mapList.length, (index)=>ContactModel.fromMap(mapList[index]));
  }

  //search a row inside of table with specific id
  //also we have to create a shadow method of getContactByIdInDb in provider
  static Future<ContactModel> getContactByIdInDb(int id)async{
    final db = await open();
    //specific row with id
    final List<Map<String, dynamic>> mapList = await db.query(tableContact, where: '$tableContactColumnId = ?', whereArgs: [id]);
    //here 1 model will return with firt item which will match with above query
    return ContactModel.fromMap(mapList.first);
  }

  //for deleting ContactModel with id
  //which row it delete, it return that's id
  static Future<int> deleteContactByIdInDb(int id)async{
    final db = await open();
    return db.delete(tableContact, where: '$tableContactColumnId = ?', whereArgs: [id]);
  }

  //update favorite value
  static Future<int> updateContactFavoriteByIdInDb(int id, int value) async{
    final db = await open();
    return db.update(tableContact, {tableContactColumnFavorite: value}, where: '$tableContactColumnId = ?' ,whereArgs: [id]);
  }
}