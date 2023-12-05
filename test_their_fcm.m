clc;clear;
N = 4;
%rows for pixels columns for channels
im = double(imread("panda.jpg")) / 255;
fcmdata = reshape(im, [], 3);
options = fcmOptions(NumClusters=N);
%[centers,U] = our_fuzzy_c(fcmdata,N,1.1);
[centers,U] = fcm(fcmdata,options);
data_out = U(1,:)' * centers(1,:);
for i = 2:height(U)
    data_out = data_out + U(i,:)' * centers(i,:);
end
%% asdf
scatter3(fcmdata(:,1), fcmdata(:,2), fcmdata(:,3), 0.01, 'b')
hold on;
scatter3(centers(:,1), centers(:,2), centers(:,3), 'r')

%% asdf
im_recovered = reshape(data_out, 408, 612, 3);
imshow(im_recovered)