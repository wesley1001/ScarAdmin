package com.zero2ipo.eeh.course.web;

import com.zero2ipo.common.web.BaseCtrl;
import com.zero2ipo.eeh.classroom.bizc.IClassRoomService;
import com.zero2ipo.eeh.classroom.bo.ClassRoomBo;
import com.zero2ipo.eeh.course.bizc.ICourseService;
import com.zero2ipo.eeh.course.bo.CourseBo;
import com.zero2ipo.eeh.subject.bizc.ISubjectService;
import com.zero2ipo.eeh.subject.bo.SubjectBo;
import com.zero2ipo.eeh.teacher.bizc.ITeacherService;
import com.zero2ipo.eeh.teacher.bo.TeacherBo;
import com.zero2ipo.eeh.time.bizc.ITimeService;
import com.zero2ipo.eeh.time.bo.TimeBo;
import com.zero2ipo.framework.exception.BaseException;
import com.zero2ipo.framework.log.BaseLog;
import com.zero2ipo.framework.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 教学楼ctrl
 * Created by Administrator on 2016/2/24.
 */
@Controller
@RequestMapping("/Course")
public class CourseCtrl extends BaseCtrl {
    @Autowired
    @Qualifier("CourseService")
    private ICourseService CourseService ;
    @Autowired
    @Qualifier("SubjectService")
    private ISubjectService SubjectService;
    @Autowired
    @Qualifier("teacherService")
    private ITeacherService teacherService;
    @Autowired
    @Qualifier("TimeService")
    private ITimeService TimeService;
    @Autowired
    @Qualifier("classRoomService")
    private IClassRoomService classRoomService;
    /**
     * 初始化页面
     * @return
     */
    @RequestMapping("forInit.shtml")
    public ModelAndView forInitPage() {
        ModelAndView mv = new ModelAndView("/eeh/Course/list.jsp");
        return mv;
    }
    /**
     * 初始化json数据
     * @param curNo
     * @param curSize
     * @return
     */
    @RequestMapping("findAllList.shtml")
    @ResponseBody
    public Map<String,Object> findAllList(String curNo, String curSize){
        Map<String,Object> jsonMap = new HashMap<String, Object>();
        try {
            /************* 分页处理 ************/
            int skip;
            int max;
            if (StringUtil.isNullOrEmpty(curNo))
                curNo = "0";
            if (StringUtil.isNullOrEmpty(curSize))
                curSize = "20";
            skip = Integer.parseInt(curNo);
            max = Integer.parseInt(curSize);
            /************  分页处理结束 ***********/
            Map<String, Object> map = new HashMap<String, Object>();

            int total=0;
            total=CourseService.getTotal(map);
            List<CourseBo> list= null;
            if(total>0){
                list = CourseService.findAllList(map, (skip-1)*max, max);
            }
            jsonMap.put("Rows", list);
            jsonMap.put("Total", total);
        } catch (Exception e) {
            BaseLog.e(this.getClass(), "forLinkTypeinitAjax.shtml:管理人分类信息初始化有误", e);
        }
        return jsonMap;
    }
 /******************************************新增*********************************************************/
    /**
     * 新增页面初始化
     * @return
     */
    @RequestMapping("forAddInitPage.shtml")
    public ModelAndView forAddInitPage() {
        ModelAndView mv = new ModelAndView("/eeh/Course/add.jsp");
        //查询所有科目
        getSelectList(mv);
        return mv;
    }
    /**
     * 添加保存数据
     * @param bo
     * @return
     */
    @RequestMapping("forAddAjax.shtml")
    @ResponseBody
    public Map<String,Object> addSave(CourseBo bo) {
        Map<String,Object> result=new HashMap<String,Object>();
        boolean flg=false;
        try {
            flg=CourseService.add(bo);
        } catch (Exception e) {
            flg=false;
            e.printStackTrace();
            BaseLog.e(this.getClass(), "saveOrder", e);
            throw new BaseException("saveOrder 异常！");
        }
        result.put("success", flg);
        return result;
    }
    /******************************************修改*********************************************************/
    /**
     * 新增页面初始化
     * @return
     */
    @RequestMapping("forUpdateInitPage.shtml")
    public ModelAndView forUpdateInitPage(String id) {
        ModelAndView mv = new ModelAndView("/eeh/Course/update.jsp");
        CourseBo bo=CourseService.findById(id);
        mv.addObject("bo",bo);
        getSelectList(mv);

        return mv;
    }

    /**
     * 获取下来列表的值
     * @param mv
     */
    private void getSelectList(ModelAndView mv) {
        //查询所有科目
        Map<String,Object> queryMap=new HashMap<String, Object>();
        List<SubjectBo> subjectList=SubjectService.findAllList(queryMap);
        if(!StringUtil.isNullOrEmpty(subjectList)&&subjectList.size()>0){
            mv.addObject("subjectList",subjectList);
        }
        //查询所有授课老师
        List<TeacherBo> teacherList=teacherService.findAllList(queryMap);
        if(!StringUtil.isNullOrEmpty(teacherList)&&teacherList.size()>0){
            mv.addObject("teacherList",teacherList);
        }
        //查询所有时段
        List<TimeBo> timeList=TimeService.findAllList(queryMap);
        if(!StringUtil.isNullOrEmpty(timeList)&&timeList.size()>0){
            mv.addObject("timeList",timeList);
        }
        //查询所有教室
        List<ClassRoomBo> classRoomList=classRoomService.findAllList(queryMap);
        if(!StringUtil.isNullOrEmpty(classRoomList)&&classRoomList.size()>0){
            mv.addObject("classRoomList",classRoomList);
        }
    }

    /**
     * 修改保存数据
     * @param bo
     * @return
     */
    @RequestMapping("forUpdateAjax.shtml")
    @ResponseBody
    public Map<String,Object> updateSave(CourseBo bo) {
        Map<String,Object> result=new HashMap<String,Object>();
        boolean flg=false;
        try {
            flg=CourseService.update(bo);
        } catch (Exception e) {
            flg=false;
            e.printStackTrace();
            BaseLog.e(this.getClass(), "forUpdateAjax", e);
            throw new BaseException("forUpdateAjax 异常！");
        }
        result.put("success", flg);
        return result;
    }
    /******************************************删除操作*********************************************************/

    @RequestMapping("delSave.shtml")
    @ResponseBody
    public Map<String,Object> delSave(String ids) {
        Map<String,Object> result=new HashMap<String,Object>();
        boolean flg=false;
        try {
            flg=CourseService.delete(ids);
        } catch (Exception e) {
            flg=false;
            e.printStackTrace();
            BaseLog.e(this.getClass(), "delSave", e);
            throw new BaseException("delSave 异常！");
        }
        result.put("success", flg);
        return result;
    }
}
