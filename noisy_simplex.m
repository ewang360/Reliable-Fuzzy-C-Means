clear
for iteration = 1:10
im = double(imread("panda.jpg")) / 255;
cutoff = 0.01;

m=2;
data = reshape(im, [], 3);
n_centers = 7;

[centers_truth,U_truth] = chatgpt_fuzzy_c(data, n_centers, m);

noisy_im1 = imnoise(im,'speckle',0.1);
data1 = reshape(noisy_im1   , [], 3);

options = fcmOptions(NumClusters=n_centers);

[centers1,U1] = chatgpt_fuzzy_c(data1, n_centers, m);

%%
x = fuzzy_c_cost(data, centers1, U1) / width(U1)
avg_distance_end(iteration) = x;

end
mean_val = mean(avg_distance_end)
var_val = var(avg_distance_end)