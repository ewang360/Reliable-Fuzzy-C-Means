function [centers, U] = chatgpt_fuzzy_c(data, c, m)
% FCM parameters
% c = 3; % Number of clusters
% m = 2; % Fuzziness parameter
maxIter = 20; % Maximum number of iterations
tolerance = 1e-5; % Minimum improvement in the objective function

% Initialize membership matrix randomly
U = rand(size(data, 1), c);
U = U ./ sum(U, 2); % Normalize membership values

for iter = 1:maxIter
    % Compute cluster centers
    centers = (U.^m)' * data ./ sum(U.^m, 1)';
    
    % Update membership values using custom distance computation
    distance = zeros(size(data, 1), c);
    for j = 1:c
        distance(:, j) = sqrt(sum((data - centers(j, :)).^2, 2));
    end
    U_new = 1 ./ (distance.^(2 / (m - 1))); % Calculate new membership values
    
    % Normalize the membership values
    U_new = U_new ./ sum(U_new, 2);
    
    % Calculate the objective function (J) to check for convergence
    J = sum(sum((U_new.^m) .* distance))
    
    % Check for convergence
    if abs(J - sum(sum((U.^m) .* distance))) < tolerance
        break;
    end
    
    U = U_new; % Update the membership matrix
end
end