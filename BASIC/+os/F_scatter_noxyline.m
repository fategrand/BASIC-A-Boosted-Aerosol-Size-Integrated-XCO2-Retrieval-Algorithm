function out = F_scatter_noxyline(x,y,size,xlim,ylim,xtitle,ytitle)
 
%% 圏片尺寸没置（単位：厘米）
scale_factor=1.1;
figureUnits = 'centimeters';
figureWidth = 13*scale_factor;
figureHeight = 12*scale_factor;
figureHandle = figure;
set(gcf, 'Units', figureUnits, 'Position', [0 0 figureWidth figureHeight]);
set(gcf,'ToolBar','none','ReSize','off');   % 移除工具栏
set(gcf,'color','w'); % 背景设为白色
hold on
 
%% 颜色设置
C1 = [241 64 64] ./ 255; % origin里的红色
C2 = [26 111 223] ./ 255;% origin里的蓝色
 
%% 字体大小设置
font_size = 13*scale_factor; % orogin 8
 
%% 评价指标计算
p=polyfit(x,y,1);%一次拟合;
yfit=polyval(p,x);%求拟合后的y值;
mdl = fitlm(x,y);%求一元线性拟合的参数
r2 = num2str(mdl.Rsquared.Ordinary,'%.3f');% 即一元线性拟合的R平方
R1=corrcoef(x,y);
R=num2str(R1(1,2));% 相关性R
RMSE = num2str(sqrt(sum((y-x).^2)/length(x)),'%.3f'); 
BIAS = num2str(mean(x - y),'%.3f');
% RMB = num2str((sum(y)/length(y))/(sum(x)/length(x)),'%.3f');
MAE = num2str(sum(abs(y-x))/length(x),'%.3f');
a = num2str(p(1),'%.3f');%即y=ax+b中的a值
b = num2str(abs(p(2)),'%.3f');%即y=ax+b中的b值
 
%% 散点绘制; 大小颜色样式
Plot1 = scatter(x,y,size,'filled');
% colorbar
hold on;
%% 设置坐标轴
set(gca, 'Box', 'on', ...                                % 边框
         'XGrid', 'on', 'YGrid', 'on', ...               % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  % 坐标轴颜色
         'Xlim' ,[min(xlim),max(xlim)],'Ylim' ,[min(ylim),max(ylim)], ...          % 坐标轴范围
         'LooseInset',[0,0,0,0])          
%暂时没用到的     
%          'XTick', 0:0.1:1.2,  'YTick', 0:0.05:0.5,...     % 刻度位置、间隔
%          'Xticklabel',{[0:0.1:1.2]},...                   % X坐标轴刻度标签
%          'Yticklabel',{[0:0.05:0.5]},...                  % Y坐标轴刻度标签
%% 拟合线绘制
Plot2 = plot(x,yfit,'-','Color','black','LineWidth',1); 

LA=axis;
% if p(1,2) > 0
%     text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.90+LA(3)],'String',['y = ',a,'x + ',b],'FontName','Times New Roman','fontsize',font_size,'Color','black');
% end
% if p(1,2) < 0
%     text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.90+LA(3)],'String',['y = ',a,'x - ',b],'FontName','Times New Roman','fontsize',font_size,'Color','black');
% end
 
%% 添加评价指标文本
text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.90+LA(3)],'String',['R^2 = ',r2],'FontName','Times New Roman','FontSize',font_size,FontWeight='bold')
text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.85+LA(3)],'String',['R = ',R],'FontName','Times New Roman','FontSize',font_size,FontWeight='bold')
% text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.75+LA(3)],'String',['BIAS = ',BIAS],'FontName','Times New Roman','FontSize',font_size)
% text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.70+LA(3)],'String',['RMSE = ',RMSE],'FontName','Times New Roman','fontsize',font_size);
% text('Position',[(LA(2)-LA(1))*0.02+LA(1),(LA(4)-LA(3))*0.65+LA(3)],'String',['MAE =  ',MAE],'FontName','Times New Roman','fontsize',font_size);
 
%% 添加标题
% htitle = title('Test',FontSize=12,FontWeight='bold',FontName='Times New Roman');%标题
 
%% 添加x和y轴标签
hXLabel = xlabel(xtitle);%这里是x轴的标签
hYLabel = ylabel(ytitle);%这里是y轴的标签
 
%% 创建 legend
hLegend = legend([Plot1,Plot2], ...
'Enhanced pixels','Liner regression line',...
'Location', 'northeast',...
'Orientation','vertical',...
'TextColor', 'black');
 
% 如果需要微调位置
% P = hLegend.Position;
% hLegend.Position = P + [ 0.03 0.03 0 0];
 
%% 设置字体和字号
set(gca,'FontName','Times New Roman','FontSize',font_size);
set([hXLabel,hYLabel],'FontName','Times New Roman','FontSize',font_size)
% set(htitle,'FontName','Times New Roman','FontSize',12,'FontWeight','bold')
 
%% 图片输出
fileout = 'test';
print(figureHandle,[fileout, 'png'],'-r300','-dpng');
end
 