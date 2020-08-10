function c20069587()
% Process for Disks Image
%loading 'disk' objects
object1 = load('data/object01.txt');
object2 = load('data/object02.txt');
object3 = load('data/object03.txt');
object4 = load('data/object04.txt');
object5 = load('data/object05.txt');
object6 = load('data/object06.txt');
%create individual figure
figure;
% Load the image from a local directory
disksImage= imread('data/disksimage.png');
imshow(disksImage);
% Display circlefits on disksImage
hold on;
[center radius rmserr] = circlefit(object1);
circleplot(center, radius, 'r')
[center radius rmserr] = circlefit(object2);
circleplot(center, radius, 'g')
[center radius rmserr] = circlefit(object3);
circleplot(center, radius, 'm')
[center radius rmserr] = circlefit(object4);
circleplot(center, radius, 'y')
[center radius rmserr] = circlefit(object5);
circleplot(center, radius, 'm')
[center radius rmserr] = circlefit(object6);
circleplot(center, radius, 'g')
hold off

%Process for Pill Image
object7 = load('data/object07.txt');
object8 = load('data/object08.txt');
object9 = load('data/object09.txt');
object10 = load('data/object10.txt');
%create individual figure
figure;
% Load the image from a local directory
pillImage= imread('data/pillsetgray.png');
imshow(pillImage);
% Display circlefits on pillImage
hold on;
[center radius rmserr] = circlefit(object7);
circleplot(center, radius, 'r')
[center radius rmserr] = circlefit(object8);
circleplot(center, radius, 'g')
[center radius rmserr] = circlefit(object9);
circleplot(center, radius, 'm')
[center radius rmserr] = circlefit(object10);
circleplot(center, radius, 'y')
hold off

end


function [center radius rmserr] = circlefit(xydata)
% Problem size
[m, n] = size(xydata);

% Set up data matrix A 
A = ones(m, n+1);
% Set up data vector b
b = ones(m,1);

for i = 1 : m %rows
    %calculating -Xj * Xj^T for b and -2Xj for A
    b(i) = -1 * xydata(i,:) * xydata(i,:)';
    for k = 1 : n %columns
        A(i,k) = -2 * xydata(i,k);
    end 
end
%QR Decomposition
[Q,R] = qr(A,0);
y = Q' * b;

%back-substitution
z = length(y);
x = zeros(z,1);
for w = z:-1:1
    x(w) = y(w)/R(w,w);
    y(1:w-1) = y(1:w-1)-R(1:w-1,w)*x(w);
end
%calculate and display radius
radius = sqrt(dot(x(1:2),x(1:2)) - x(3))
%display center
center = x(1:2)
rmseSum = 0;
%algorithm uses short wide matrix
xydata = xydata';
for i = 1:m
    %calculating risidual error for each set, uses m from non-transposed
    %matrix, equivalent to n of transposed
    rmseSum = rmseSum + (norm(xydata(:,i) - center) - radius)^2;
end
%calculating RMSE
rmserr = sqrt(norm(rmseSum)/m)
end
