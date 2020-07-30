package hans.test.Board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/test/")
public class TestBoardController {
	private static final Logger logger = LoggerFactory.getLogger(TestBoardController.class);
	
	@Autowired
	TestBoardService service;

	@RequestMapping("list.do")
	public String list(Model model) {
		try {
			model.addAttribute("resultList", service.selectAll());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "hansTest/list";
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
				return "redirect:/test/list.do";
				
			} else {
				rttr.addFlashAttribute("msg", "로그인에 실패했습니다.");
				return "redirect:/test/login.do";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/test/login.do";
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
	
	@ResponseBody
	@RequestMapping("idChack.do")
	public String idChack(TestBoardVO vo) {
		String result = "N";
		try {
			TestBoardVO user_id = service.selectidChack(vo);
			if(user_id == null || user_id.equals(null)) {
				result = "Y";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
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
