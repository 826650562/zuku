package com.clint.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clint.service.MapService;

import net.sf.json.JSONArray;
 

/**
 * @author might
 *
 */
@Controller
@RequestMapping(value = "/home")
public class homeController {

	@Resource(name = "mapService")
	private MapService mapService;
	
	
	/**
	 * @param req
	 * @param reponse
	 * @return
	 * 返回主页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest req,HttpServletResponse reponse) {
		return "pages/index";
	}
	
	@RequestMapping(value = "/indexTest")
	public String indexTest(HttpServletRequest req,HttpServletResponse reponse) {
		return "pages/indexTest";
	}
	
	
	/**
	 * @param req
	 * @param reponse
	 * @return
	 * 返回详情页面
	 */
	@RequestMapping(value = "/homedetail")
	public String homedetail(HttpServletRequest req,HttpServletResponse reponse,Model model) {
		String id=req.getParameter("id");
		if(id!=null){    
			String allContent =  "select * from T_ZUKU_DETAIL WHERE ID = '"+id+"'";
			List contentList = this.mapService.getListBySql(allContent);
			model.addAttribute("name", "liusha");
			model.addAttribute("contentList", contentList);
		}
		return "pages/homedetail";
	}
	
	/**
	 * @param req
	 * @param reponse
	 * @return
	 * 返回上传页面
	 */
	@RequestMapping(value = "/upload")
	public String upload(HttpServletRequest req,HttpServletResponse reponse) {
		return "pages/upload";
	}
	
 
	
	/*
	 * 通过id获取子分类
	 * */
	
	@RequestMapping(value = "/questTypeById")
	public void questTypeById(HttpServletRequest req,HttpServletResponse reponse) {
		String id=req.getParameter("_id");
		String parentId =  "select * from t_zuku_classify where PARENT_ID = '"+id+"'";
		 List parentIdList = this.mapService.getListBySql(parentId);
		    JSONArray json = JSONArray.fromObject(parentIdList);
		     try {
			  PrintWriter  pw =	reponse.getWriter();
			  pw.write(String.valueOf(json));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
	}
	
	/*
	 * 		将数据库里面获取的数据显示到前台
	 * */
	@RequestMapping(value = "/getContent")
	public void getContent(HttpServletRequest req,HttpServletResponse reponse) {
		String allContent =  "select * from T_ZUKU_DETAIL";
		 List contentList = this.mapService.getListBySql(allContent);
		    JSONArray json = JSONArray.fromObject(contentList);
		     try {
			  PrintWriter  pw =	reponse.getWriter();
			  pw.write(String.valueOf(json));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
	}
	
	
	/*
	 * 获取大类的子类 及子类的分类
	 * */
		
	@RequestMapping(value = "/questchildType")
	public void questchildType(HttpServletRequest req,HttpServletResponse reponse) {
		 String id=req.getParameter("_id");
		
		 String child=  "select * from t_zuku_classify where PARENT_ID = '"+id+"'";
		 List childList = this.mapService.getListBySql(child);    
		 
		 HashMap res=new HashMap();
		 
		 for(int i=0;i<childList.size();i++){
			 Map m=(Map)childList.get(i);
			 String cid=String.valueOf(m.get("ID"));
			 String childcsql=  "select * from t_zuku_classify where PARENT_ID = '"+cid+"'";
			 List childcList = this.mapService.getListBySql(childcsql);
			 res.put(cid, childcList);
		 }
		 
	   //	 建筑  8个子类     再把这个8个子类的  各个子类拿到
		 
		 List resList=new ArrayList();
		 
		 resList.add(childList);
		 resList.add(res);
	 
		  JSONArray json = JSONArray.fromObject(resList);
		     try {
			  PrintWriter  pw =	reponse.getWriter();
			  pw.write(String.valueOf(json));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
	}
	 
	
	
	
	
 
}
 