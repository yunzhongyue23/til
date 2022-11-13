```java
package com.gentle.easyexcel;  
  
import com.alibaba.excel.EasyExcel;  
import com.alibaba.excel.context.AnalysisContext;  
import com.alibaba.excel.event.AnalysisEventListener;  
import com.alibaba.excel.support.ExcelTypeEnum;  
import com.gentle.easyexcel.entity.ExcelData;  
  
import java.util.*;  
import java.util.stream.Collectors;  
  
public class ExcelTest {  
    public static void main(String[] args) {  
        List<ExcelData> list = parseData();  
//        EasyExcel.write("C:\\Users\\zhao\\Desktop\\一次性经济补助统计表__副本.xlsx")  
//                .head(ExcelData.class)  
//                .excelType(ExcelTypeEnum.XLSX)  
//                .sheet("一次性经济补助")  
//                .doWrite(list);  
//        for (ExcelData data : list) {  
//            System.out.println(data);  
//        }  
        Map<String, List<ExcelData>> groupBy = list.stream().collect(Collectors.groupingBy(ExcelData::getIdCard));  
        ArrayList<Map<String, List<ExcelData>>> maps = new ArrayList<>();  
        maps.add(groupBy);  
  
  
  
  
    }  
  
    public static List<ExcelData> parseData() {  
        final List<ExcelData> list = new LinkedList<>();  
//        EasyExcel.read("C:\\Users\\zhao\\Desktop\\111.xlsx")  
        EasyExcel.read("C:\\Users\\zhao\\Desktop\\一次性经济补助统计表-模板.xlsx")  
  
//                .sheet("一次性经济补助")  
                .sheet()  
                .headRowNumber(2)  
                .head(ExcelData.class)  
                .registerReadListener(new AnalysisEventListener<ExcelData>() {  
                    @Override  
                    public void invoke(ExcelData excelData, AnalysisContext analysisContext) {  
                        list.add(excelData);  
                    }  
  
                    @Override  
                    public void doAfterAllAnalysed(AnalysisContext analysisContext) {  
                        System.out.println("数据读取完毕");  
                    }  
                }).doRead();  
            return list;  
    }  
  
    public static List<ExcelData> parseData2() {  
        final List<ExcelData> list = new LinkedList<>();  
//        EasyExcel.read("C:\\Users\\zhao\\Desktop\\111.xlsx")  
        EasyExcel.read("C:\\Users\\zhao\\Desktop\\一次性经济补助统计表-模板.xlsx")  
  
//                .sheet("一次性经济补助")  
                .sheet()  
                .headRowNumber(2)  
                .head(ExcelData.class)  
                .registerReadListener(new AnalysisEventListener<ExcelData>() {  
                    @Override  
                    public void invoke(ExcelData excelData, AnalysisContext analysisContext) {  
                        list.add(excelData);  
                    }  
  
                    @Override  
                    public void doAfterAllAnalysed(AnalysisContext analysisContext) {  
                        System.out.println("数据读取完毕");  
                    }  
                }).doRead();  
        return list;  
    }  
  
  
}
```


```java
package com.gentle.easyexcel;  
  
import com.alibaba.excel.EasyExcel;  
import com.alibaba.excel.ExcelReader;  
import com.alibaba.excel.context.AnalysisContext;  
import com.alibaba.excel.event.AnalysisEventListener;  
import com.alibaba.excel.read.builder.ExcelReaderBuilder;  
import com.alibaba.excel.support.ExcelTypeEnum;  
  
import java.util.Iterator;  
import java.util.Map;  
import java.util.Set;  
  
public class Test {  
    public static void main(String[] args) {  
        ExcelReaderBuilder readerBuilder = EasyExcel.read();  
        readerBuilder.file("C:\\Users\\zhao\\Desktop\\一次性经济补助统计表-模板.xlsx");  
        readerBuilder.sheet("一次性经济补助");  
        readerBuilder.autoCloseStream(true);  
        readerBuilder.excelType(ExcelTypeEnum.XLSX);  
        readerBuilder.registerReadListener(new AnalysisEventListener<Map<Integer, String>>() {  
            @Override  
            public void invoke(Map<Integer, String> integerStringMap, AnalysisContext analysisContext) {  
                Set<Integer> keySet = integerStringMap.keySet();  
                Iterator<Integer> iterator = keySet.iterator();  
                while (iterator.hasNext()) {  
                    Integer key = iterator.next();  
                    System.out.print(key + ":" + integerStringMap.get(key)+",");  
                }  
                System.out.println("");  
            }  
  
            @Override  
            public void doAfterAllAnalysed(AnalysisContext analysisContext) {  
                System.out.println("数据读取完毕");  
            }  
        });  
  
        ExcelReader reader = readerBuilder.build();  
        reader.readAll();  
        reader.finish();  
  
    }  
}
```