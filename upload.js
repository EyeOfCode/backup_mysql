const admin = require("firebase-admin");
const path = require("path");
require("dotenv").config(); // Load environment variables from .env file

// Check for file path passed from the bash script
if (process.argv.length < 3) {
  console.error("Usage: node upload_to_firebase.js <backup_file_path>");
  process.exit(1);
}

const backupFilePath = process.argv[2];

// Initialize Firebase App
admin.initializeApp({
  credential: admin.credential.applicationDefault(), // If using environment variable for credentials
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET, // Access the storage bucket from .env
});

// Define the bucket
const bucket = admin.storage().bucket();
const destination = `${process.env.FIREBASE_FOLDER}/backup/${path.basename(
  backupFilePath
)}`; // Firebase Storage path

// Upload file to Firebase Storage
bucket
  .upload(backupFilePath, {
    destination: destination,
    gzip: true, // Compress the file during upload
  })
  .then(() => {
    console.log(
      `Backup file ${backupFilePath} uploaded to Firebase Storage successfully.`
    );
  })
  .catch((error) => {
    console.error("Error uploading file to Firebase Storage:", error);
  });
