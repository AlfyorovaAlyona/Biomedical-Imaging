%% Task 4a
p_0 = 100000; %Pa
c = 1500;
f = 500000; %Hz
k = (2*pi) / (c/f);

%% 
z = -5:0.01:5; %x
z_0 = -5;
figure(1);
for t=1:11
    T = t*1/1500;
    p_1 = p_0.*exp(-(z - z_0 - c*T).^2).*cos(k.*(z - z_0 - c*T));
    plot(z, p_1);
    
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'task4a.gif';

    if t==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end


%% Task 4b
z = -0.05:0.0001:0.05; %z
x = -0.05:0.0001:0.05; %x
z_0 = 0; %m
x_0 = -0.05; %m

figure(2);

[X,Z] = meshgrid(x, z);

for t=-5:1:5
    
    r = sqrt((X-x_0).^2+(Z-z_0).^2);
    T = (1/1500)*t;
    p = (p_0./ sqrt(r)) .*exp(-(r - c.*T).^2).*cos(k.*(r - c.*T));

    imagesc(p);
    
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'task4b.gif';
  
    % On the first loop, create the file. In subsequent loops, append.
    if t==-5
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end  

%% Task 5a
figure(3);
z = [-0.03:0.0001:0.03]; %x
x = [-0.05:0.0001:0.05]; %z

[X,Z] = meshgrid(x, z);
z_0 = -0.03; %m
x_0 = -0.05; %m
for t=-5:1:5
    T = (1/1500)*t;
    r_0 = sqrt((X-x_0).^2+(Z-z_0).^2);
    p_1 = (p_0./ sqrt(r_0)) .*exp(-(r_0 - c.*T).^2).*cos(k.*(r_0 - c.*T));
    
    z_1 = z_0 + c/(2*f);
    r_1 = sqrt((X-x_0).^2+(Z-z_1).^2);
    p_2 = (p_0./ sqrt(r_1)) .*exp(-(r_1 - c.*T).^2).*cos(k.*(r_1 - c.*T));
    
    z_2 = z_0 + 2*c/(2*f);
    r_2 = sqrt((X-x_0).^2+(Z-z_2).^2);
    p_3 = (p_0./ sqrt(r_2)) .*exp(-(r_2 - c.*T).^2).*cos(k.*(r_2 - c.*T));
    
    z_3 = z_0 + 3*c/(2*f);
    r_3 = sqrt((X-x_0).^2+(Z-z_3).^2);
    p_4 = (p_0./ sqrt(r_3)) .*exp(-(r_3 - c.*T).^2).*cos(k.*(r_3 - c.*T));
    
    z_4 = z_0 + 4*c/(2*f);
    r_4 = sqrt((X-x_0).^2+(Z-z_4).^2);
    p_5 = (p_0./ sqrt(r_4)) .*exp(-(r_4 - c.*T).^2).*cos(k.*(r_4 - c.*T));
    
    z_5 = z_0 + 5*c/(2*f);
    r_5 = sqrt((X-x_0).^2+(Z-z_5).^2);
    p_6 = (p_0./ sqrt(r_5)) .*exp(-(r_5 - c.*T).^2).*cos(k.*(r_5 - c.*T));
    
    z_6 = z_0 + 6*c/(2*f);
    r_6 = sqrt((X-x_0).^2+(Z-z_6).^2);
    p_7 = (p_0./ sqrt(r_6)) .*exp(-(r_6 - c.*T).^2).*cos(k.*(r_6 - c.*T));
    
    z_7 = z_0 + 7*c/(2*f);
    r_7 = sqrt((X-x_0).^2+(Z-z_7).^2);
    p_8 = (p_0./ sqrt(r_7)) .*exp(-(r_7 - c.*T).^2).*cos(k.*(r_7 - c.*T));
    
    z_8 = z_0 + 8*c/(2*f);
    r_8 = sqrt((X-x_0).^2+(Z-z_8).^2);
    p_9 = (p_0./ sqrt(r_8)) .*exp(-(r_8 - c.*T).^2).*cos(k.*(r_8 - c.*T));
    
    imagesc(p_1+p_2+p_3+p_4+p_5+p_6+p_7+p_8+p_9);  
    
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'task5a.gif';
  
    % On the first loop, create the file. In subsequent loops, append.
    if t==-5
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end  
%% Task 5b
  
z = -0.03:0.0001:0.03; %z
x = -0.05:0.0001:0.05; %x
z_0 = 0; %m
x_0 = -0.05; %m

figure(4);
R = 0.05;
a = pi/16;
[X,Z] = meshgrid(x, z);

for t=-5:1:5
    
    r = sqrt((X-x_0).^2+(Z-z_0).^2);
    T = (1/1500)*t;
    p = (p_0./ sqrt(r)) .*exp(-(r - c.*T).^2).*cos(k.*(r - c.*T));
    
    z_1 = z_0 - R*sin(a);
    x_1 = x_0 + R - R*cos(a); 
    r_1 = sqrt((X-x_1).^2+(Z-z_1).^2);
    p_1 = (p_0./ sqrt(r_1)) .*exp(-(r_1 - c.*T).^2).*cos(k.*(r_1 - c.*T));
    
    z_2 = z_0 + R*sin(a);
    x_2 = x_0 + R - R*cos(a); 
    r_2 = sqrt((X-x_2).^2+(Z-z_2).^2);
    p_2 = (p_0./ sqrt(r_2)) .*exp(-(r_2 - c.*T).^2).*cos(k.*(r_2 - c.*T));
    
    z_3 = z_0 - R*sin(2*a);
    x_3 = x_0 + R - R*cos(2*a); 
    r_3 = sqrt((X-x_3).^2+(Z-z_3).^2);
    p_3 = (p_0./ sqrt(r_3)) .*exp(-(r_3 - c.*T).^2).*cos(k.*(r_3 - c.*T));
    
    z_4 = z_0 + R*sin(2*a);
    x_4 = x_0 + R - R*cos(2*a); 
    r_4 = sqrt((X-x_4).^2+(Z-z_4).^2);
    p_4 = (p_0./ sqrt(r_4)) .*exp(-(r_4 - c.*T).^2).*cos(k.*(r_4 - c.*T));
    
    z_5 = z_0 - R*sin(3*a);
    x_5 = x_0 + R - R*cos(3*a); 
    r_5 = sqrt((X-x_5).^2+(Z-z_5).^2);
    p_5 = (p_0./ sqrt(r_5)) .*exp(-(r_5 - c.*T).^2).*cos(k.*(r_5 - c.*T));
    
    z_6 = z_0 + R*sin(3*a);
    x_6 = x_0 + R - R*cos(3*a); 
    r_6 = sqrt((X-x_6).^2+(Z-z_6).^2);
    p_6 = (p_0./ sqrt(r_6)) .*exp(-(r_6 - c.*T).^2).*cos(k.*(r_6 - c.*T));
    
    z_7 = z_0 - R*sin(4*a);
    x_7 = x_0 + R - R*cos(4*a); 
    r_7 = sqrt((X-x_7).^2+(Z-z_7).^2);
    p_7 = (p_0./ sqrt(r_7)) .*exp(-(r_7 - c.*T).^2).*cos(k.*(r_7 - c.*T));
    
    z_8 = z_0 + R*sin(4*a);
    x_8 = x_0 + R - R*cos(4*a); 
    r_8 = sqrt((X-x_8).^2+(Z-z_8).^2);
    p_8 = (p_0./ sqrt(r_8)) .*exp(-(r_8 - c.*T).^2).*cos(k.*(r_8 - c.*T));

    imagesc(p+p_1+p_2+p_3+p_4+p_5+p_6+p_7+p_8);
    
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'task5b.gif';
  
    % On the first loop, create the file. In subsequent loops, append.
    if t==-5
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end  
    

%% Task 5c
figure(5);
z = -0.03:0.0001:0.03; %x
x = -0.05:0.0001:0.05; %z

[X,Z] = meshgrid(x, z);
z_0 = -0.03; %m
x_0 = -0.05; %m

press = {};
i=5; %central element
delays = [-(1/c)*(sqrt((1-i)^2*c/(2*f))),-(1/c)*(sqrt((2-i)^2*c/(2*f))),-(1/c)*(sqrt((3-i)^2*c/(2*f))),-(1/c)*(sqrt((4-i)^2*c/(2*f))),-(1/c)*(sqrt((5-i)^2*c/(2*f))),-(1/c)*(sqrt((6-i)^2*c/(2*f))),-(1/c)*(sqrt((7-i)^2*c/(2*f))),-(1/c)*(sqrt((8-i)^2*c/(2*f))),-(1/c)*(sqrt((9-i)^2*c/(2*f)))];
zs = [0, c/(2*f), 2*c/(2*f), 3*c/(2*f), 4*c/(2*f), 5*c/(2*f), 6*c/(2*f), 7*c/(2*f), 8*c/(2*f)];
T = [-(1/1500)*0, (1/1500)*1, (1/1500)*2, (1/1500)*3, (1/1500)*4, (1/1500)*5, (1/1500)*6, (1/1500)*7, (1/1500)*8];
for t=-5:1:5
    for s=1:9
        T_1 = (1/1500)*t + delays(s)*t;
        z_1 = z_0 + zs(s);
        r_0 = sqrt((X-x_0).^2+(Z-z_1).^2);
        press(s) = { (p_0./ sqrt(r_0)) .*exp(-(r_0 - c.*T_1).^2).*cos(k.*(r_0 - c.*T_1)) };
        
    end
    imagesc(press{1} + press{2} + press{3} + press{4} + press{5} + press{6} + press{7} + press{8} + press{9});  

    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    outfile = 'task5c.gif';

    % On the first loop, create the file. In subsequent loops, append.
    if t==-5
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end  














