package hans.test.Board;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SampleInterceptor  extends HandlerInterceptorAdapter{
	
	@Override
	public void postHandle(HttpServletRequest requset, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		System.out.println("post handle..............");
		
		Object result = modelAndView.getModel().get("sessionId");
		
		if (result != null) {
			requset.getSession().setAttribute("result", result);
			response.sendRedirect("doA.do");
		}
	}
	
	@Override
	public boolean preHandle (HttpServletRequest requst, HttpServletResponse response, Object handler) throws Exception {
		
		System.out.println("pre handle................");
		
		HandlerMethod method = (HandlerMethod) handler;
		Method methodObj = method.getMethod();
		
		System.out.println("Bean : " + method.getBean());
		System.out.println("Method: " + methodObj);
		
		return true;
	}

}
