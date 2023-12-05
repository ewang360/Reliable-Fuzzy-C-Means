function [centers, U] = our_fuzzy_c(X, c, m) %X is row vector based
    %assign random coefficients from 0 to 1 to all points
    U = rand(height(X), c);
    U = U ./ sum(U,2);
    centers = zeros(c,width(X));
    %loop
    epsilon = .01;
    avg_change = epsilon;
    cost = inf;
    while avg_change >= epsilon
        old_U = U;
        old_cost = cost;
    %   compute centroids
        for i = 1:c
            % centers(i,:) = sum((U(:,i).^m) .* X,1) / (sum(U(:,i).^m));
            centers(i,:) = zeros(1,width(X));
            num = zeros(1,width(X));
            den = 0;
            for j = 1:height(U)
                num = num + X(j,:) * U(j,i)^m;
                den = den + U(j,i)^m;
            end
            centers(i,:) = num / den;
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
        cost = sum(sum(U .* distances))
        avg_change = old_cost - cost;
        %avg_change = 1;
    end
end