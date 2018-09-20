package com.clint.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.clint.service.MapService;

import net.sf.json.JSONArray;

/**
 * @author might
 *
 */
@Controller
@RequestMapping(value = "/myUpload")
public class uploadController {

	@Resource(name = "mapService")
	private MapService mapService;
	
	
	 
	/**
	 * @param uploadFile
	 * @param session
	 * @return
	 * @throws IOException
	 * 上传构件文件
	 */
	@RequestMapping(value = "/uploadRFAfile")
	public String uploadRFAfile(@RequestParam("file") MultipartFile uploadFile, HttpSession session) throws IOException {
		if (uploadFile.getSize() > 0) {   
			String filename = uploadFile.getOriginalFilename();
			if (filename.endsWith("rfa")) {
				String leftPath = session.getServletContext().getRealPath("/rfa");
				File file = new File(leftPath, filename);
				System.out.println(file.getParentFile());
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}
				uploadFile.transferTo(file);
			}
		} else {
			return "error";
		}
		return "uploadSuccess";
	}
	
	/**
	 * @param uploadFile
	 * @param session
	 * @return
	 * @throws IllegalStateException 
	 * @throws IOException
	 * 上传构件缩略图
	 */
	@RequestMapping(value = "/uploadIMGfile")
	public String uploadMult(HttpServletRequest request, HttpSession session,HttpServletResponse reponse) throws IllegalStateException, IOException {
        // 转型为MultipartHttpRequest：   
       MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;   
       // 获得文件：   
       
       List<MultipartFile> files = new ArrayList<MultipartFile>();
       
       List<MultipartFile> files1 = multipartRequest.getFiles("imgfile");
       List<MultipartFile> files2 = multipartRequest.getFiles("rfafile");
       
       MultipartFile f1=files1.get(0);
       MultipartFile f2=files2.get(0);
       
       if(f1 !=null){
    	   files.add(f1);  
       }
       
       if(f2 !=null){
    	   files.add(f2);  
       }
      
       if (files.isEmpty()) {
           return "false";
       }
       
	   String leftPath="";
	   String temperimgpath = "";
	   String temperrfapath = "";
	   String temperimgname = "";
	   String temperrfaname = "";
	   

       for (MultipartFile file : files) {
           String fileName = file.getOriginalFilename();
           
            if (fileName.endsWith("jpg")|| fileName.endsWith("png")) {
				 leftPath = session.getServletContext().getRealPath("/rfa-img");
				 temperimgpath =leftPath;  //路径
				 temperimgname = fileName; //名称
				 
			}
			if(fileName.endsWith("rfa")){
				 leftPath = session.getServletContext().getRealPath("/rfa");
				 temperrfapath = leftPath; //路径
				 temperrfaname = fileName; //名称
			}
			
			File filetest = new File(leftPath, fileName);
			if (!filetest.getParentFile().exists()) {
				filetest.getParentFile().mkdirs();
			}
			file.transferTo(filetest);

       }
      
       //将图片路径与rfa文件路径存入数据库
       String uuid=(String) request.getSession().getAttribute("uuid");
       String filesql = "update T_ZUKU_DETAIL  SET RFA_PATH = '"+temperrfaname+"',SLT_PATH = '"+temperimgname+"' WHERE ID = '"+uuid+"'";
       System.out.println("执行到这啦");
       try{
			this.mapService.execute(filesql);
			reponse.getWriter().write("uploadSuccess");
		}catch(Exception e){
			reponse.getWriter().write(e.toString());
		}
       
       return "true";
       
       
       
   }
	
	/*
	 * 获取前端页面用户填写的表单
	 * */
	
	@RequestMapping(value = "/questFORM")
	public void questFORM(HttpServletRequest req,HttpServletResponse reponse,HttpSession httpSession) throws IOException {
		String RFAname = req.getParameter("_name");
		String RFAversion = req.getParameter("_version");
		String RFAsign = req.getParameter("_sign");
		String uuid=UUID.randomUUID().toString();
		
		String Info = "insert into T_ZUKU_DETAIL(ID,NAME,VERSION,SIGN) values('"+uuid+"','"+RFAname+"','"+RFAversion+"','"+RFAsign+"')";
		try{
			this.mapService.execute(Info);
			req.getSession().setAttribute("uuid", uuid);
			
			reponse.getWriter().write("uploadSuccess");
		}catch(Exception e){
			reponse.getWriter().write(e.toString());
		}
		
	}
	
	
	
	
	
}