function distances = distanceEdgeToCentroid(bwImage,centroid)
    [row,col] = size(bwImage);
    count = 1;
    for i = 1:row
        for j= 1:col           
            if bwImage(i,j) == 1
                distances(count) = hypot(i-centroid(2),j-centroid(1));
                count = count+1;
            end
        end
    end
   distances = distances/median(distances);
end