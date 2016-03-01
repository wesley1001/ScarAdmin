package com.zero2ipo.plugins.excel;

import com.zero2ipo.common.web.BaseCtrl;
import com.zero2ipo.eeh.student.bizc.IStudentService;
import com.zero2ipo.eeh.student.bo.StudentBo;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/excelOperate")
public class ExcelOperate extends BaseCtrl {
    @Autowired
    @Qualifier("studentService")
    private IStudentService studentService;
    public static void main(String[] args) throws Exception {
       /* File file = new File("ExcelDemo.xls");
        String[][] result = getData(file, 1);
        int rowLength = result.length;
        for(int i=0;i<rowLength;i++) {
            for(int j=0;j<result[i].length;j++) {
                System.out.print(result[i][j]+"\t\t");
            }
            System.out.println();
        }*/

    }
    @RequestMapping("/readexcel.shtml")
    @ResponseBody
    public Map<String,Object> readexcel(String path,String classId){
        ImportExecl poi = new ImportExecl();
        // List<List<String>> list = poi.read("d:/aaa.xls");
        String filepath=session.getServletContext().getRealPath("/");
        path=path.replaceAll("\r\n","");
        filepath=filepath+path;
        filepath=filepath.replaceAll("\\\\","/");
        List<List<String>> list = poi.read(filepath);
        if (list != null)
        {
            for (int i = 1; i < list.size(); i++)
            {
                //System.out.print("第" + (i) + "行");
                //List<String> cellList = list.get(i);
                //for (int j = 0; j < cellList.size(); j++)
               // {
                    // System.out.print("    第" + (j + 1) + "列值：");
                   // System.out.print("    " + cellList.get(j));
                    StudentBo studentBo=new StudentBo();
                    String  banji=list.get(i).get(0).replace(".0","");//班级
                    String xuehao=list.get(i).get(1).replace(".0","");//学号
                    String name=list.get(i).get(2);//姓名
                    studentBo.setName(name);
                    studentBo.setClassId(banji);
                    studentBo.setXhnum(xuehao);
                    studentBo.setGradeId(banji.substring(0,1));
                    if(classId.equals(banji)){
                        System.out.print("banji="+banji);
                        System.out.print("xuehao="+xuehao);
                        System.out.print("name="+name+"\n");
                        studentService.add(studentBo);
                    }
                   // studentService.add(studentBo);

               // }
                System.out.println();
            }
        }
        Map<String,Object> resultMap=new HashMap<String, Object>();
        return resultMap;
    }
    /**
     * 读取Excel的内容，第一维数组存储的是一行中格列的值，二维数组存储的是多少个行
     * @return 读出的Excel中数据的内容
     * @throws FileNotFoundException
     * @throws IOException
     */


    public Map<String,Object> getData(String path)
             {
         int ignoreRows=1;
        String filepath=session.getServletContext().getRealPath("/");
               path=path.replaceAll("\r\n","");
               filepath=filepath+path;
               filepath=filepath.replaceAll("\\\\","/");
        File file = new File(filepath);
        List<String[]> result = new ArrayList<String[]>();
        int rowSize = 0;
        try{
            BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
            // 打开HSSFWorkbook
            POIFSFileSystem fs = new POIFSFileSystem(in);
            XSSFWorkbook wb = new XSSFWorkbook(String.valueOf(fs));
            XSSFCell cell = null;
            for (int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
                XSSFSheet st = wb.getSheetAt(sheetIndex);
                // 第一行为标题，不取
                for (int rowIndex = ignoreRows; rowIndex <= st.getLastRowNum(); rowIndex++) {
                    XSSFRow row = st.getRow(rowIndex);
                    if (row == null) {
                        continue;
                    }
                    int tempRowSize = row.getLastCellNum() + 1;
                    if (tempRowSize > rowSize) {
                        rowSize = tempRowSize;
                    }
                    String[] values = new String[rowSize];
                    Arrays.fill(values, "");
                    boolean hasValue = false;
                    for (short columnIndex = 0; columnIndex <= row.getLastCellNum(); columnIndex++) {
                        String value = "";
                        cell = row.getCell(columnIndex);
                        if (cell != null) {
                            // 注意：一定要设成这个，否则可能会出现乱码
                            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);
                            switch (cell.getCellType()) {
                                case XSSFCell.CELL_TYPE_STRING:
                                    value = cell.getStringCellValue();
                                    break;
                                case XSSFCell.CELL_TYPE_NUMERIC:
                                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                                        Date date = cell.getDateCellValue();
                                        if (date != null) {
                                            value = new SimpleDateFormat("yyyy-MM-dd")
                                                    .format(date);
                                        } else {
                                            value = "";
                                        }
                                    } else {
                                        value = new DecimalFormat("0").format(cell
                                                .getNumericCellValue());
                                    }
                                    break;
                                case XSSFCell.CELL_TYPE_FORMULA:
                                    // 导入时如果为公式生成的数据则无值
                                    if (!cell.getStringCellValue().equals("")) {
                                        value = cell.getStringCellValue();
                                    } else {
                                        value = cell.getNumericCellValue() + "";
                                    }
                                    break;
                                case XSSFCell.CELL_TYPE_BLANK:
                                    break;
                                case XSSFCell.CELL_TYPE_ERROR:
                                    value = "";
                                    break;
                                case XSSFCell.CELL_TYPE_BOOLEAN:
                                    value = (cell.getBooleanCellValue() == true ? "Y"
                                            : "N");
                                    break;
                                default:
                                    value = "";
                            }
                        }
                        if (columnIndex == 0 && value.trim().equals("")) {
                            break;
                        }
                        values[columnIndex] = rightTrim(value);
                        hasValue = true;
                    }
                    if (hasValue) {
                        result.add(values);
                    }
                }
            }
            in.close();
            String[][] returnArray = new String[result.size()][rowSize];
            for (int i = 0; i < returnArray.length; i++) {
                returnArray[i] = (String[]) result.get(i);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,Object> resultMap=new HashMap<String, Object>();
        return resultMap;
    }
    /**

     * 去掉字符串右边的空格
     * @param str 要处理的字符串
     * @return 处理后的字符串
     */

    public static String rightTrim(String str) {

        if (str == null) {
            return "";
        }
        int length = str.length();
        for (int i = length - 1; i >= 0; i--) {
            if (str.charAt(i) != 0x20) {
                break;
            }
            length--;
        }
        return str.substring(0, length);
    }

}

