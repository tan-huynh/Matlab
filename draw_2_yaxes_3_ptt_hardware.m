%% --------------------------------------
%% M.Sc Tan Huynh Ngoc
%% Hochschule Mannheim
%% --------------------------------------

figure,
set(gcf,'NextPlot','add');
ax(1) = axes; ax_pos = get(ax(1),'Position'); grid on; hold on; 
a1 = plot(time_filtered_ptt_smooth_1,filtered_ptt_smooth_1,'k.-','MarkerSize',0.5,'linewidth',1.4), hold on, grid on;
plot(time_filtered_ptt_smooth_2,filtered_ptt_smooth_2,'b.-','MarkerSize',0.5,'linewidth',1.4), hold on;
plot(time_filtered_ptt_smooth_3,filtered_ptt_smooth_3,'g.-','MarkerSize',0.5,'linewidth',1.4);
a = get(gca,'Children');
%set(ax(1),'xlim',[t_lo t_hi]);
set(ax(1),'ylim',[2.515 2.546]);
xlabel('Time / s'); ylabel('Spannung / V');
title('PTT Hardware');
ax(2) = axes('Position',ax_pos);
plot(time_filtered_pressure_1, filtered_pressure_1','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_2, filtered_pressure_2','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_3, filtered_pressure_3','r-','linewidth',2,'markersize',5);
b = get(gca,'Children');
set(ax(2),'Color','none','YAxisLocation','right','YColor','r');
%set(ax(2),'xlim',[t_lo t_hi],'xtick',t_lo:t_hi,'ylim',[P_MIN P_MAX],'ytick',P_MIN:P_STEP:P_MAX,'Box','on');
set(ax(2),'XTickLabel',[],'FontWeight','demi');
ylabel('Manschettendruck / mmHg');
Leg = legend([a1; b], {'U_{y} gefiltert','Manschettendruck'});
Pos = get(Leg, 'Position');
set(Leg, 'Position', [Pos(1:4)]);
linkaxes([ax(1) ax(2)], 'x'); dualcursor;%vertical_cursors;

