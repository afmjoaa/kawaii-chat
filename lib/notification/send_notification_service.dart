import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class SendNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "kawaii-chat-88920",
      "private_key_id": "67a70b84e9faf755ea45e5129b31532798576b02",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCbzHJfpPWGvoxW\nZA/aCqc19jjQkJ6WnzcX9oB5ox6aJUI01B563+PufkfAU+pInGYXgfk1Eg/qiW33\n1O7FV+r3AvzyCjSrl7rvpfgLxNQq0qqroM5q5gesrQBAniK+4/PJwDANXvfQjI2z\nm9X13+HahfRDrT37oTfdrwE3T+AAddHhWLj1GH2oD7l70JkLY2C7MaBGO2QpGcRm\nUD2+q4SKV4qXlAMBfwr7xoC0rgdysaFKjyeL7wGlar01ZkqSJuQg/X7TDFl4SgT5\nZOliLx9lJCeU2QXH34U7WfhR8fN6hvbGAMH+x84+YMHafqWgYdIsMy9YB7cdQGB3\nbelwHFFJAgMBAAECggEAAN3Imiz7FIm8JS9oZpYilC7z5aPczeVT5dCkqfY09hIv\n01jOnXCWtSs6T8VVZpv246dup8FSYsOhuw5bEGdK5Qxz61d+VFeny742YQk7TV7N\nGHE5wlWPH+/5MfUTumKV1JoV/JrDBAO4pEicjmZ1TqB8WWEihmL31Gq/bNcr3ZA1\npW9/ND283FEuK/Nv6PnrNVKx9g/c+Ba6XmWBVUFSHOBBo1Z1s1ZFmFNZPkf5wCMc\nmVv4nMOTcw1G1K/0j4OizyEmJch68uD/G5USfqQPFR67P53X7Isi6kQDo7TQcU8M\n2/pfzfZq6c2b5ELLltDAz8wdfabfuDiXPPBsWIF2xQKBgQDW7OUFAVgFE0jnV6LZ\nfQVt4mgYTuYbE194++hOmJao8qfoxMaGmH0fTrt8FfQ1V5YH6pAi3Jb1doQYLKXH\ni8RTFJvqHQkU5ct0rIvR1xMmb+gbXR8qnxyHP+UF6TOLEiZYMR9ZwxWDvUcujGvd\nDNlrPd2wuEUel0olqU1ipvOxswKBgQC5ks754aD9NYNXawBi1z41NfuCA+Z5Y2mw\n4p3pzDU2xn3/b8k+iPBoGFwa23x7n3g1mDHRFsaWOqJJVkY1Urc86rEqr4zwhn2R\nzN9CfsdEsu6EZYXLbt2qNM7UTIboknr+mW7bTU2GDyI4LPnmp5BKcgxV8bFgDu0T\nfvxma/bbEwKBgDKEQ+BFTJcEzWHy60gLZrdJPAZapSNADnS1YQj4PJFBV84SUkdY\nmDA/pTmpP1k6WP1LWM2Y47KWRL4Z4G1ioKaWdX81i+jpikTGOab80nd6XifwX175\nPw9bKU2WXpMVlQWtphzHCcuJNa3vO3sdhgz64Zyj8zsZfEgV3yaM70KZAoGAF6NX\nsgTHmPlkDZKXrf908Ro7O0h75yJ+qAV1z/4vGRcXnZ4DqG+RD/FqahFjPewGR+1n\nCxc3nJNDcMwIjWpH5P6QKrvJ3CmFfTj3h2TWxS11rG+yJ0OsAK5RWkGVPbLK7/tj\nX5PtOBJdbYJtIrBddN4qLBhpW68LC9y1EebWvvkCgYA/VkXnJ+k/H3Ub4sAi42Yc\nPhvPHDW3WWf8eUn7esIN/J+4GZ5xawjW2QOwMNWDEStB1JIwlwWITNH7CdcCcbjG\nZ1R2ZEee7k0lHj+4kppI6O9uzycC+/TyFZ+d+N6iqN3i2LHWrF3EzwS1GZiFanrA\n3Z82uMEKBXsXFkX4wo6g2w==\n-----END PRIVATE KEY-----\n",
      "client_email": "from-app-test@kawaii-chat-88920.iam.gserviceaccount.com",
      "client_id": "117109926791005104874",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/from-app-test%40kawaii-chat-88920.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedClient(String deviceToken) async {
    final String serviceAccountAccessToken = await getAccessToken();

    String endPoint = 'https://fcm.googleapis.com/v1/projects/kawaii-chat-88920/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification':
          {
            'title': 'This is the title of the notification',
            'body': 'This is the body of the notification'
          },
        'data': {
          'anyKey': 'Anydata'
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endPoint),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serviceAccountAccessToken'
      },
      body: jsonEncode(message),
    );

    if(response.statusCode == 200){
      debugPrint("Notification send successfully");
    } else {
      debugPrint("Failed, Notification not send ${response.statusCode}");
    }
  }
}
