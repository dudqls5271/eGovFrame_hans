package hans.test.Board;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JPopupMenu.Separator;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
//	데이터 파일 처리
//	private static String uploadFile(String originalName, 
//									String uploadPath, 
//									byte[] fileData) throws Exception {
//
//			UUID uid = UUID.randomUUID();
//			String savedName = uid.toString() + "_" + originalName;
//			String savedPath = calcPath(uploadPath);
//			
//			File target = new File(uploadPath + uploadPath, savedName);
//			FileCopyUtils.copy(fileData, target);
//			
//			String formatName = 
//					originalName.substring(originalName.lastIndexOf(".")+1);
//			
//			String uploadedFileName = null;
//			
//			if (MediaUtils.getMediaType(formatName) != null) {
//				uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
//			} else {
//				uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
//			}
//			
//			return uploadedFileName;
//	}
//	
//	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
//		String iconName = uploadPath + path + File.separator+ fileName;
//		return iconName.substring(uploadPath.length()).replace(File.separatorChar, "/");
//	}
//
//	private static String calcPath(String uploadPath) {
//		Calendar cal = Calendar.getInstance();
//		
//		String yearPath = File.separator+cal.get(Calendar.YEAR);
//		
//		String monthPath = yearPath + 
//				File.separator + 
//				new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
//		String datePath = monthPath +
//				File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
//		
//		makeDir(uploadPath, yearPath, monthPath, datePath);
//		logger.info(datePath);
//		
//		return uploadPath;
//	}
//	
//	private static void makeDir(String uploadPath, String...paths) {
//		if (new File (paths[paths.length-1]).exists()) {
//			return;
//		}
//		
//		for (String path : paths) {
//			File dirPath = new File(uploadPath + path);
//			
//			if (! dirPath.exists() ) {
//				dirPath.mkdir();
//			}
//		}
//	}
//	
//	private static String makeThumbnail(
//				String uploadPath,
//				String path,
//				String fileName ) throws Exception {
//		
//		BufferedImage sourceImg = 
//				ImageIO.read(new File(uploadPath + path, fileName));
//		
//		BufferedImage destImg = 
//				Scalr.resize(sourceImg,
//						Scalr.Method.AUTOMATIC, 
//						Scalr.Mode.FIT_TO_HEIGHT,100);
//		
//		String thumbnailName = 
//				uploadPath + path + File.separator + "s_" + fileName;
//		
//		File newFile = new File(thumbnailName);
//		
//		String formatName = 
//				fileName.substring(fileName.lastIndexOf(".")+1);
//		
//		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
//		return thumbnailName.substring(
//				uploadPath.length()).replace(File.separatorChar, '/');
//	}


	//	Ajax 업로드
	@RequestMapping(value = "/uploadAjax.do", method = RequestMethod.GET)
	public String uploadAjax()  {
		return "hansTest/uploadAjax";
	}
	
	@ResponseBody
	@RequestMapping(value = "/uploadAjax.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		if (!file.isEmpty()) {
			logger.info(file.getContentType());
			logger.info(file.getOriginalFilename());
			logger.info(file.getSize() + "");
		}	
		
	      return new ResponseEntity<>(file.getOriginalFilename(), HttpStatus.CREATED);
	}
	
//	그냥 파일 업로드
	 
	@RequestMapping(value = "/uploadForm.do", method = RequestMethod.GET)
	public String uploadFormGET() throws Exception {
		return "hansTest/uploadForm";	 
	}
	
	@RequestMapping(value = "/uploadForm.do", method = RequestMethod.POST)
	public String uploadFormPOST(MultipartFile file, Model model) throws Exception {
		
		if(!file.isEmpty()) {
			logger.info(file.getOriginalFilename());
			logger.info(file.getSize() + "");
			logger.info(file.getContentType());
			
			String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
			model.addAttribute("savedName", savedName);
		}
		
		return "redirect:/test/list.do";	 
	}

	
	private String uploadFile(String originalName, 
								byte[] fileData) throws Exception {
		
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		System.out.println("2");
		File target = new File(uploadPath + savedName);
		FileCopyUtils.copy(fileData, target);
		System.out.println("3");
		return "redirect:/test/list.do";
	}


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