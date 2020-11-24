%% Nerts Score Tracker

clear; close; clc;

%% Game Set Up
prompt= {'How many teams are playing?','What score would you like to play to?','How many points is a nert worth?','How many point is a card left in your hand worth?'};
title= 'Game SetUp';
dims= [1 50];
setup= inputdlg(prompt,title,dims);
tn= str2double(setup(1));
ms= str2double(setup(2));
nertscore= str2double(setup(3));
handscore= str2double(setup(4));

handscore= abs(handscore);

ss= zeros(2,tn);

%% Gameplay Score Sheet
ii=1;
while max(ss(end,:))<ms
    %Round input 
        title= ['Round: ' num2str(ii)];
        ii=ii+1;
        dims= [1 50];
        sp(1,:)= "Which team nerted?";
        for tt= 1:tn
            sp(tt+1,:)= ['Team ' num2str(tt) ' cards left in hand'];
            sp(tn+tt+1,:)= ['Team ' num2str(tt) ' cards in middle'];
        end
        round= inputdlg(sp,title,dims);
    %Reading round input
        nertteam= str2double(round(1));
        for rr= 2:tn+1
            hand(rr-1)= str2double(round(rr)); %#ok<*SAGROW>
        end
        for tt= tn+2: length(round)
            mid(tt-tn-1)= str2double(round(tt));
        end
    %Scoring
        for jj=1:tn
            ss(ii,jj)= ss(ii-1,jj)+ mid(jj)-handscore*(hand(jj));
            if jj== nertteam
                ss(ii,jj)= ss(ii,jj)+nertscore;
            end
        end
        fprintf('Round %d Scores\n', ii-1)
        for kk=1:tn
            fprintf('\t Team %d score: %d\n', kk, ss(ii,kk))
        end
end

%% Ending Notes
fprintf('Ending Scores\n')
hold on
for ii=1:tn
    fprintf('\t Team %d final score: %d\n', ii, ss(end,ii))
    name = ['Team ' num2str(ii)];
    plot(ss(:,ii), 'DisplayName', name,'linewidth',2)
end
legend('Team 1','Team 2','location','best')
grid on