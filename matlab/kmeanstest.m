function [result] = kmeanstest(M)
% test function for k-means testing

%close all figures
%delete(findall(0,'Type','figure'));

%X = [randn(40,20)+ones(40,20); randn(40,20)-ones(40,20)];
opts = statset('Display','iter');

    
[idx,ctrs] = kmeans(M,6,'Options',opts,'emptyaction','drop');

figure('Name','K-means Plot','NumberTitle','off')

plot(M(idx==1,1),M(idx==1,2),'r.','MarkerSize',12)
hold on
plot(M(idx==2,1),M(idx==2,2),'b.','MarkerSize',12)
plot(M(idx==3,1),M(idx==3,2),'g.','MarkerSize',12)
plot(M(idx==4,1),M(idx==4,2),'c.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx','MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko','MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','NorthEastOutside')
%%
result = 1;

end
