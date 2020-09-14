package hans.test.Board;

import java.awt.Image;
import org.springframework.http.MediaType;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JPopupMenu.Separator;
import javax.ws.rs.core.Cookie;
import javax.ws.rs.core.MultivaluedMap;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.icu.text.DecimalFormat;
import com.ibm.icu.util.Calendar;

import egovframework.let.cop.bbs.service.BoardVO;

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
		logger.info(datePath);
		
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
		logger.info(result);
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
			new File(uploadPath + fileName.replace('/',File.separatorChar)).delete();
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
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/test/list.do";
	}

	@RequestMapping("modify.do")
	public String modfiy(Model model, TestBoardVO vo) {
		try {
			model.addAttribute("result", service.selectBoard(vo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/modify";
	}

	@RequestMapping("modify_re.do")
	public String modfiy_re(Model model, TestBoardVO vo) {
		try {
			model.addAttribute("result", service.updateBoard(vo));
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
		return "hansTest/header";
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
	
}