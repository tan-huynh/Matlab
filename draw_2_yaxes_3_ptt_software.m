%% --------------------------------------
%% M.Sc Tan Huynh Ngoc
%% Hochschule Mannheim
%% huynh.ngoctan@yahoo.com
%% --------------------------------------

figure,
set(gcf,'NextPlot','add');
ax(1) = axes; ax_pos = get(ax(1),'Position'); grid on; hold on; 
a1 = plot(time_ptt_1,ptt_arr_1,'k.-','MarkerSize',0.5,'linewidth',1.4), hold on, grid on;
plot(time_ptt_2,ptt_arr_2,'b.-','MarkerSize',0.5,'linewidth',1.4), hold on;
plot(time_ptt_3,ptt_arr_3,'g.-','MarkerSize',0.5,'linewidth',1.4);
a = get(gca,'Children');
%set(ax(1),'xlim',[t_lo t_hi]);
set(ax(1),'ylim',[-0.02 0.05]);
xlabel('Time / s'); ylabel('Time / s');
title('PTT Software');
ax(2) = axes('Position',ax_pos);
plot(time_A_1, AManschett_1','r-','linewidth',2,'markersize',5); hold on;
plot(time_A_2, AManschett_2','r-','linewidth',2,'markersize',5); hold on;
plot(time_A_3, AManschett_3','r-','linewidth',2,'markersize',5);
b = get(gca,'Children');
set(ax(2),'Color','none','YAxisLocation','right','YColor','r');
%set(ax(2),'xlim',[t_lo t_hi],'xtick',t_lo:t_hi,'ylim',[P_MIN P_MAX],'ytick',P_MIN:P_STEP:P_MAX,'Box','on');
set(ax(2),'XTickLabel',[],'FontWeight','demi');
ylabel('Manschettendruck / mmHg');
Leg = legend([a1; b], {'PTT Software','Manschettendruck'});
Pos = get(Leg, 'Position');
set(Leg, 'Position', [Pos(1:4)]);
linkaxes([ax(1) ax(2)], 'x'); dualcursor;%vertical_cursors;
