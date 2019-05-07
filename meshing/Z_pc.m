function Points = Z_pc(nPointsX,nPointsY,zWidth,height)

% clear; clc;
% nPointsX = 50;
% nPointsY = 50;
% zWidth = 10;
% height = 10;

% Bottom of the Z
xBot = 1:nPointsX; yBot = ones(size(xBot));   
xBot2 = xBot(1:nPointsX/2+1); yBot2 = zWidth*yBot((1:nPointsX/2+1));
xSide1 = ones(1,zWidth-2); ySide1 = 2:zWidth-1;
xSide11 = nPointsX*ones(1,zWidth-1); ySide11 = 2:zWidth;
% Top of the Z
xTop = 1:nPointsX; yTop = yBot*nPointsY;
xTop2 = xTop(nPointsX/2:nPointsX); 
yTop2 = (yTop-zWidth+1); yTop2 = yTop2(nPointsX/2:nPointsX);
xSide2 = xBot(end)*ones(size(xSide1)); ySide2 = yTop2(1)+1:nPointsY-1;
xSide22 = ones(1,zWidth-1); ySide22 = yTop2(1):nPointsY-1;
% Inner line 1
p1 = [1,min(ySide22)]; p2 = [xBot2(end),zWidth];
m = (p1(2) - p2(2))/(p1(1)-p2(1)); b1 = p1(2) - m*p1(1);
xx = 2:nPointsX/2; yy = m*xx + b1;
% Inner line 2
p1 = [xTop2(1),yTop2(1)]; p2 = [nPointsX,max(ySide11)];
m = (p1(2) - p2(2))/(p1(1)-p2(1)); b1 = p2(2) - m*p2(1);
xx2 = nPointsX/2+1:nPointsX-1; yy2 = m*xx2 + b1;
% Plot Points
X = [xBot,xBot2,xSide1,xSide11,xTop,xTop2,xSide2,xSide22,xx,xx2];
Y = [yBot,yBot2,ySide1,ySide11,yTop,yTop2,ySide2,ySide22,yy,yy2];
XXFull = repmat(X,[1,height-2]); YYFull = repmat(Y,[1 height-2]);
ZZFull = ones(size(X));
for ii = 2:height-2
%     pt1 = ZZFull(end)+1; 
%     pt2 = ii*length(X);
    temp = ii*ones(size(X)); 
    ZZFull = [ZZFull,temp];
end
Pts = [(XXFull'-1),YYFull'-1,ZZFull'];

    % Filled Top
% Bottom of the Z
Bottom = [repmat((0:nPointsX-1)',[zWidth 1]) sort(repmat((0:zWidth-1)',[nPointsX 1]))];
% Top of the Z
Top = Bottom+[0 nPointsY-zWidth];
% Slant of the Z
b = min(Top); m = ([round(nPointsX/2) max(Bottom(:,2))] - b);
Slant = m/abs(m(1)).*(1:(round(nPointsX/2)-1) )'+b;
temp=[];
for ii=0:Slant(end,1)
temp = [temp ; Slant(:,1)+ii Slant(:,2)];
end
Slant = temp;
Pts2 = [Bottom;Slant;Top]; 
% Pts2 = [[Pts2 zeros(length(Pts2(:,1)),1)] ; [Pts2 ones(length(Pts2(:,1)),1)*height-1]];
% Points = [Pts ; Pts2];

Points = [[Pts2 zeros(length(Pts2(:,1)),1)] ; Pts ; [Pts2 ones(length(Pts2(:,1)),1)*height-1]];
end
