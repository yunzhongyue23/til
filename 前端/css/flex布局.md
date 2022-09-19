flex中的两个概念,轴和容器,从轴的方面来说,分为主轴和侧轴,从容器方面来说,分为父容器和子容器.
## 父容器的属性
display:flex,声明设置为flex布局
justify-content:flex-start,主轴首段对齐
	                            flex-end,主轴尾段对齐
	                            center,中间对齐
	                            space-round,环绕对齐每个元素周围分配相同的空间
	                            space-between,两个元素之间的间隔相等

align-item: flex-start,主轴首段对齐
	                     flex-end,主轴尾段对齐
	                     center,中间对齐
	                     stretch,拉伸

item-content:flex-start,主轴首段对齐
	                            flex-end,主轴尾段对齐
	                            center,中间对齐
	                            space-round,环绕对齐每个元素周围分配相同的空间
	                            space-between,两个元素之间的间隔相等

flex-wrap :wrap   允许换行
						nowrap  不允许换行
					   flex-wrap : wrap-reverse  	// 允许逆向换行 
flex:  1   按比例均分剩余的体积
