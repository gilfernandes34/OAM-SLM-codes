clear all
close all
clc
x = 1 : 1 : 1920; % a row-vector of points for the x-axis
y = 1 : 1 : 1080; % a row-vector of points for the y-axis
A= meshgrid(x,y); % create matrices for grids of X and Y
X=size(x);
Y=size(y);

for b=1:1:1080
 for a=1:1:480
     A(b,a)=0;
 end
 for a=481:1:1920
     A(b,a)=pi;
 end
end

figure(1)
imshow(A)

B= meshgrid(x,y);
for b=1:1:1080
 for a=1:1:960
     B(b,a)=pi;
 end
 for a=961:1:1440
     B(b,a)=pi;
 end
 for a=1441:1:1920
     B(b,a)=0;
 end
end

figure(2)
imshow(B)

C= meshgrid(x,y);
for b=1:1:540
 for a=1:1:960
     C(b,a)=pi;
 end
end
for b=541:1:1080
    for a=961:1:1920
     C(b,a)=0;
    end
end

figure(3)
imshow(C)


D= meshgrid(x,y);
for b=541:1:1079
    for a=1:1:960
        D(b,a)=0;
    for a=961:1:1920
        D(b,a)=pi;
    end
    end
end

figure(4)
imshow(D)














