
const String tableContact = "tbl_contact";//actual table name(tbl_contact)
const String tableContactColumnId = "id";
const String tableContactColumnName = "Name";
const String tableContactColumnMobile = "mobile";
const String tableContactColumnEmail = "email";
const String tableContactColumnAddress = "address";
const String tableContactColumnCompany = "company";
const String tableContactColumnDesignation = "designation";
const String tableContactColumnWebsite = "website";
const String tableContactColumnImage = "image";
const String tableContactColumnFavorite = "favorite";

class ContactModel{
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;

  ContactModel(
      {required this.name,
      required this.mobile,
        this.id = 0,
      this.email = "",
      this.address = "",
      this.company = "",
      this.designation = "",
      this.website = "",
      this.image = "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
      this.favorite = false,
      });

  //to insert the contact information we can not insert the information directly. we have to insert
  //as key and value pair. for this reason we will crate a map with contact information
  //to insert, to delete, to upadte we call toMap function
  //for the time of inserting id will auto generate but when we will delete or update we have to pass
  //id into toMap method
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      tableContactColumnName: name,
      tableContactColumnMobile: mobile,
      tableContactColumnEmail: email,
      tableContactColumnAddress: address,
      tableContactColumnCompany: company,
      tableContactColumnWebsite: website,
      tableContactColumnDesignation: designation,
      tableContactColumnImage: image,
      //we can not insert into database true or false so need convertion as 1 or 0
      tableContactColumnFavorite: favorite ? 1 : 0,
    };
    //when table will create then we will get a value of id and so if we delete or update something
    //then we have to delete or update of that perticular id. so then we have to pass that id into
    //toMap method
    if(id > 0){
      map[tableContactColumnId]  = id;
    }
    return map;
  }

  //when we will query from database then that database will return a map from ecery row because we
  // insert the data as a map with toMap() method.
  //so the returned map from database we have to convert into model(ContactModel.fromMap).
  // with this model we can work with easily
  //factory constructor
  //for every map we have to create a object(ContactMode)
  //in every query we call this method as well as
  factory ContactModel.fromMap(Map<String, dynamic>
  map /*this map will get from database*/) => ContactModel(
    id: map[tableContactColumnId],
    name: map[tableContactColumnName],
    email: map[tableContactColumnEmail],
    mobile: map[tableContactColumnMobile],
    address: map[tableContactColumnAddress],
    company: map[tableContactColumnCompany],
    designation: map[tableContactColumnDesignation],
    website: map[tableContactColumnWebsite],
    image: map[tableContactColumnImage],
    favorite: map[tableContactColumnFavorite] == 1 ? true : false,
  );

  //when we will print object then we can see the all information in console
  @override
  String toString() {
    return 'ContactModel{name: $name, mobile: $mobile, email: $email, address: $address, company: $company, designation: $designation, website: $website, image: $image, favorite: $favorite}';
  }
}