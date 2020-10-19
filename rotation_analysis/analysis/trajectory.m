close all 


pasta = '../outputs/';
Files = dir(pasta);
Names = {Files.name};
Names = Names(3:end);
Names = string(Names)

Names = cell(1,1);
tmp = sprintf('Data01_a0_05_p0_20/Out00000.txt');
Names{1} = tmp;
Names = string(Names);
n = size(Names,2);
res = cell(n,1);

for k=1:n
    [matrix] = ReadTxt(strcat(pasta,Names(k)),true);
    n_points = size(matrix,1);
    %matrix = matrix(1:n_points/2,:);
    res{k} = mat2cell(matrix, size(matrix,1), size(matrix,2));
end



f=figure;
view(axes(),3);
grid on, xlabel x, ylabel y, zlabel z;
hold on;
for k=1:n
    matrix = cell2mat(res{k});
    x = matrix(:,2);
    y = matrix(:,3);    
    z = matrix(:,4);
    phi = atan2(z,y);   
    plot3(x,y,z,'DisplayName',strcat('\phi_0 = ',num2str(phi(1))));
end
legend()
%axis([-1800 800 -5 5 -5 5])


f2=figure;
grid on, xlabel t, ylabel phi;
hold on;
for k=1
    matrix = cell2mat(res{k});
    t = matrix(:,1);
    x = matrix(:,2);
    y = matrix(:,3);
    z = matrix(:,4);
    px = matrix(:,5);
    
    mean(px);
    py = matrix(:,6);
    pz = matrix(:,7);
    pperp = sqrt(py.*py + pz.*pz);
    phi = atan2(z,y);
    plot(t,phi,'DisplayName',strcat('\phi_0 = ',num2str(phi(1))));
end
legend()
%axis([0 3000 -10 10])

 






function [matrix] = ReadTxt(path, head)
    file = fopen(path, 'r');
    lts=0;
    if (head) lts=1; end
    matrix = dlmread(path,'',lts,0);
    %nPoints = size(matrix,1);
    %nCols = size(matrix,2);
    fclose(file);
end