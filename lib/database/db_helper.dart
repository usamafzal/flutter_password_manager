// Importing required libraries
import 'dart:io'; // For handling file system paths
import 'package:password_saving/model/credentials_model.dart'; // Importing the Credential model
import 'package:path_provider/path_provider.dart'; // To get app's document directory
import 'package:sqflite/sqflite.dart'; // For SQLite database management

// DatabaseHelper class to manage database operations
class DatabaseHelper {
  // Private constructor to enforce singleton pattern
  DatabaseHelper._();

  // Single instance of DatabaseHelper
  static DatabaseHelper getInstance = DatabaseHelper._();

  // Database properties
  static const _databseName = "password_manager.db"; // Database file name
  static const _databseVersion = 1; // Database version
  static const _tableName = "credentials"; // Table name

  // Column names
  static const columnID = "id"; // Column for primary key
  static const columnServiceName = "servicename"; // Column for service name
  static const columnUsername = "username"; // Column for username
  static const columnPassword = "password"; // Column for password

  // Function to join paths in a platform-independent way
  String join(List<String> path) {
    return path.join(Platform.pathSeparator);
  }

  Database? databse; // Holds the database instance

  // Getter for the database instance
  Future<Database> getDB() async {
    // If database is null, initialize it
    return databse = databse ?? await _initDatabase();
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the directory for application documents
    Directory pathDirectory = await getApplicationDocumentsDirectory();
    List<String> pathnames = [pathDirectory.toString(), _databseName];
    String path = join(pathnames); // Construct the full path

    // Open the database and create the table if it doesn't exist
    return await openDatabase(path,
        onCreate: _onCreate, version: _databseVersion);
  }

  // Function to create the credentials table
  void _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $_tableName (
$columnID INTEGER PRIMARY KEY AUTOINCREMENT, 
$columnServiceName TEXT NOT NULL, 
$columnUsername TEXT NOT NULL, 
$columnPassword TEXT NOT NULL
)
   ''');
  }

  // Add a new credential to the database
  Future<int> addData(Credential credential) async {
    Database db = await getDB(); // Get the database instance
    return await db.insert(
        _tableName, credential.toJson()); // Insert the credential
  }

  // Update an existing credential
  Future<int> updateDate(Credential credential) async {
    Database db = await getDB(); // Get the database instance
    return await db.update(
      _tableName,
      credential.toJson(), // Update with the new data
      where: "$columnID = ?", // Specify the row to update
      whereArgs: [credential.id],
    );
  }

  // Delete a credential by ID
  Future<int> deleteData(int id) async {
    Database db = await getDB(); // Get the database instance
    return await db.delete(
      _tableName,
      where: "$columnID = ?", // Specify the row to delete
      whereArgs: [id],
    );
  }

  // Retrieve all credentials from the database
  Future<List<Credential>> getAllData() async {
    Database db = await getDB(); // Get the database instance

    // Query all rows from the table
    List<Map<String, dynamic>> getData = await db.query(_tableName);

    // Map the results to a list of Credential objects or return an empty list
    return getData.isNotEmpty
        ? getData.map((e) => Credential.fromJson(e)).toList()
        : [];
  }
}
