% This script is used to fimilar with hash table in matlab
text = {'In computing, a hash table (also hash map) is a datastructure used' ...
    'to implement an associative array, a structure that can map keysto values.' ...
    'A hash table uses a hash function to compute an index into an array of buckets,'...
    'from which the correct value can be found.'};


word_cell = regexp(text,'\w+','match');         % 使用正则表达式分割字符串
word_ht = java.util.Hashtable;                  % 生成哈希对象

% 遍历单词中的cell
for ii = 1:length(word_cell)
    lower_case = lower(word_cell{ii});          % 转换为小写字符
    if word_ht.containsKey(lower_case)          % 检查关键字是否存在
        word_ht.put(lower_case,word_h.get(lower_case)+1);          % 保存到哈希表中
    else
        word_ht.put(lower_case,1);
    end
end

word_list = word_ht.keys;                        % 获取关键字列表

% 输出所有单词及出现次数
while word_list.hasNext
    word = word_list.nextElement;                % 获取下一个关键字
    fprintf('%s : %d\n', word, word_ht.get(word));
end















        