function [T]=transmission(Z1, Z2)
    T = 2*Z1*Z2 / (Z1 + Z2);
end