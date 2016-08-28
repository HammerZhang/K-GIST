% This script is used to fimilar with hash table in matlab
text = {'In computing, a hash table (also hash map) is a datastructure used' ...
    'to implement an associative array, a structure that can map keysto values.' ...
    'A hash table uses a hash function to compute an index into an array of buckets,'...
    'from which the correct value can be found.'};


word_cell = regexp(text,'\w+','match');         % ʹ��������ʽ�ָ��ַ���
word_ht = java.util.Hashtable;                  % ���ɹ�ϣ����

% ���������е�cell
for ii = 1:length(word_cell)
    lower_case = lower(word_cell{ii});          % ת��ΪСд�ַ�
    if word_ht.containsKey(lower_case)          % ���ؼ����Ƿ����
        word_ht.put(lower_case,word_h.get(lower_case)+1);          % ���浽��ϣ����
    else
        word_ht.put(lower_case,1);
    end
end

word_list = word_ht.keys;                        % ��ȡ�ؼ����б�

% ������е��ʼ����ִ���
while word_list.hasNext
    word = word_list.nextElement;                % ��ȡ��һ���ؼ���
    fprintf('%s : %d\n', word, word_ht.get(word));
end















        