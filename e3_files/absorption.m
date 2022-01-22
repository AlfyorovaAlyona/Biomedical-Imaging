function [output]=absorption(input, alpha, x)

    output = input * exp(-alpha * x);

end