% 图片列表
img_path = 'PicDataSet\\';
% 从文件中读取图片列表
fid = fopen('jpg_list.txt');

ti = 1;
img_list{ti} = fgetl(fid);
while ischar(img_list{ti})
    ti = ti + 1;
    img_list{ti} = fgetl(fid);
end
fclose(fid);

img_list = img_list(1:length(img_list)-1);

fprintf('read list finished, press any key to continue...\n');
pause;

% 设置Gist参数
clear param;
param.orientationsPerScale = [8, 8, 8, 8]; % number of orientations per scale (from HF to LF);
param.numberBlocks = 4;
param.fc_prefilt = 4;

% 计算Gist
for ii = 1:length(img_list)
    % 读取图片
    filename = strcat(img_list{ii},'.jpg');
    img = imread(strcat(img_path,filename));
    % 计算Gist
    [Gist(ii,:), param] = LMgist(img,'',param);
    [B(ii,:),R] = ITQ(Gist(ii,:),50);                 % 二值化
end

fprintf('press any key to continue...\n');
pause;


% 分割二值字符串
m = 8;                                     % 每个长字符串分割成8个子字符串
substr_len = size(B,2)/m;                  % 每个子字符串的长度
algs={'MD2','MD5','SHA-1','SHA-256','SHA-384','SHA-512'};                     % 可选哈希函数算法，哈希函数使用

% 创建m个哈希表，插入元素
for mi = 1:m
    str_ht(mi) = java.util.Hashtable;       % 创建一个新的哈希表
    for ii = 1:length(img_list)
        substr_cell{ii,mi} = B(ii,(mi-1)*substr_len+1:mi*substr_len);
        %substr_hcode{ii,mi} = hash(substr_cell{mi},algs{1});                    % 此处使用MD2算法做为示例,可以更改
        
        % 遍历子串，插入哈希表
        if str_ht(mi).containsKey(substr_cell{ii,mi})
            str_ht(mi).put(substr_cell{ii,mi},str_ht(mi).get(substr_cell{ii,mi})+1);
        else
            str_ht(mi).put(substr_cell{ii,mi},1);
        end
        
    end
    hcode_list(mi) = str_ht(mi).keys;
end


% 检索相似图片
test_img = imread('test_target.jpg');
[Gist_test, param_test] = LMgist(test_img,'',param);
[B_test,R_test] = ITQ(Gist(ii,:),50);

% 定义汉明距离为r
r = 32; count = zeros(1,8);
for mi = 1:m
    tar_substr = B_test(1,(mi-1)*substr_len+1:mi*substr_len);
    while hcode_list(mi).hasNext
        substr = hcode_list(mi).nextElement;
        Dh = hammingDist(tar_substr,substr');
        
        % 判断是否满足Dh < r/m
        if Dh < r/m
            count(1,mi) = count(1,mi) + 1;
        end
    end
end
    












