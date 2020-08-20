package hans.test.Board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

<<<<<<< HEAD
	@Override
	public TestBoardVO selectidChack(TestBoardVO vo) throws Exception {
		return dao.selectidChack(vo);
	}

	@Override
	public List<TestBoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return dao.countPaging(cri);
	}

=======
>>>>>>> parent of 7ccb025... 제이슨 아이디 중복 체크
}
