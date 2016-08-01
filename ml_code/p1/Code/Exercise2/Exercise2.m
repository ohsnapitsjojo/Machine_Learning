function Exercise2(Image)
%%
DirectoryName = strcat(pwd,'\\George_W_Bush');

%p cannot be modified from the outside,since LearnModelParameters has no
%input for p ,therefore I extended it with p parameter 
p= 0.2;
n = 20;
[mu_s,Sigma_s] = LearnModelParameters(DirectoryName,n,p);
im = imread(Image);
LikValues_s = EvaluateLikelihood(im, mu_s,Sigma_s);
%%
DirectoryName = strcat(pwd,'\\BackgroundImages');
n = 22;
p=1;
[mu_b,Sigma_b] = LearnModelParameters(DirectoryName,n,p);
im = imread(Image);
LikValues_b = EvaluateLikelihood(im, mu_b,Sigma_b);

%%

ratioTest = LikValues_s./LikValues_b;
ratioTest(ratioTest < 1) = 0;
ratioTest(ratioTest >= 1) = 1;
%%
figure
imshow(LikValues_s/max(max(LikValues_s)))
figure
imshow(LikValues_b/max(max(LikValues_b)))
figure
imshow(ratioTest);

%%
[bound_X bound_Y] = FindBiggestComp(ratioTest);
figure
imshow(im);
hold on

corner_1 = [bound_X(1);bound_Y(1)];  %upper left
corner_2 = [bound_X(3);bound_Y(1)];  %upper right
corner_3 = [bound_X(2);bound_Y(3)];  %lower left
corner_4 = [bound_X(4);bound_Y(3)];  % lower right

line([corner_1(1);corner_3(1)],[corner_1(2);corner_3(2)],'LineWidth',2);
line([corner_1(1);corner_2(1)],[corner_1(2);corner_2(2)],'LineWidth',2);
line([corner_3(1);corner_4(1)],[corner_3(2);corner_4(2)],'LineWidth',2);
line([corner_2(1);corner_4(1)],[corner_2(2);corner_4(2)],'LineWidth',2);

end
