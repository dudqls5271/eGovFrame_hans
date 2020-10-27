package hans.test.Board;

import java.awt.Image;
import org.springframework.http.MediaType;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JPopupMenu.Separator;
import javax.ws.rs.GET;
import javax.ws.rs.core.Cookie;
import javax.ws.rs.core.MultivaluedMap;

import org.apache.catalina.util.Strftime;
import org.apache.commons.compress.utils.IOUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.icu.text.DecimalFormat;
import com.ibm.icu.util.Calendar;
import com.ibm.icu.util.BytesTrie.Result;

import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.utl.sim.service.EgovFileScrty;

@Controller
@RequestMapping("/test/")
public class TestBoardController {

	private static final Logger logger = LoggerFactory.getLogger(TestBoardController.class);
	
	@Autowired
	TestBoardService service;
	
	//파일 경로를 context로부터 가지고 온다 
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/uploadAjax.do", method = RequestMethod.GET)
	public String uploadAjax()  {
		return "hansTest/uploadAjax";
	}
	
	@RequestMapping(value = "/imageSrc.do", method = RequestMethod.GET)
	public void download2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("=========> Back End Start!!");
		Map<String,String[]> map = request.getParameterMap();
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()) {
			String key = it.next();
			logger.info(Arrays.toString(map.get(key)));
		}
		String uploadDir = "D:" + File.separator + "ktr_upload" + File.separator;
		/*Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat(
				File.separator + "yyyy" + File.separator + "MM" + File.separator + "dd");
		String dataFolder = date.format(today);*/
//		String subPath = "smartEditor" + dataFolder + File.separator;
		String subPath = "smartEditor" + File.separator;
		String physical = request.getParameter("physical");
		String mimeType = "image/jpeg";
		logger.info("넘어온 데이터 : " + physical);
		logger.info("완성 경로 : " + uploadDir + subPath + physical);

		viewFile(response, uploadDir, subPath, physical, mimeType);
	}

	public void viewFile(HttpServletResponse response, String where, String serverSubPath, String physicalName,
			String mimeTypeParam) throws Exception {
		String mimeType = mimeTypeParam;
		// String downFileName = where + SEPERATOR + serverSubPath + SEPERATOR +
		// physicalName;
		String downFileName = where + serverSubPath + physicalName;

		File file = new File(filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] b = new byte[8192];

		if (mimeType == null) {
			mimeType = "application/octet-stream;";
		}

		response.setContentType(mimeType.replaceAll("\r", "").replaceAll("\n", ""));
		response.setHeader("Content-Disposition", "filename=image;");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		} finally {
			close(outs, fin);
		}
	}

	public void close(Closeable... resources) {
		for (Closeable resource : resources) {
			if (resource != null) {
				try {
					resource.close();
				} catch (Exception ignore) {
					logger.debug("Occurred Exception to close resource is ingored!!");
				}
			}
		}
	}

	// 파일경로의 유효성 체크
	public String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}
	/* 파일 관련 유틸 끝 */

	
	@RequestMapping(value = "/individualInfo.do") //개인정보처리방침
	public ModelAndView individualInfo() {
		 ModelAndView mav = new ModelAndView("/template/sub_template");
		 mav.addObject("contentPage", "login/individualInfo.jsp");
		 
		 return mav;
	}

//	---------------------------------------------[Ajax 파일 업로드]----------------------------------
	
	public String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		
		UUID uid = UUID.randomUUID();
		logger.info("난수생성 완료!!!!!!!!");
		
		String savedName = uid.toString() + "_" + originalName;
		logger.info("봉합 완료!!!!!!!!");
		
		String savedPath = calcPath(uploadPath);
		logger.info("경로계산 완료!!!!!!!!");
		File target = new File(uploadPath + savedPath + File.separator + savedName);
		logger.info("====================!!!!!!!!");
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		logger.info("확정자 명");
		String uploadedFileName = null;
		
		if(MediaUtil.geMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		logger.info("파일생성 완료!!!!!!!!");
		
		return uploadedFileName;
	}
	
	private String makeIcon(String uploadPath, String path, String fileName) {
		String iconName = uploadPath + path + File.separator+ fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MARCH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, yearPath, monthPath, datePath);
		logger.info("datePath : " + datePath);
		
		return datePath;
	}
	
	private static void makeDir(String uploadPath, String... paths) {
		
		if(new File (uploadPath + paths[paths.length-1]).exists()) {
			return;
		}
		
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(! dirPath.exists() ) {
				dirPath.mkdir();
			}
		}
	}
	
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);
		
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
		
	}
	
	@ResponseBody
	@RequestMapping(value = "test/uploadAjax.do", method = RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		if (!file.isEmpty()) {
		logger.info(file.getContentType());
		logger.info(file.getOriginalFilename());
		logger.info(file.getSize() + "");
		}
		String result = uploadFile(uploadPath,file.getOriginalFilename(),file.getBytes());
		logger.info("result : "+ result);
		return new ResponseEntity<String> (result, HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping("/displayFile.do")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("FILE NAME :" + fileName);
		
		try {
			String forName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtil.geMediaType(forName);
			
			HttpHeaders headers = new HttpHeaders();
			
			in = new FileInputStream(uploadPath + fileName);
			
			if (mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+
				new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteFile.do", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) {
		
		logger.info("delete file: " + fileName);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtil.geMediaType(formatName);
		
		if (mType != null) {
			
			String front = fileName.substring(0,12);
			String end = fileName.substring(14);
			new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
		}
		
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
//	----------------------------------------------------------[Ajax 부분]-------------------------------------------------
	
	
	
//	그냥 파일 업로드 Form
	@RequestMapping(value = "/uploadForm.do", method = RequestMethod.GET)
	public String uploadFormGET() throws Exception {
		return "hansTest/uploadForm";	 
	}
	
	@RequestMapping(value = "/uploadForm.do", method = RequestMethod.POST)
	public String uploadFormPOST(MultipartFile file, Model model) throws Exception {
		//파일이 있는지 없는지 부터 확인 
		if(!file.isEmpty()) {
			//로그 찍고
			logger.info(file.getOriginalFilename());
			logger.info(file.getSize() + "");
			logger.info(file.getContentType());
			
			//저장 하는데 오리지이름, 크기를 이름으로 저장
			String savedName = uploadFile_Form(file.getOriginalFilename(), file.getBytes());
			model.addAttribute("savedName", savedName);
		}
		
		return "redirect:/test/list.do";	 
	}

	//form 파일 업로드
	private String uploadFile_Form(String originalName, 
								byte[] fileData) throws Exception {
		//UUID = 난수 만듬 
		UUID uid = UUID.randomUUID();
		//난수_원래이름.png 로 저장 
		String savedName = uid.toString() + "_" + originalName;
		System.out.println("2");
		//target = uploadPath(지정해준 경로 "C:\\zzz\\upload" ) separator(\)이다. 
		// 경로는 C:\\zzz\\upload가 되는것
		File target = new File(uploadPath + File.separator +  savedName);
		//파일 생성
		//fileData로 byte 배열을 만들고 target에 저장 한다.
		FileCopyUtils.copy(fileData, target);
		System.out.println("3");
		return "redirect:/test/list.do";
	}
	
//	---------------------------------------------------------------Ajax아이디 체크--------------------------------
	   @ResponseBody
	   @RequestMapping(value = "idCheckAjax.do", method = RequestMethod.POST)
	   public String idCheck(TestBoardVO vo) throws Exception {
	      System.out.println("idCheck start!!");
	      logger.info("idCheck start!!");
	      String result = "N";
	      boolean checkResult = service.idCheck(vo);
	      if (checkResult) {
	         result = "Y";
	      }
	      logger.info("result :" + result);
	      return result;
	   }	
	   
	   
//	-----------------------------------------------------------------list - page - list ------------------------------------------------
	
	
	@RequestMapping("list.do")
	public String list(@ModelAttribute("cri")Criteria cri,Model model) {
		try {
			System.out.println(cri.toString());
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.listCountCriteria(cri));

			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("resultList", service.listCriteria(pageMaker.getCri()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/list";
	}
	
	@RequestMapping(value="/listPage.do", method = RequestMethod.GET)
	public String listPage(@ModelAttribute("cri")SearchCriteria cri,
			Model model) throws Exception {		
		System.out.println(cri.toString());
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", service.listCriteria(pageMaker.getCri()));
		System.out.println("============================>?");
		return "hansTest/list";
		
	}
	
	@RequestMapping(value = "/readPage.do", method = RequestMethod.GET)
	public void read(@RequestParam("seqno") int bno,
			@ModelAttribute("cri") Criteria cri,
			Model model) throws Exception {
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno ,
			Criteria cri,
				RedirectAttributes rttr) throws Exception {
		service.remove(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/test/listPage";
		
	}
	
	@RequestMapping(value="/modifyPage", method = RequestMethod.POST)
	public String modifyPagingPOST(BoardVO board ,
			Criteria cri,
				RedirectAttributes rttr) throws Exception {
		service.modify(board);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/test/listPage";
		
	}		

	@RequestMapping("view.do")
	public String view(Model model, TestBoardVO vo) {
		try {
			model.addAttribute("result", service.selectBoard(vo));
			model.addAttribute("fullNameList", service.selectName(vo));
			model.addAttribute("result_re", service.list_rno(vo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/view";
	}

	@RequestMapping("writing.do")
	public String writing(Model model) {
		try {

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/writing";
	}

	@RequestMapping("writing_re.do")
	public String writing_re(TestBoardVO vo) {	
		try {
			service.insertBoard(vo);
			if(vo.getFullnames() != null) {
				for (int i = 0; i <vo.getFullnames().size(); i++) {
					vo.setFullname(vo.getFullnames().get(i));
					vo.setOriname(vo.getOrinames().get(i));
					service.insertImg(vo);
				}
			} else {
					vo.setFullname("no");
					vo.setOriname("no");
					service.insertImg(vo);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}

	@RequestMapping(value = "modify.do")
	public String modfiy(Model model, TestBoardVO vo) {
		String returnUrl = "";
		try {
			TestBoardVO tbvo = service.selectBoardModify(vo);
			if(tbvo == null) {
				returnUrl = "redirect:/test/list.do";
			}else {
				model.addAttribute("result", tbvo);
				model.addAttribute("fullNameList", service.selectName(vo));
				returnUrl = "hansTest/modify";
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return returnUrl;
	}
	
	@RequestMapping(value = "pw_ch.do")
	public String pw_ch(Model model, TestBoardVO vo) {
		logger.info("============================> pw_ch");
		try {
			model.addAttribute("result", service.selectBoard(vo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/pw_ch";
	}

	@RequestMapping("modify_re.do")
	public String modfiy_re(Model model, TestBoardVO vo) {
			try {
				service.updateBoard(vo);
				if(vo.getFullnames() != null) {
					for (int i = 0; i <vo.getFullnames().size(); i++) {
						vo.setFullname(vo.getFullnames().get(i));
						vo.setOriname(vo.getOrinames().get(i));
						service.updateImg(vo);
					}
				} else {
						vo.setFullname("no");
						vo.setOriname("no");
						service.updateImg(vo);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "redirect:/test/list.do";
		}

	@RequestMapping("delete.do")
	public String delete(Model model, TestBoardVO vo) {
		try {
			model.addAttribute("result", service.deleteBoard(vo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}

	@RequestMapping("login.do")
	public String login(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/login_re";
	}
	
	@RequestMapping("logout_list.do")
	public String logout_list(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/logout_list";
	}
	
	@RequestMapping("header.do") 
	public String header(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/header";
	}
	
	@RequestMapping("page.do")
	public String page(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/listPage";
	}

	@RequestMapping("nav.do")
	public String nav(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/nav";
	}
	
	@RequestMapping("copi.do")
	public String copi(TestBoardVO vo) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/copi";
	}
	
	@RequestMapping("button.do")
	public String button(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/button";
	}
	
	@RequestMapping("user.do")
	public String user(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/user";
	}
	
	@RequestMapping(value="login_re.do", method=RequestMethod.POST)
	public String login_re(Model model, RedirectAttributes rttr, HttpServletRequest request, TestBoardVO vo) {
		System.out.println("===============> post");
		System.out.println(vo.toString());
		try {
			TestBoardVO userVO = service.selectLogin(vo);
			if (userVO != null) {
				if (userVO.getUser_id() != null) {
					HttpSession session = request.getSession();
					session.setAttribute("sessionId", userVO.getUser_id());
					session.setAttribute("sessionNick", userVO.getNickname());
					session.setAttribute("pw_boader", userVO.getPw_boader());
				} 
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}

	@RequestMapping("join.do")
	public String join(Model model) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/join";
	}


	@RequestMapping("join_re.do")
	public String join_re(TestBoardVO vo) {
		try {
			service.insertJoin(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}
	
	@RequestMapping("idChack.do")
	public String idChack(TestBoardVO vo) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/idChack";
	}
	

	@RequestMapping("logout.do")
	public String logout(TestBoardVO vo, HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			session.invalidate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}
	
	@RequestMapping("modifyMember.do")
	public String modifyMember(Model model, TestBoardVO vo) {
		try {
			model.addAttribute("result", service.selectBoard(vo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/modifyMember";
	}
	
	@RequestMapping("smartEdit.do")
	public String smartEidt(TestBoardVO vo) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/smartEdit";
	}
	
	@RequestMapping("search.do")
	public String serch(TestBoardVO vo) {
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/layout/search";
	}
	
	   @RequestMapping(value="/test.do", method= RequestMethod.GET)
	   public String ajaxTest(TestBoardVO vo, Model model) {
			try {
				model.addAttribute("result", service.list_rno(vo));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  
		   return "hansTest/test";
	   }
	   
	   @RequestMapping(value="/find_id.do", method= RequestMethod.GET)
	   public String find_id(TestBoardVO vo, Model model) {
			try {
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   return "hansTest/find_id";
	   }
	   
	   @RequestMapping(value="/find_id_re.do", method= RequestMethod.GET)
	   public String find_id_re(TestBoardVO vo, Model model) {
			try {
				
				model.addAttribute("result", service.find_id(vo));
				model.addAttribute("resultDate", service.ragedate_id(vo));

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   return "hansTest/find_id_re";
	   }
	
	   
	   @RequestMapping(value="/find_pw.do", method= RequestMethod.GET)
	   public String find_pw(TestBoardVO vo, Model model) {
			try {
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   return "hansTest/find_pw";
	   }
	   
	   @RequestMapping(value="/find_pw_re.do", method= RequestMethod.GET)
	   public String find_pw_re(TestBoardVO vo, Model model) {
			try {
				model.addAttribute("result", service.find_id(vo));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   return "hansTest/find_pw_re";
	   }
}