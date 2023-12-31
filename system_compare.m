im = double(imread("panda.jpg")) / 255;
cutoff = 0.01

while true
noisy_im = imnoise(im,'salt & pepper',0.02);
data = reshape(im, [], 3);

n_centers = 4;

options = fcmOptions(NumClusters=n_centers);

[centers1,U1] = chatgpt_fuzzy_c(data, n_centers, 2);

[centers2,U2] = chatgpt_fuzzy_c(data, n_centers, 2);

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