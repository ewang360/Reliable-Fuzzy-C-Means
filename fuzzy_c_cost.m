function K = fuzzy_c_cost(data, centers, U)

c = height(centers);
distance = zeros(size(data, 1), c);
for j = 1:c
    distance(:, j) = (sum((data - centers(j, :)).^2, 2));
end

K = sum(sum(distance .* U'));