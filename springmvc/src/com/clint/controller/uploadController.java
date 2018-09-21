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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.clint.service.MapService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	 *             上传构件文件
	 */
	@RequestMapping(value = "/uploadRFAfile")
	public String uploadRFAfile(@RequestParam("file") MultipartFile uploadFile, HttpSession session)
			throws IOException {
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
	 *             上传构件缩略图
	 */
	@RequestMapping(value = "/uploadIMGfile")
	public void uploadMult(HttpServletRequest request, HttpSession session, HttpServletResponse reponse)
			throws IllegalStateException, IOException {
		// 转型为MultipartHttpRequest：
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 获得文件：

		List<MultipartFile> files = new ArrayList<MultipartFile>();

		List<MultipartFile> files1 = multipartRequest.getFiles("file");
		//List<MultipartFile> files2 = multipartRequest.getFiles("rfafile");

		MultipartFile f1 = files1.get(0);
		//MultipartFile f2 = files2.get(0);

		if (f1 != null) {
			files.add(f1);
		}

		/*if (f2 != null) {
			files.add(f2);
		}*/

		String leftPath = "";
		String temperimgpath = "";
		String temperrfapath = "";
		String temperimgname = "";
		String temperrfaname = "";

		String filesql = "";
		String sizeKb = "";
		JSONObject obj = new JSONObject();
		if (files.isEmpty()) {
			obj.put("error", "上传错误!");
		} else {
			for (MultipartFile file : files) {
				String fileName = file.getOriginalFilename();

				if (fileName.endsWith("jpg") || fileName.endsWith("png")) {
					leftPath = session.getServletContext().getRealPath("/rfa-img");
					temperimgpath = leftPath; // 路径
					temperimgname = fileName; // 名称	
					obj.put("imgSrc", temperimgpath);
					obj.put("imgName", temperimgname);
				}
				if (fileName.endsWith("rfa")) {
					leftPath = session.getServletContext().getRealPath("/rfa");
					temperrfapath = leftPath; // 路径
					temperrfaname = fileName; // 名称
					Long size = file.getSize();
					int sizeInt = Integer.parseInt(String.valueOf(size));
					sizeKb = (sizeInt / 1024) + "kb";
					obj.put("rfaName", temperrfaname);
					obj.put("sizeKb", sizeKb);
				}
				File filetest = new File(leftPath, fileName);
				if (!filetest.getParentFile().exists()) {
					filetest.getParentFile().mkdirs();
				}
				file.transferTo(filetest);

			}
			obj.put("success", "上传成功");
		}
		try {
			reponse.getWriter().write(String.valueOf(obj));
		} catch (Exception e) {
			reponse.getWriter().write(e.toString());
		}
	}

	/*
	 * 获取前端页面用户填写的表单
	 */

	@RequestMapping(value = "/questFORM")
	public void questFORM(HttpServletRequest req, HttpServletResponse reponse, HttpSession httpSession)
			throws IOException {
		String RFAname = req.getParameter("_name");
		String RFAversion = req.getParameter("_version");
		String RFAsign = req.getParameter("_sign");
		String thirdTypeId = req.getParameter("thirdTypeId");
		String rfaName = req.getParameter("rfaName");
		String imgName = req.getParameter("imgName");
		String sizeKb = req.getParameter("sizeKb");
		String secondTypeId = req.getParameter("secondTypeId");
		String firstTypeId =  req.getParameter("firstTypeId");
		String uuid = UUID.randomUUID().toString();
		JSONObject obj = new JSONObject();
		
		if(StringUtils.hasText(RFAname)){
			int count = this.mapService.countAll("select count(*) from T_ZUKU_DETAIL where NAME='"+ RFAname  +"' and Parent_id='"+ thirdTypeId +"'");
			if(count>0){
				obj.put("uploadError", "该构件已存在！");
			}else{
				String Info = "insert into T_ZUKU_DETAIL(ID,NAME,VERSION,SIGN,Parent_id,RFA_PATH,SLT_PATH,RFASIZE,GRANDPARENT_ID,GREATGRANDFATHER_ID) values('" + uuid + "','" + RFAname
						+ "','" + RFAversion + "','" + RFAsign + "','" + thirdTypeId +"','" + rfaName +"','" + imgName +"','" + sizeKb +"','" + secondTypeId+ "','" + firstTypeId + "')";
				this.mapService.execute(Info);
				obj.put("uploadSuccess", "构件信息上传成功！");
			}			
		}else{
			obj.put("uploadError", "构件信息上传失败！");
		}
		//向数据库插入详情sql语句		
		try {			
			req.getSession().setAttribute("uuid", uuid);			
			reponse.getWriter().write(String.valueOf(obj));

		/*String RFId = req.getParameter("_getId");
		String RFAGrandparentId = req.getParameter("_GrandparentId");
		String RFAGreatgrandparentId = req.getParameter("_GreatgrandparentId");
		String uuid = UUID.randomUUID().toString();

		String Info = "insert into T_ZUKU_DETAIL(ID,NAME,VERSION,SIGN,Parent_id,GRANDPARENT_ID,GREATGRANDFATHER_ID) values('" + uuid + "','" + RFAname
				+ "','" + RFAversion + "','" + RFAsign + "','" + RFId + "','" + RFAGrandparentId + "','" + RFAGreatgrandparentId + "')";
		try {
			this.mapService.execute(Info);
			req.getSession().setAttribute("uuid", uuid);

			reponse.getWriter().write("uploadSuccess");*/

		} catch (Exception e) {
			reponse.getWriter().write(e.toString());
		}
	}
	
	/*
	 * 添加自定义三级菜单项
	 */

	@RequestMapping(value = "/setThirdType")
	public void setThirdType(HttpServletRequest req, HttpServletResponse reponse) throws IOException {
		String type = req.getParameter("type");
		String parentId = req.getParameter("parentId");
		String Info ="";
		if(StringUtils.hasText(type)&&StringUtils.hasText(parentId)){
			Info = "insert into T_ZUKU_CLASSIFY(id,PARENT_ID,CLASS_NAME) values(SEQ_NO.nextVal,'" + parentId
					+ "','"  + type + "')";	
			this.mapService.execute(Info);
		}
		List hasType = this.mapService.getListBySql("select * from T_ZUKU_CLASSIFY where CLASS_NAME='"+ type +"' and PARENT_ID='"+ parentId +"'");
		JSONObject obj = new JSONObject();
		if(hasType.size()>0){
			obj.put("success", "添加自定义类别项成功！");	
		}	else{
			obj.put("error", "添加自定义类别项失败！");	
		}
		try {									
			reponse.getWriter().write(String.valueOf(obj));
		} catch (Exception e) {
			reponse.getWriter().write(e.toString());
		}
	}	
	
	//删除第三级菜单 delThirdType
	@RequestMapping(value = "/delThirdType")
	public void delThirdType(HttpServletRequest req, HttpServletResponse reponse) throws IOException {
		String typeId = req.getParameter("typeId");
		String Info ="";
		if(StringUtils.hasText(typeId)){
			Info = "delete from T_ZUKU_CLASSIFY where id='" + typeId + "'";	
			this.mapService.execute(Info);
		}
		List hasType = this.mapService.getListBySql("select * from T_ZUKU_CLASSIFY where id='"+ typeId +"'");
		JSONObject obj = new JSONObject();
		if(hasType.size()<=0){
			obj.put("success", "删除类别成功！");	
		}	else{
			obj.put("error", "删除类别失败！");	
		}
		try {									
			reponse.getWriter().write(String.valueOf(obj));
		} catch (Exception e) {
			reponse.getWriter().write(e.toString());
		}
	}	
}