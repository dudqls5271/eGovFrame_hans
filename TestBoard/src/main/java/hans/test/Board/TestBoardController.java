package hans.test.Board;

import java.awt.Image;
import org.springframework.http.MediaType;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
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
	
	//	Ajax 업로드
	// 페이지 이동
	@RequestMapping(value = "/uploadAjax.do", method = RequestMethod.GET)
	public String uploadAjax()  {
		return "hansTest/uploadAjax";
	}
	
	// Ajax 파일 전송
	@ResponseBody
	@RequestMapping("/dispalyFile.do")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("file name: " + fileName);
		
		try {
			//확장자명 추출
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MimeMediaUtil.geMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			
			//uploadPath의 fileName을 가진 FileInputStream 변수 초기화
			in = new FileInputStream(uploadPath + fileName);
			
			//만약 이지미 타입 이라면?
			if(mType != null) {
				headers.setContentType(mType);
			//그 외 다른 타입 
			} else {
				//확장자 확인
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				// MIME을 '다운로드 타입'으로 지정
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				// 파일명을 한글로 인코딩
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}
		
			//IOUtils.toByteArray(in) : FileInputStream 타입 in 변수에서 실제 데이터? 을 읽어온다
			// 읽어온 데이터, headers, Http 상태코드를 담은 entity 변수 반환
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			// InputStream을 끝낸다.
			in.close();
		}
		return entity;
	}
	
	
	// Ajax 그래그엔 드랍 할때 파일 정보 logger 
	@ResponseBody
	@RequestMapping(value = "/uploadAjax.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		//일단 파일이 있는지 없는지 부터 확인하고
		if (!file.isEmpty()) {
			//파일정보를 logger로 찍어준다.
			logger.info(file.getContentType());
			logger.info(file.getOriginalFilename());
			logger.info(file.getSize() + "");
		}	
		
		return new ResponseEntity<>(TestBoardController.uploadFiles(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);

	}
		
	// Ajax 업로드 파일 저장?
	//파일 데이터 처리용 클래서 작성
	public static String uploadFiles(String uploadPath, String orginalName, byte[] fileData) throws Exception {
		//난수 설정 해서
		UUID uid = UUID.randomUUID();
		//난수_오리지널 이름 으로 사진? 파일을 생성한
		String savedName = uid.toString() + "_" + orginalName;
		//경로가 존제하는지 판단후 생성
		String savedPath = calcPath(uploadPath);
		//upload + savePath 경로에 "uuid" + "_" + "orginalName" 이름을 가진 File타입 target 변수 생성
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		//확정자 추출 substr로 .부터 불러온다.
		String formatName = orginalName.substring(orginalName.lastIndexOf(".")+1);
		//최종적으로 보내줄 uploadFileName을  null로 설정
		String uploadedFileName = null;
		//이미지 일때
		if (MimeMediaUtil.geMediaType(formatName) != null) {
			//
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		//그외 파일 일때
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		logger.info("uploadedFileName: " + uploadedFileName);
		return uploadedFileName;
	}
	
	//makeIcon
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		
		//uploadPath\년\월\일\UUID_파일명 형식으로 저장 한다.
		String iconName = uploadPath + path + File.separator+ fileName;
		return iconName.substring(uploadPath.length()).replace(File.separator, "/");
	}
	
	//makeDir
	private static void makeDir(String uploadPath, String...paths) {
		// uploadPath + yearPath + monthPath + dataPath. 해당 경로가 존재한다면 리턴으로 종료
		if (new File (paths[paths.length-1]).exists()) {
			return;
		}
		// 년 -> 월 -> 일 순으로 파일을 만든다
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			//일 까지 만들면  끝내라
			if (! dirPath.exists() ) {
				dirPath.mkdir();
			}
			logger.info("dirPath: " + dirPath);
		}
	}
	
	//calPath 파일 생성
	private static String calcPath(String uploadPath) {
		//싱글톤 객체를 생성한다.
		Calendar cal = Calendar.getInstance();
		
		//년/월/일 경로 생성 
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		// 경로가 실제로 존제하는지 판단후 생성한다.
		makeDir(uploadPath, yearPath, monthPath, datePath);
		logger.info("monthPath : " + monthPath);
		logger.info("dataPath : " + datePath);
		
		return datePath;
	}
	
	//makeThumbnail 썸내일 
	private static String makeThumbnail(String uploadPath, String path, String fileName ) throws Exception {
		
		//upload + path 경로에서 fileName을 읽어 온다.
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		//Scalr 이라는 bil을 이용해서 읽어온 이미지 썸내일 용의 사이즈의 크기를 다시 지정한다.
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);
		//이것도 똑같이 년 월 일 s_UUID_파일명으로 만듬
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		logger.info("thumbnailName c?: " + thumbnailName);
		//uploadPath/년/월/일/s_UUID_파일명의 이름을 가진 newFile을 만든다.
		File newFile = new File(thumbnailName);
		logger.info("newFile : " + newFile);
		//확장자를 추출한다. substr으로(파일이름의 .부터 +1 을가지고 온다) ex)png
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		//불특정한 확장자 이름을 무조건 대문자로 결정
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		logger.info("작은 놈 :" + thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/'));
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/'); 
	}
	
	
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