clc;clear;close all;
N = 4;
%rows for pixels columns for channels
im = double(imread("panda.jpg")) / 255;
fcmdata = reshape(im, [], 3);
options = fcmOptions(NumClusters=N);
[centers,U] = chatgpt_fuzzy_c(fcmdata,N,2);
U = U';
data_out = U(1,:)' * centers(1,:);
for i = 2:N
    data_out = data_out + U(i,:)' * centers(i,:);
end
%% 
scatter3(fcmdata(:,1), fcmdata(:,2), fcmdata(:,3), 0.05, 'b')
hold on;
scatter3(centers(:,1), centers(:,2), centers(:,3), 'r')
%% 
figure(2)
im_recovered = reshape(data_out, height(im), width(im), 3);
imshow(im_recovered)