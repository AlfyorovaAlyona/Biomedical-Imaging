%% Task2

p_i = 18000; %Pa
len_skin = 0.23; %cm
len_fat = 2; %cm
len_bone = 3; %cm

Z_skin = 1.63;
Z_fat = 1.38;
Z_bone = 6.1;
Z_muscle = 1.65;

alpha_skin = 1.1;
alpha_fat = 0.69;
alpha_bone = 23;
alpha_muscle = 3.8;

c_skin = 1500;
c_fat = 1470;
c_bone = 4080;
c_muscle = 1568;

%% part1: calculate transmission and reflection
%from skin to fat
R_sf = reflection(Z_skin,Z_fat);
T_sf = transmission(Z_skin,Z_fat);

%from fat to bone
R_fb = reflection(Z_fat,Z_bone);
T_fb = transmission(Z_fat,Z_bone);

%from bome to muscle
R_bm = reflection(Z_bone,Z_muscle);
T_bm = transmission(Z_bone,Z_muscle);

%from muscle to bone
R_mb = reflection(Z_muscle,Z_bone);
T_mb = transmission(Z_muscle,Z_bone);

%from bone to fat
R_bf = reflection(Z_bone,Z_fat);
T_bf = transmission(Z_bone,Z_fat);

%from fat tto skin
R_fs = reflection(Z_fat,Z_skin);
T_fs = transmission(Z_fat,Z_skin);
%% 

% initial wave enters fat from skin
% skin abs
pi_s = absorption(p_i,alpha_skin,len_skin);
% skin -> fat transmission
pt_sf = T_sf * pi_s;
% fat reflection
pr_sf = R_sf * pi_s;
%fat abs
pi_f = absorption(pt_sf,alpha_fat,len_fat);
%  fat -> bone transmission
pt_fb = T_fb * pi_f;
pr_fb = R_fb * pi_f;
% bone abs
pi_b = absorption(pt_fb,alpha_bone,len_bone);
% bone -> muscle reflection
pr_bm = R_bm * pi_b;

% skin -> | -> skin 

%first echo
p_fat_reflection = absorption(pr_sf,alpha_skin,len_skin);


%skin -> fat -> | -> fat -> skin 
pr_bone = absorption(pr_fb, alpha_fat,len_fat);
pr_bone_fat = T_fs * pr_bone;
%second echo
p_bone_refletcion = absorption(pr_bone_fat, alpha_skin,len_skin);


% | -> bone -> fat -> skin
pi_b_ref = absorption(pr_bm,alpha_bone,len_bone);
pt_bf = T_bf * pi_b_ref;
pi_f_ref = absorption(pt_bf,alpha_fat,len_fat);
pt_fs = T_fs * pi_f_ref;

% third echo
p_muscle_reflection = absorption(pt_fs,alpha_skin,len_skin);


%% Time-of-flight
t_skin = (len_skin*0.01)/c_skin;
t_fat = (len_fat*0.01)/c_fat;
t_bone = (len_bone*0.01)/c_bone;

t_1 = t_skin*2;
t_2 = t_skin*2 + t_fat*2;
t_3 = t_skin*2 + t_fat*2 + t_bone*2;

%% PLOTING
fat_reflection_time = [0 t_skin t_skin t_skin*2];
fat_reflection_pressure = [p_i pi_s pr_sf p_fat_reflection];

bone_reflection_time = [0 t_skin t_skin t_skin+t_fat t_skin+t_fat t_skin+2*t_fat t_skin+2*t_fat 2*t_skin+2*t_fat];
bone_reflection_pressure = [p_i pi_s pt_sf pi_f pr_fb pr_bone pr_bone_fat p_bone_refletcion];

muscle_reflection_time = [0 t_skin t_skin t_skin+t_fat t_skin+t_fat t_skin+t_fat+t_bone t_skin+t_fat+t_bone t_skin+t_fat+2*t_bone t_skin+t_fat+2*t_bone t_skin+2*t_fat+2*t_bone t_skin+2*t_fat+2*t_bone 2*t_skin+2*t_fat+2*t_bone];
muscle_reflection_pressure = [p_i pi_s pt_sf pi_f pt_fb pi_b pr_bm pi_b_ref pt_bf pi_f_ref pt_fs p_muscle_reflection];

subplot(3,1,1); hold on;
title("Fat reflection")
xlabel("Time [s]")
ylabel("P [Pa]")
plot(fat_reflection_time, abs(fat_reflection_pressure),'-o')
xlim([0 2*t_skin+2*t_fat+2*t_bone])

subplot(3,1,2); hold on;
title("Bone reflection")
xlabel("Time [s]")
ylabel("P[Pa]")
plot(bone_reflection_time,abs(bone_reflection_pressure),'-o')
xlim([0 2*t_skin+2*t_fat+2*t_bone])

subplot(3,1,3); hold on;
title("Muscle reflection")
xlabel("Time [s]")
ylabel("P [Pa]")
plot(muscle_reflection_time,abs(muscle_reflection_pressure),'-o')
xlim([0 2*t_skin+2*t_fat+2*t_bone])
