function cluster_filter = DominantClusterFilter(oscil_matrix,dev)

cluster_filter = zeros(size(oscil_matrix));

%     for array = 1:2
%         X = reshape(oscil_matrix(:,:,array),[size(oscil_matrix(:,:,array),1)*size(oscil_matrix(:,:,array),2),1]);
%         eva = evalclusters(X,'kmeans','silhouette','KList',[1:4]);
%         k = eva.OptimalK;
%         ['Optimal Cluster ',num2str(k)]
%         [idx,C] = kmeans(X,k);
%         Y = unique(X(idx==mode(idx)));
%         for i = 1:numel(Y)
%             cluster_filter(:,:,array) = cluster_filter(:,:,array) + (oscil_matrix(:,:,array)== Y(i));
%         end
%     end

oscil_matrix_round = round(oscil_matrix);
for array = 1:2
    X = reshape(oscil_matrix_round(:,:,array),[size(oscil_matrix_round(:,:,array),1)*size(oscil_matrix_round(:,:,array),2),1]);
    X(X==0) = [];
    X(isnan(X)) = [];
    cluster_filter(:,:,array) = (oscil_matrix_round(:,:,array)<= mode(X)+dev).*...
        (oscil_matrix_round(:,:,array)>= mode(X)-dev);
end
end
