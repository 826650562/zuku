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
	/*public String uploadIMGfile(@RequestParam("file") MultipartFile[] uploadFile, HttpSession session) throws IOException {
		if (uploadFile.length > 0) {   
			String filename="";
			String leftPath="";
			for(int i=0;i<uploadFile.length;i++){
				filename=uploadFile[i].getOriginalFilename();
				if (filename.endsWith("jpg")|| filename.endsWith("png")) {
					 leftPath = session.getServletContext().getRealPath("/rfa-img");
				}
				if(filename.endsWith("rfa")){
					 leftPath = session.getServletContext().getRealPath("/rfa");
				}
				File file = new File(leftPath, filename);
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}
				uploadFile[i].transferTo(file);
			}
		
		} else {
			return "error";
		}
		return "uploadSuccess";
	}*/
	public String uploadMult(HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
        // 转型为MultipartHttpRequest：   
       MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;   
       // 获得文件：   
       
       List<MultipartFile> files = new ArrayList<MultipartFile>();
      /*
       files.add((MultipartFile) multipartRequest.getFiles("imgfile"));
       files.add((MultipartFile) multipartRequest.getFiles("rfafile"));*/
       
       List<MultipartFile> files1 = multipartRequest.getFiles("imgfile");
       List<MultipartFile> files2 = multipartRequest.getFiles("rfafile");
       
       files.add(files1.get(0));
       files.add(files2.get(0));
       
       if (files.isEmpty()) {
           return "false";
       }
       
	   String leftPath="";

       for (MultipartFile file : files) {
           String fileName = file.getOriginalFilename();
           
            if (fileName.endsWith("jpg")|| fileName.endsWith("png")) {
				 leftPath = session.getServletContext().getRealPath("/rfa-img");
			}
			if(fileName.endsWith("rfa")){
				 leftPath = session.getServletContext().getRealPath("/rfa");
			}
			
			File filetest = new File(leftPath, fileName);
			if (!filetest.getParentFile().exists()) {
				filetest.getParentFile().mkdirs();
			}
			file.transferTo(filetest);

       }
       return "true";
   }
	
	/*
	 * 获取前端页面用户填写的表单
	 * */
	
	@RequestMapping(value = "/questFORM")
	public void questFORM(HttpServletRequest req,HttpServletResponse reponse) throws IOException {
		String RFAname = req.getParameter("_name");
		String RFAversion = req.getParameter("_version");
		String RFAsign = req.getParameter("_sign");
		String uuid=UUID.randomUUID().toString();
		String Info = "insert into T_ZUKU_DETAIL(ID,NAME,VERSION,SIGN) values('"+uuid+"','"+RFAname+"','"+RFAversion+"','"+RFAsign+"')";
		try{
			this.mapService.execute(Info);
			reponse.getWriter().write("uploadSuccess");
		}catch(Exception e){
			reponse.getWriter().write(e.toString());
		}
		
	}
	
	
	
	
	
}