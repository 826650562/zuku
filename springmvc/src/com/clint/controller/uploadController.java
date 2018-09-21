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

		List<MultipartFile> files1 = multipartRequest.getFiles("imgfile");
		List<MultipartFile> files2 = multipartRequest.getFiles("rfafile");

		MultipartFile f1 = files1.get(0);
		MultipartFile f2 = files2.get(0);

		if (f1 != null) {
			files.add(f1);
		}

		if (f2 != null) {
			files.add(f2);
		}

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
				}
				if (fileName.endsWith("rfa")) {
					leftPath = session.getServletContext().getRealPath("/rfa");
					temperrfapath = leftPath; // 路径
					temperrfaname = fileName; // 名称
					Long size = file.getSize();
					int sizeInt = Integer.parseInt(String.valueOf(size));
					sizeKb = (sizeInt / 1024) + "kb";
				}

				File filetest = new File(leftPath, fileName);
				if (!filetest.getParentFile().exists()) {
					filetest.getParentFile().mkdirs();
				}
				file.transferTo(filetest);

			}

			// 将图片路径与rfa文件路径存入数据库
			String uuid = (String) request.getSession().getAttribute("uuid");
			filesql = "update T_ZUKU_DETAIL  SET RFA_PATH = '" + temperrfaname + "',SLT_PATH = '" + temperimgname
					+ "',RFASIZE='" + sizeKb + "' WHERE ID = '" + uuid + "'";
			this.mapService.execute(filesql);
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
		String RFId = req.getParameter("_getId");
		String uuid = UUID.randomUUID().toString();

		String Info = "insert into T_ZUKU_DETAIL(ID,NAME,VERSION,SIGN,Parent_id) values('" + uuid + "','" + RFAname
				+ "','" + RFAversion + "','" + RFAsign + "','" + RFId + "')";
		try {
			this.mapService.execute(Info);
			req.getSession().setAttribute("uuid", uuid);

			reponse.getWriter().write("uploadSuccess");
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
		String Info = "insert into T_ZUKU_CLASSIFY(id,PARENT_ID,CLASS_NAME) values(SEQ_NO.nextVal,'" + parentId
				+ "','"  + type + "')";		
		try {
			this.mapService.execute(Info);
			JSONObject obj = new JSONObject();
			obj.put("success", "添加自定义类别项成功！");				
			reponse.getWriter().write(String.valueOf(obj));
		} catch (Exception e) {
			reponse.getWriter().write(e.toString());
		}

	}
	

}