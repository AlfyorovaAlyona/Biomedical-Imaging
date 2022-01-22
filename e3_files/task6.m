%% Parse .txt file
import_data = importdata("Transducers_voltages2.txt");

data = import_data(6:end,:);

%import time data
time_data= data(:,1);
time = cellfun(@str2num, time_data);

unfiltered_envelopes = {};

%import transducers' data
data1  = data(:,2);
tr_1 = cellfun(@str2num, data1);
data2  = data(:,3);
tr_2 = cellfun(@str2num, data2);
unfiltered_envelopes(2) = {envelope(tr_2)};
unfiltered_envelopes(1) = {envelope(tr_1)};
data3  = data(:,4);
tr_3 = cellfun(@str2num, data3);
unfiltered_envelopes(3) = {envelope(tr_3)};
data4  = data(:,5);
tr_4 = cellfun(@str2num, data4);
unfiltered_envelopes(4) = {envelope(tr_4)};
data5  = data(:,6);
tr_5 = cellfun(@str2num, data5);
unfiltered_envelopes(5) = {envelope(tr_5)};
data6  = data(:,7);
tr_6 = cellfun(@str2num, data6);
unfiltered_envelopes(6) = {envelope(tr_6)};
data7  = data(:,8);
tr_7 = cellfun(@str2num, data7);
unfiltered_envelopes(7) = {envelope(tr_7)};
data8  = data(:,9);
tr_8 = cellfun(@str2num, data8);
unfiltered_envelopes(8) = {envelope(tr_8)};

% points for creating the line in order to remove offset
point1 = [1.70e-05 -0.017];
point2 = [9.80e-05 -0.008];

%% Plot envelope for the first transducer

subplot(2,1,1);hold on;
hold on
title("Transducer 1: unfiltered");
plot(time, tr_1)
plot(time, unfiltered_envelopes{1,1})
grid on
subplot(2,1,2);hold on;
title("Transducer 1: filtered");
plot(time, transducer_1_filtered)
plot(time, transducer_envelopes{1,1})
grid on

%% Transducers envelopes

transducer_envelopes = {};

transducer_1_filtered = filter_transducer_signal(tr_1, time, point1, point2);
transducer_1_filtered(1:55) = zeros(55,1);
transducer_envelopes(1) = {[zeros(55,1); envelope(transducer_1_filtered(55:length(transducer_1_filtered)-1))]};

trancducer_2_filtered = filter_transducer_signal(tr_2, time, point1, point2);
trancducer_2_filtered(1:55) = zeros(55,1);
transducer_envelopes(2) = {[zeros(55,1); envelope(trancducer_2_filtered(55:length(trancducer_2_filtered)-1))]};


transducer_3_filtered = filter_transducer_signal(tr_3, time, point1, point2);
transducer_3_filtered(1:55) = zeros(55,1);
transducer_envelopes(3) = {[zeros(55,1); envelope(transducer_3_filtered(55:length(transducer_3_filtered)-1))]};


transducer_4_filtered = filter_transducer_signal(tr_4, time, point1, point2);
transducer_4_filtered(1:55) = zeros(55,1);
transducer_envelopes(4) = {[zeros(55,1); envelope(transducer_4_filtered(55:length(transducer_4_filtered)-1))]};


transducer_5_filtered = filter_transducer_signal(tr_5, time, point1, point2);
transducer_5_filtered(1:55) = zeros(55,1);
transducer_envelopes(5) = {[zeros(55,1); envelope(transducer_5_filtered(55:length(transducer_5_filtered)-1))]};


transducer_6_filtered = filter_transducer_signal(tr_6, time, point1, point2);
transducer_6_filtered(1:55) = zeros(55,1);
transducer_envelopes(6) = {[zeros(55,1); envelope(transducer_6_filtered(55:length(transducer_6_filtered)-1))]};


transducer_7_filtered = filter_transducer_signal(tr_7, time, point1, point2);
transducer_7_filtered(1:55) = zeros(55,1);
transducer_envelopes(7) = {[zeros(55,1); envelope(transducer_7_filtered(55:length(transducer_7_filtered)-1))]};


transducer_8_filtered = filter_transducer_signal(tr_8, time, point1, point2);
transducer_8_filtered(1:55) = zeros(55,1);
transducer_envelopes(8) = {[zeros(55,1); envelope(transducer_8_filtered(55:length(transducer_8_filtered)-1))]};

%% B-mode image filtered 
img = cell2mat(transducer_envelopes);
imagesc(img);
colormap(gray);
xlabel("Transducers");
ylabel("Distance");

%% B-mode image unfiltered

img2 = cell2mat(unfiltered_envelopes);
imagesc(img2);
colormap(gray);
xlabel("Transducers");
ylabel("Distance");



