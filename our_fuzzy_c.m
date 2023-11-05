function [centers, U] = our_fuzzy_c(X, c, m) %X is row vector based
    %assign random coefficients from 0 to 1 to all points
    U = rand(height(X), c)
    centers = zeros(c,width(X))
    %loop
    epsilon = .01;
    avg_change = epsilon;
    cost = inf;
    while avg_change >= epsilon
        old_U = U;
        old_cost = cost;
    %   compute centroids
        for i = 1:c
            sum(U(:,i) .* X,i)
            centers(i,:) = sum(U(:,i) .* X,1) / (sum(U(:,i)));
        end
    %   compute new coefficients
        distances = zeros(height(X), c);
        U = zeros(height(X), c);
        for i = 1:c
            distances(:,i) = sum((X - centers(i,:)).^2, 2);
        end
        for i = 1:c
            U = U + (distances(:,i) ./ distances) .^ (1/(m-1));
        end
        U = 1 ./ U;
    %   if coefficients dont change more than epsilon on average, end
        cost = sum(sum(U .* distances)) / (sum(size(X)))
        avg_change = old_cost - cost
    end
end