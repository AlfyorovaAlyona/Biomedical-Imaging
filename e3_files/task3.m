%% Part 1: how many percentages is the pressure amplitude decreased

freqs = [200000 2000000 20000000 200000000]; %Hz
freq_dep_attenuation = 5.8e-8;
depth = 1; %cm
p_i = 10; %random initial pressure

attenuations = freq_dep_attenuation.*freqs;

pressure = p_i * exp(-depth.*attenuations);
pressure_decrease_percent = (1-pressure/p_i)*100;

%% Part 2

% coefficients and recorded data for water experiment
a = 0.002;
b = 2;
f = 20; %MHz
V = 0.77;
noiseV = 0.02; %20mV
alpha_water = a*f^b;

%recorded V is linearly dependent on the pressure with V0 is to be initial voltage
%V = V0*exp(-2*alpha*depth);

V0 = V / exp(-2*alpha_water);

thickness = 0;
delta = 0.0001;

while(1==1)
    thickness = thickness + delta;
    V_soft = V0*exp(-2*alpha_water*thickness);
    
    if (V_soft < noiseV)
        break;
    end
end
