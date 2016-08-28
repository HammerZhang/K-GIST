% ͼƬ�б�
img_path = 'PicDataSet\\';
% ���ļ��ж�ȡͼƬ�б�
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

% ����Gist����
clear param;
param.orientationsPerScale = [8, 8, 8, 8]; % number of orientations per scale (from HF to LF);
param.numberBlocks = 4;
param.fc_prefilt = 4;

% ����Gist
for ii = 1:length(img_list)
    % ��ȡͼƬ
    filename = strcat(img_list{ii},'.jpg');
    img = imread(strcat(img_path,filename));
    % ����Gist
    [Gist(ii,:), param] = LMgist(img,'',param);
    [B(ii,:),R] = ITQ(Gist(ii,:),50);                 % ��ֵ��
end

fprintf('press any key to continue...\n');
pause;


% �ָ��ֵ�ַ���
m = 8;                                     % ÿ�����ַ����ָ��8�����ַ���
substr_len = size(B,2)/m;                  % ÿ�����ַ����ĳ���
algs={'MD2','MD5','SHA-1','SHA-256','SHA-384','SHA-512'};                     % ��ѡ��ϣ�����㷨����ϣ����ʹ��

% ����m����ϣ������Ԫ��
for mi = 1:m
    str_ht(mi) = java.util.Hashtable;       % ����һ���µĹ�ϣ��
    for ii = 1:length(img_list)
        substr_cell{ii,mi} = B(ii,(mi-1)*substr_len+1:mi*substr_len);
        %substr_hcode{ii,mi} = hash(substr_cell{mi},algs{1});                    % �˴�ʹ��MD2�㷨��Ϊʾ��,���Ը���
        
        % �����Ӵ��������ϣ��
        if str_ht(mi).containsKey(substr_cell{ii,mi})
            str_ht(mi).put(substr_cell{ii,mi},str_ht(mi).get(substr_cell{ii,mi})+1);
        else
            str_ht(mi).put(substr_cell{ii,mi},1);
        end
        
    end
    hcode_list(mi) = str_ht(mi).keys;
end


% ��������ͼƬ
test_img = imread('test_target.jpg');
[Gist_test, param_test] = LMgist(test_img,'',param);
[B_test,R_test] = ITQ(Gist(ii,:),50);

% ���庺������Ϊr
r = 32; count = zeros(1,8);
for mi = 1:m
    tar_substr = B_test(1,(mi-1)*substr_len+1:mi*substr_len);
    while hcode_list(mi).hasNext
        substr = hcode_list(mi).nextElement;
        Dh = hammingDist(tar_substr,substr');
        
        % �ж��Ƿ�����Dh < r/m
        if Dh < r/m
            count(1,mi) = count(1,mi) + 1;
        end
    end
end
    












