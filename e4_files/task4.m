%% Task 4a

p_2D = p_to_2D(p);

figure(1)
imagesc(p_2D)
colormap("gray")
colorbar
title("noisy projections");
%% Task 4b

m = [0 1 10 100 1000];

figure(2);
for i=1:5
    I = eye(size(A'*A));
    mu_est = inv(A'*A + m(i).*I)*A'*p;
    mu_est_2D = mu_vector_to_2D(mu_est);
    subplot(3,2,i)
    title1 = sprintf("Regularization value m = %d", m(i));
    imagesc(mu_est_2D)
    colormap("gray")
    colorbar
    title(title1);
end
