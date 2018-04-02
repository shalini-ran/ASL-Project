function counts = features_hocd(bwmask)
[edgeMap,Centroid] = findEdgeMapCentroid(bwmask);
distances = distanceEdgeToCentroid(edgeMap,Centroid);
[counts,~] = hist(distances,50);
counts = counts/norm(distances);
%figure; bar(centers,counts);
end
