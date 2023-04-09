// // import 'package:encrypt/encrypt.dart' as encrypt;
// // import 'package:encrypt/encrypt.dart';

// // class Mydecryption {
// //   var key = Key.fromBase64(
// //       'cNGPgFd4iBaEUSkZNktlZQ=='); // obviously, insert your own value!
// //   var iv = IV.fromBase64('cNGPgFd4iBaEUSkZNktlZQ==');
// //   // static final key = encrypt.Key.fromLength(32);
// //   // static final iv = encrypt.IV.fromLength(16);
// //   static final encrypter = encrypt.Encrypter(encrypt.AES(key));

// //   static decryptAES(text) {
// //     final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(text),iv:iv);
// //     return decrypted;
// //   }
// // }

// import 'package:encryptor/encryptor.dart';
// import 'package:flutter/foundation.dart';

// void main() {
//   var plainText = 'SOME DATA TO ENCRYPT';
//   var key = 'Key to encrypt and decrpyt the plain text';

//   var encrypted = Encryptor.encrypt(key, plainText);
//   var decrypted = Encryptor.decrypt(key, encrypted);

//   debugPrint(encrypted);
//   debugPrint(decrypted);
// }