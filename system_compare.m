data = rand(100,2);

options = fcmOptions(NumClusters=2);

[centers1,U1] = fcm(data,options);

[centers2,U2] = fcm(data,options);

diff = immse(U1,U2);