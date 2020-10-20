package hans.test.Board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.utl.sim.service.EgovFileScrty;

@Service
public class TestBoardServicelmpl implements TestBoardService {

	@Autowired
	TestBoardDAO dao;

	@Override
	public List<TestBoardVO> selectAll() throws Exception {
		return dao.selectAll();
	}

	@Override
	public TestBoardVO selectBoard(TestBoardVO vo) throws Exception {
		return dao.selectBoard(vo);
	}

	@Override
	public int updateBoard(TestBoardVO vo) throws Exception {
		return dao.updateBoard(vo);
	}

	@Override
	public int insertBoard(TestBoardVO vo) throws Exception {
		return dao.insertBoard(vo);
	}

	@Override
	public int deleteBoard(TestBoardVO vo) throws Exception {
		return dao.deleteBoard(vo);
	}
	
	@Override
	public int updateJoin(TestBoardVO vo) throws Exception {
		return dao.updateJoin(vo);
	}
	
	@Override
	public int insertJoin(TestBoardVO vo) throws Exception {
		vo.setPw(EgovFileScrty.encryptPassword(vo.getPw(), vo.getUser_id()));
		return dao.insertJoin(vo);
	}
	
	@Override
	public TestBoardVO selectLogin(TestBoardVO vo) throws Exception {
		vo.setPw(EgovFileScrty.encryptPassword(vo.getPw(), vo.getUser_id()));
		return dao.selectLogin(vo);
	}

	@Override
	public TestBoardVO selectidChack(TestBoardVO vo) throws Exception {
		return dao.selectidChack(vo);
	}

	@Override
	public List<TestBoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return dao.countPaging(cri);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void regist(BoardVO boader) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void modify(BoardVO boader) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void remove(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TestBoardVO insertImg(TestBoardVO vo) throws Exception {
		return dao.insertImg(vo);
	}

	@Override
	public List<TestBoardVO> selectName(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectName(vo);
	}

	  public boolean idCheck(TestBoardVO vo) throws Exception {
	      // TODO Auto-generated method stub
	      boolean result = false;
	      TestBoardVO userInfo = dao.selectidChack(vo);
	      if (userInfo != null) {
	         if (userInfo.getUser_id() != null) {
	            result = true;

	            System.out.println(userInfo.getUser_id());
	         }
	      }
	      return result;
	   }

	@Override
	public TestBoardVO pw_ch(TestBoardVO vo) throws Exception {
		return dao.pw_ch(vo);
	}

	@Override
	public TestBoardVO selectBoardModify(TestBoardVO vo) throws Exception {
		return dao.selectBoardModify(vo);
	}

	@Override
	public int updateImg(TestBoardVO vo) throws Exception {
		return dao.updateImg(vo);
	}

	@Override
	public List<TestBoardVO> list(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.list(bno);
	}

	@Override
	public int create(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.create(vo);
	}

	@Override
	public int update(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.update(vo);
	}

	@Override
	public int delete(Integer seqno) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete(seqno);
	}

	@Override
	public int list_rno(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.list_rno(vo).getCount1();
	}

}
