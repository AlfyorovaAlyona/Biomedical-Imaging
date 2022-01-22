function N=generate_noise(covariance_measured_signal, power_SNR, N_sensors, N_datapoints)
variance = trace(covariance_measured_signal) / (power_SNR*N_sensors);
N=sqrt(variance).*randn(N_sensors,N_datapoints);



