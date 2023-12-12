im = double(imread("panda.jpg")) / 255;
data = reshape(im, [], 3);

options = fcmOptions(NumClusters=3);

[centers1,U1] = fcm(data,options);

[centers2,U2] = chatgpt_fuzzy_c(data, 3, 2);

diff = immse(U1,U2);