import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehat/models/purchase_model.dart';
import '../models/product_model.dart';

class FirestoreDbHelper {
  //all collection. collection means table in database
  static const String _collectionAdmin = 'Admins';
  static const String _collectionProduct = 'Products';
  static const String _collectionPurchases = 'Purchases';
  static const String _collectionCategory = 'Categories';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCategories(){
    //stream return stream QuerySnapshot. means return frame of data and continuously
    return _db.collection(_collectionCategory).snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() => _db.collection(_collectionProduct).snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getPurchaseByProductId(String id) => _db.collection(_collectionPurchases).where('productId', isEqualTo: id).snapshots();
  //jehetu akta document er upore snapshot bosano hocce tai DocumentSnapshot hobe QuerySnapshot er
  //poriborte
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductsByProductId(String id) => _db.collection(_collectionProduct).doc(id).snapshots();
  static Future<void> addNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    //here we will run a batch operation.Means two collections will assign at a time.if one fail
    //then another will fail.
    //wb = object of WriteBatch
    final wb = _db.batch();
    //here we will create an another empty new document of _collecitonProduct which has id, name etc.
    final productDocRef = _db.collection(_collectionProduct).doc();
    //actually here an unique id is created for two collection so that we can add new product(ProductModel)
    //and purchase product(PurchaseModel) at a time in database
    productModel.productId = productDocRef.id;
    purchaseModel.productId = productDocRef.id;
    //a empty new document of _collectionPurchases
    final purchaseDocRef = _db.collection(_collectionPurchases).doc();
    purchaseModel.purchaseId = purchaseDocRef.id;
    
    //now time to set into database
    wb.set(productDocRef/*document*/, productModel.toMap()/*data*/);
    wb.set(purchaseDocRef, purchaseModel.toMap());
    //after set we have to return commit and commit return Future<void>
    return wb.commit();
  }

  static Future<bool> checkAdmin(String email) async {
    //get return a QuerySnapshot
    final snapshot = await _db.collection(_collectionAdmin).where("email", isEqualTo: email).get();
    return snapshot.docs.isNotEmpty;
  }
}