function [filtered_signal]=filter_transducer_signal(transducer, time, point1, point2)
ind_point1 = find(time(:)>point1(1),1);
offset_line = (point2(2)-point1(2))*(0:1/(length(time)-ind_point1-1):1);
line = [zeros(ind_point1,1); offset_line'];
line = line + point1(2);
filtered_signal = transducer - line;
end