clear
clc
format short

ri=1;
ro=1.1;
f0=10^(-4);
L=2;

D=3;
th=pi/60;
for i=1:16;
    for j=1:16;
        N=16*(i-1)+j;
        x=D;
        y=D*tan(th*(j-1));
        z=D*tan(th*(i-1));
        T(N,:)=[N x y z];
        theta=asin(y/sqrt(x^2+y^2));
        fe=asin(z/sqrt(x^2+y^2+z^2));
        Node(N,:)=[N ri*cos(fe)*cos(theta) ri*cos(fe)*sin(theta) ri*sin(fe)];
        Node(N+721,:)=[N+721 ro*cos(fe)*cos(theta) ro*cos(fe)*sin(theta) ro*sin(fe)];
    end
end

%===========Arrange Node on Z=D plane========
for i=1:15;
    for j=1:16;
        N=16*(i-1)+j+256;
        x=D*tan(pi/4-th*i);
        y=D*tan(th*(j-1));
        z=D;
        T(N,:)=[N x y z];
        if x==0 & y==0
            theta=pi/2;
            fe=pi/2;
        else
            theta=asin(y/sqrt(x^2+y^2));
            fe=asin(z/sqrt(x^2+y^2+z^2));
        end
        Node(N,:)=[N ri*cos(fe)*cos(theta) ri*cos(fe)*sin(theta) ri*sin(fe)];
        Node(N+721,:)=[N+721 ro*cos(fe)*cos(theta) ro*cos(fe)*sin(theta) ro*sin(fe)];
    end
end


%===========Arrange Node on Y=D plane=========
for i=1:15;
    for j=1:15;
        N=15*(i-1)+j+496;
        x=D*tan(pi/4-th*j);
        y=D;
        z=D*tan(th*(i-1));
        T(N,:)=[N x y z];
        theta=asin(y/sqrt(x^2+y^2));
        fe=asin(z/sqrt(x^2+y^2+z^2));
        Node(N,:)=[N ri*cos(fe)*cos(theta) ri*cos(fe)*sin(theta) ri*sin(fe)];
        Node(N+721,:)=[N+721 ro*cos(fe)*cos(theta) ro*cos(fe)*sin(theta) ro*sin(fe)];
    end
end

%===========Arrange Element on X=D and Z=D plane=======
for i=1:30;
    for j=1:15;
        El(15*(i-1)+j,:)=[15*(i-1)+j 16*(i-1)+j 16*(i-1)+j+1 16*(i-1)+j+17 16*(i-1)+j+16 16*(i-1)+j+721 16*(i-1)+j+1+721 16*(i-1)+j+17+721 16*(i-1)+j+16+721];
    end
end

%=============Arrange Element on Y=D Plane=============
for i=1:14;
    for j=1:14;
        El(15*(i-1)+j+451,:)=[15*(i-1)+j+451 497+15*(i-1)+j-1 497+15*(i-1)+j 497+15*(i-1)+15+j 497+15*(i-1)+14+j 497+15*(i-1)+720+j 497+15*(i-1)+721+j 497+15*(i-1)+15+721+j 497+15*(i-1)+14+721+j];
    end
end

for i=1:14;
    El(451+15*(i-1),:)=[451+15*(i-1) 16*i 497+15*(i-1) 497+15*(i-1)+15 16*(i+1) 16*i+721 497+15*(i-1)+721 497+15*(i-1)+15+721 16*(i+1)+721];
end

El(661,:)=[661 240 707 272 256 240+721 707+721 272+721 256+721];

for i=1:14;
    El(661+i,:)=[661+i 707+(i-1) 707+i 272+16*i 272+16*(i-1) 707+(i-1)+721 707+i+721 272+16*i+721 272+16*(i-1)+721];
end

% refr=[ro L]; 
% 
% for i=1:1;
%     deltal=L-refr(i);
%     Ratio=(refr(i+1)-refr(i))/deltal;
%     %============Generate X=L Plane=============
%     for k=(1+675*i):(225+675*i);
%         NIp=[El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9)];
%         for j=1:4;
%             x=Node(NIp(j),2);
%             y=Node(NIp(j),3);
%             z=Node(NIp(j),4);
%             theta=asin(y/sqrt(x^2+y^2));
%             fe=asin(z/sqrt(x^2+y^2+z^2));
%             OR=sqrt(x^2+y^2+z^2);
%             DL=L/cos(fe)/cos(theta);
%             DR=Ratio*(DL-OR);
%             NR=DR+OR;
%             Node(NIp(j)+721,:)=[NIp(j)+721 NR*cos(fe)*cos(theta) NR*cos(fe)*sin(theta) NR*sin(fe)];
%         end
%         El(k,:)=[k El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9) El((k-675),6)+721 El((k-675),7)+721 El((k-675),8)+721 El((k-675),9)+721];
%     end
%     %==========Generate Z=L Plane=================
%     for k=(226+675*i):(450+675*i);
%         NIp=[El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9)];
%         for j=1:4;
%             x=Node(NIp(j),2);
%             y=Node(NIp(j),3);
%             z=Node(NIp(j),4);
%             if x==0 & y==0
%                 theta=pi/2;
%                 fe=pi/2;
%             else
%                 theta=asin(y/sqrt(x^2+y^2));
%                 fe=asin(z/sqrt(x^2+y^2+z^2));
%             end
%             OR=sqrt(x^2+y^2+z^2);
%             DL=L/sin(fe);
%             DR=Ratio*(DL-OR);
%             NR=DR+OR;
%             Node(NIp(j)+721,:)=[NIp(j)+721 NR*cos(fe)*cos(theta) NR*cos(fe)*sin(theta) NR*sin(fe)];
%         end
%         El(k,:)=[k El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9) El((k-675),6)+721 El((k-675),7)+721 El((k-675),8)+721 El((k-675),9)+721];
%     end
%     %==========Generate Y=L Plane=================
%     for k=(451+675*i):(675+675*i);
%         NIp=[El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9)];
%         for j=1:4;
%             x=Node(NIp(j),2);
%             y=Node(NIp(j),3);
%             z=Node(NIp(j),4);
%             theta=asin(y/sqrt(x^2+y^2));
%             fe=asin(z/sqrt(x^2+y^2+z^2));
%             OR=sqrt(x^2+y^2+z^2);
%             DL=L/cos(fe)/sin(theta);
%             DR=Ratio*(DL-OR);
%             NR=DR+OR;
%             Node(NIp(j)+721,:)=[NIp(j)+721 NR*cos(fe)*cos(theta) NR*cos(fe)*sin(theta) NR*sin(fe)];
%         end
%         El(k,:)=[k El((k-675),6) El((k-675),7) El((k-675),8) El((k-675),9) El((k-675),6)+721 El((k-675),7)+721 El((k-675),8)+721 El((k-675),9)+721];
%     end
% end

filename1='testond.txt';
fid=fopen(filename1,'w');
for i=1:size(Node,1);
    fprintf(fid, '%5.0f, %5.4f, %5.4f, %5.4f\n', Node(i,:));
end
fclose(fid);

filename1='testoel.txt';
fid=fopen(filename1,'w');
for i=1:size(El,1);
    fprintf(fid, '%5.0f, %5.0f, %5.0f, %5.0f, %5.0f, %5.0f, %5.0f, %5.0f, %5.0f\n', El(i,:));
end
fclose(fid);

filename2='testo.inp';
fid=fopen(filename2,'w');
fprintf(fid,'*HEADING\n');
fprintf(fid,'*NODE, NSET=ALLNODES, input=testond.txt\n');
fprintf(fid,'*ELEMENT, TYPE=C3D8, ELSET=ALL, input=testoel.txt\n');
fprintf(fid,'*Nset, nset=Load\n');
fprintf(fid,'14676\n');
fprintf(fid,'*Nset, nset=Inner1\n');
fprintf(fid,'1\n');
fprintf(fid,'*Nset, nset=Inner2\n');
fprintf(fid,'511\n');
fprintf(fid,'*Nset, nset=Inner3\n');
fprintf(fid,'481\n');
fprintf(fid,'*Elset, Elset=XZ\n');
fprintf(fid,'13486\n')
fprintf(fid,'*Elset, Elset=XY\n');
fprintf(fid,'13065\n');
fprintf(fid,'*Elset, Elset=YZ\n');
fprintf(fid,'13050\n');
fprintf(fid,'*Solid Section, elset=ALL, material=material1\n');
fprintf(fid,'*Material, name=Material1\n');
fprintf(fid,'*Hyperelastic, neo hooke\n');
fprintf(fid,'0.5, 2\n');
fprintf(fid,'*boundary\n');
fprintf(fid,'Surf-In-1,1,1\n');
fprintf(fid,'Surf-In-2,2,2\n');
fprintf(fid,'Surf-In-3,3,3\n');
fprintf(fid,'*EQUATION\n');
fprintf(fid,'2\n');
fprintf(fid,'Surf-Out-1,1,1,Load,1,-1\n');
fprintf(fid,'2\n');
fprintf(fid,'Surf-Out-2,2,1,Load,2,-1\n');
fprintf(fid,'2\n');
fprintf(fid,'Surf-Out-3,3,1,Load,3,-1\n');
fprintf(fid,'*RESTART,WRITE, frequency=0\n');
fprintf(fid,'**step1\n');
fprintf(fid,'*STEP, Name=step1, NLGEOM=YES, inc=10000000000\n');
fprintf(fid,'*STATIC\n');
fprintf(fid,'0.00001,1,0.000001,0.01\n');
fprintf(fid,'*boundary\n');
fprintf(fid,'Load,1,1,10\n');
fprintf(fid,'Load,2,2,10\n');
fprintf(fid,'Load,3,3,10\n');
fprintf(fid,'*Output, field, variable=PRESELECT, frequency=1\n');
fprintf(fid,'*Element Output, Elset=XZ, Position=CENTROIDAL\n');
fprintf(fid,'S\n');
fprintf(fid,'*Element Output, Elset=XY, Position=CENTROIDAL\n');
fprintf(fid,'S\n');
fprintf(fid,'*Element Output, Elset=YZ, Position=CENTROIDAL\n');
fprintf(fid,'S\n');
fprintf(fid,'*Output, history, variable=PRESELECT, frequency=1\n');
fprintf(fid,'*Node Output, nset=Load\n');
fprintf(fid,'COOR1,COOR2,COOR3\n');
fprintf(fid,'*Node Output, nset=Inner1\n');
fprintf(fid,'COOR1,COOR2,COOR3\n');
fprintf(fid,'*Node Output, nset=Inner2\n');
fprintf(fid,'COOR1,COOR2,COOR3\n');
fprintf(fid,'*Node Output, nset=Inner3\n');
fprintf(fid,'COOR1,COOR2,COOR3\n');
fprintf(fid,'*END STEP\n');
fclose(fid);