# kawaii_chat
A new Flutter project for kawaii chat.

provider, flutter_bloc and flutter_riverpod, is user for state management.   

As for notification we need FCM token for device, which need to be handled using the firestore, 
that require a bit more time, so i have send notification to my own device only on each chat message send.

Normally we use cloud function to monitor the firestore database, on data update cloud functions 
send notification to specific user, but as cloud function a paid service, 
i have implemented it in a alternative way.

I am using the Firebase Cloud Messaging API (V1) to send a notification. On each chat message send i am 
triggering a notification send to cloud messaging.

While firebase_messaging_service is listening up-comming push notifications.
This is only implemented for android.

Please read lib/notification for further details.

## APK link: https://drive.google.com/file/d/1Gix8yBDIZ-YZvnCYTL69kYwNMBfbSkca/view?usp=sharing

## App web url: https://kawaii-chat-88920.web.app/
