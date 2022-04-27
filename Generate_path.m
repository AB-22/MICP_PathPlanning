function V= Generate_path(T,centers)
% This function generate the required maze
for i=1:length(T)
V(:,:,i)=T(:,:,i)*get_cube([0;0;0], 1);
V(:,:,i)=V(:,:,i)+centers(:,:,i);
end

end