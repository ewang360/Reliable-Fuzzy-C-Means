function [idx, centroids] = myKMeans(data, K, maxIter)
    % data: Input data (N x D matrix, where N is the number of data points and D is the number of features)
    % K: Number of clusters
    % maxIter: Maximum number of iterations

    % Randomly initialize centroids
    centroids = data(randperm(size(data, 1), K), :);

    for iter = 1:maxIter
        % Assign each data point to the nearest centroid
        %distances = pdist2(data, centroids);

        distances = zeros(size(data, 1), K);
            for j = 1:K
        distances(:, j) = (sum((data - centroids(j, :)).^2, 2));
        [~, idx] = min(distances, [], 2);

        % Update centroids
        for k = 1:K
            centroids(k, :) = mean(data(idx == k, :));
        end
    end
end