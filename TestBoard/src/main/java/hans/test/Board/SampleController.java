package hans.test.Board;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/reply/")
public class SampleController {
	
	@Autowired
	TestBoardService service;
	
	@RequestMapping("hello.do")
	public String sayHello() {
		return "Hello World";
	}
	
	
	
	@RequestMapping("sendVO.do") 
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setFirstName("길동");
		vo.setListName("홍");
		vo.setMno(123);
		return vo;
	}
	
	@RequestMapping("sendList.do")
	public List<SampleVO> sendList() {
		
		List <SampleVO> list = new ArrayList<>();
		for(int i = 0; i <= 10; i ++) {
			SampleVO vo = new SampleVO();
			vo.setFirstName("길동");
			vo.setListName("홍");
			vo.setMno(i);
			list.add(vo);
		}
		return list;
	}
	
	 @RequestMapping(value = "reply.do", method = RequestMethod.POST)
	   public ResponseEntity<String> register(@RequestBody TestBoardVO vo) throws Exception{
		   System.out.println("============> " + vo.getBno());
		   System.out.println("============> " + vo.getReplytext());
		   System.out.println("============> " + vo.getReplyer());
		   ResponseEntity<String> entity = null;
		   try {
			   service.create(vo);
			   System.out.println("============> 생성");
			   entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		   } catch (Exception e) {
			   e.printStackTrace();
			   entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		   
	   }
	
	@RequestMapping(value="all/{bno}.do", method = RequestMethod.GET)
	public ResponseEntity<List<TestBoardVO>> list(@PathVariable("bno") Integer bno) {
		System.out.println("============> " + bno);
		ResponseEntity<List<TestBoardVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(service.list(bno),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	   
	   @RequestMapping(value="/{rno}.do", method = { RequestMethod.PUT, RequestMethod.PATCH})
	   public ResponseEntity<String> update(@PathVariable("rno") Integer rno, @RequestBody TestBoardVO vo) {
		   System.out.println("============> " + rno);
		   
		   ResponseEntity<String> entity = null;
		   try {
			   vo.setRno(rno);
			   System.out.println("============> " + vo.getRno());
			   service.update(vo);
			   System.out.println("============> update 까지 옴");
			   
			   entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		   } catch (Exception e) {
			   e.printStackTrace();
			   entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		   }
		   return entity;
	   }
	   
	   @RequestMapping(value="/{rno}.do", method = RequestMethod.DELETE)
	   public ResponseEntity<String> delete(@PathVariable("rno") Integer rno) {
		   System.out.println("============> " + rno);
		   
		   ResponseEntity<String> entity = null;
		   try {
			   service.delete(rno);
			   System.out.println("============> delete 까지 옴");
			   
			   entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		   } catch (Exception e) {
			   e.printStackTrace();
			   entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		   }
		   return entity;
	   }
	
}
