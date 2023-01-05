package com.example.demoexcel.vo;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@EqualsAndHashCode
public class ComplexHeadData {
    @ExcelProperty({"主标题", "字符串标题"})
    private String string;
    @ExcelProperty({"主标题", "日期标题"})
    private Date date;
    @ExcelProperty({"主标题", "数字标题"})
    private Double doubleData;
   /* @ExcelProperty({"主标题", "次标题1","字符串标题"})
    private String string;
    @ExcelProperty({"主标题","次标题1", "日期标题"})
    private Date date;
    @ExcelProperty({"主标题", "次标题2","数字标题"})
    private Double doubleData;*/
}