clear;
im = double(imread("panda.jpg")) / 255;
for iteration = 1:10
cutoff = 0.01;

m=2;
data = reshape(im, [], 3);
n_centers = 7;

[centers_truth,U_truth] = chatgpt_fuzzy_c(data, n_centers, m);

while true
noisy_im1 = imnoise(im,'speckle',0.1);
noisy_im2 = imnoise(im,'speckle',0.1);
data1 = reshape(noisy_im1, [], 3);
data2 = reshape(noisy_im2, [], 3);

options = fcmOptions(NumClusters=n_centers);

[centers1,U1] = chatgpt_fuzzy_c(data1, n_centers, m);

[centers2,U2] = chatgpt_fuzzy_c(data2, n_centers, m);

%diff = immse(U1,U2);

%match them to each other
%%

mapping = zeros(n_centers,1);
for i = 1:n_centers
    best_distance = [100000, 0];
    for j = 1:n_centers
        if ismember(j,mapping)
            continue
        end
        if norm(centers1(i,:) - centers2(j,:)) < best_distance(1)
           best_distance = [norm(centers1(i,:) - centers2(j,:)), j];
        end
    end
    mapping(i) = best_distance(2);
end

%%
distance = 0;
for i = 1:n_centers
    distance = distance + norm(centers1(i,:) - centers2(mapping(i),:));
end
avg_distance = distance / n_centers

if avg_distance < cutoff
    break
end
end

x = fuzzy_c_cost(data, centers1, U1) / width(U1)
avg_distance_end_dup(iteration) = x;

end
%%
mean_val_dup = mean(avg_distance_end_dup)
var_val_dup = var(avg_distance_end_dup)