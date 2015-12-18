function [BBOX] = Face_Detection(image)

if(ndims(image)~=3)
error('image must be a RGB image');
end

image=double(image);
nx=size(image);
% for RGB model
imagex=zeros(nx(1),nx(2));
for i=1:nx(1)
  for j=1:nx(2)
   if((image(i,j,1)>95 &image(i,j,2)>40 & image(i,j,3)>20) &((max([image(i,j,1),image(i,j,2),image(i,j,3)])-min([image(i,j,1),image(i,j,2),image(i,j,3)]))>15)&(norm(image(i,j,1)-image(i,j,2))>15)&(image(i,j,1)>image(i,j,2))&(image(i,j,1)>image(i,j,3)))
   % for doing normalization of The RGB Model
     r=(image(i,j,1)/(image(i,j,1)+image(i,j,2)+image(i,j,3)));
     g=(image(i,j,2)/(image(i,j,1)+image(i,j,2)+image(i,j,3)));
	   if(r>=.36 & r<=0.465 & g>=0.28 & g<=0.363)
	     imagex(i,j)=1;
	   end
    end
   end
end


se = strel('disk',5);
imagex=imerode(imagex,se);
se = strel('disk',4);
imagex=imdilate(imagex,se);
imagex=imfill(imagex);
[r,c]=find(imagex==1);

BBox(1,1)=min(c);
BBox(1,2)=min(r);
BBox(1,3)=max(c)-min(c);
BBox(1,4)=max(r)-min(r);


hold on
imshow(uint8(image));
rectangle('Position',[BBox],'LineWidth',1, 'EdgeColor','r');




end