![[oracle索引结构图.png]]
索引是由Root（根块）、Branch（茎块）和Leaf（叶子块）三部分组成的，其中Leaf（叶子块）主要存储了key column value（索引列具体值），以及能具体定位到数据块所在位置的rowid（注意区分索引块和数据块）