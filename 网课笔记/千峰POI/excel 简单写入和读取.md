写入
```java
package write;  
  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.ss.usermodel.Cell;  
import org.apache.poi.ss.usermodel.Row;  
import org.apache.poi.ss.usermodel.Sheet;  
import org.apache.poi.ss.usermodel.Workbook;  
import org.apache.poi.xssf.streaming.SXSSFWorkbook;  
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  
  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.OutputStream;  
  
public class ExcelWriteDemo {  
    public static void main(String[] args) throws Exception {  
//        new ExcelWriteDemo().writeExcel03();  
//        new ExcelWriteDemo().writeExcel07();  
//        new ExcelWriteDemo().batchWrite03();  
//        new ExcelWriteDemo().batchWrite07();  
        new ExcelWriteDemo().bigDataWrite07();  
    }  
    public void writeExcel03() throws  Exception {  
        Workbook workbook = new HSSFWorkbook();  
        Sheet sheet = workbook.createSheet("03版本测试");  
        Row row1 = sheet.createRow(0);  
        Cell row1Cell1 = row1.createCell(0);  
        Cell row1Cell2 = row1.createCell(1);  
        row1Cell1.setCellValue("商品id");  
        row1Cell2.setCellValue("商品名称");  
  
        Row row2 = sheet.createRow(1);  
        Cell row2Cell1 = row2.createCell(0);  
        Cell row2Cell2 = row2.createCell(1);  
        row2Cell1.setCellValue("1");  
        row2Cell2.setCellValue("小新");  
  
        OutputStream outputStream = new FileOutputStream("./03测试.xls");  
        workbook.write(outputStream);  
        outputStream.close();  
        System.out.println("表格生成完成");  
    }  
    public void writeExcel07() throws  Exception {  
        Workbook workbook = new XSSFWorkbook();  
        Sheet sheet = workbook.createSheet("07版本测试");  
        Row row1 = sheet.createRow(0);  
        Cell row1Cell1 = row1.createCell(0);  
        Cell row1Cell2 = row1.createCell(1);  
        row1Cell1.setCellValue("商品id");  
        row1Cell2.setCellValue("商品名称");  
  
        Row row2 = sheet.createRow(1);  
        Cell row2Cell1 = row2.createCell(0);  
        Cell row2Cell2 = row2.createCell(1);  
        row2Cell1.setCellValue("1");  
        row2Cell2.setCellValue("小新");  
  
        OutputStream outputStream = new FileOutputStream("./07测试.xlsx");  
        workbook.write(outputStream);  
        outputStream.close();  
        System.out.println("表格生成完成");  
    }  
    public void batchWrite03() throws Exception{  
        Workbook workbook = new HSSFWorkbook();  
        Sheet sheet = workbook.createSheet("03批量测试");  
        long start = System.currentTimeMillis();  
        for (int rowNum = 0; rowNum < 65536; rowNum++) {  
            Row row = sheet.createRow(rowNum);  
            for (int cellNum = 0; cellNum < 20; cellNum++) {  
                Cell cell = row.createCell(cellNum);  
                cell.setCellValue(rowNum+1);  
            }  
        }  
        FileOutputStream fileOutputStream = new FileOutputStream("03batch.xls");  
        workbook.write(fileOutputStream);  
        fileOutputStream.close();  
        long end = System.currentTimeMillis();  
        System.out.println(end-start);  
    }  
    public void batchWrite07() throws Exception{  
        Workbook workbook = new XSSFWorkbook();  
        Sheet sheet = workbook.createSheet("07批量测试");  
        long start = System.currentTimeMillis();  
        for (int rowNum = 0; rowNum < 65536; rowNum++) {  
            Row row = sheet.createRow(rowNum);  
            for (int cellNum = 0; cellNum < 20; cellNum++) {  
                Cell cell = row.createCell(cellNum);  
                cell.setCellValue(rowNum+1);  
            }  
        }  
        FileOutputStream fileOutputStream = new FileOutputStream("07batch.xlsx");  
        workbook.write(fileOutputStream);  
        fileOutputStream.close();  
        long end = System.currentTimeMillis();  
        System.out.println(end-start);  
    }  
    public void bigDataWrite07() throws Exception{  
        Workbook workbook = new SXSSFWorkbook();  
        Sheet sheet = workbook.createSheet("07大数据测试");  
        long start = System.currentTimeMillis();  
        for (int rowNum = 0; rowNum < 65536; rowNum++) {  
            Row row = sheet.createRow(rowNum);  
            for (int cellNum = 0; cellNum < 20; cellNum++) {  
                Cell cell = row.createCell(cellNum);  
                cell.setCellValue(rowNum+1);  
            }  
        }  
        FileOutputStream fileOutputStream = new FileOutputStream("07bigData.xlsx");  
        workbook.write(fileOutputStream);  
        fileOutputStream.close();  
        long end = System.currentTimeMillis();  
        System.out.println(end-start);  
    }  
}
```