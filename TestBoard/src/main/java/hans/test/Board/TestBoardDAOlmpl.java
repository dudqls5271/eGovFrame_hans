package hans.test.Board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.hsqldb.Session;
import org.springframework.stereotype.Repository;

import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class TestBoardDAOlmpl extends EgovAbstractMapper implements TestBoardDAO{

	@Override
	public List<TestBoardVO> selectAll() throws Exception {
		System.out.println("DAO 까지 옴");
		return selectList("selectAll");
	}

	@Override
	public TestBoardVO selectBoard(TestBoardVO vo) throws Exception {
		return selectOne("selectBoard", vo);
	}

	@Override
	public int updateBoard(TestBoardVO vo) throws Exception {
		return update("updateBoard", vo);
	}

	@Override
	public int insertBoard(TestBoardVO vo) throws Exception {
		return insert("insertBoard", vo);
	}

	@Override
	public int deleteBoard(TestBoardVO vo) throws Exception {
		return delete("deleteBoard", vo);
	}

	@Override
	public int updateJoin(TestBoardVO vo) throws Exception{
		return update("updateJoin", vo);
	}

	@Override
	public int insertJoin(TestBoardVO vo) throws Exception{
		return insert("insertJoin", vo);
	}

	@Override
	public TestBoardVO selectLogin(TestBoardVO vo) throws Exception {
		return selectOne("selectLogin", vo);
	}

	@Override
	public TestBoardVO selectidChack(TestBoardVO vo) throws Exception {
		return selectOne("selectidChack", vo);
	}

	@Override
	public List<TestBoardVO> listPage(int page) throws Exception {
		
		if(page <= 0) {
			page = 1;
		}
		
		page = (page - 1) *10;

		return selectList("listPage", page);
	}

	@Override
	public List<TestBoardVO> listCriteria(Criteria cri) throws Exception {
		return selectList("listSearch", cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return selectOne("countSearchPaging", cri);
	}

	@Override
	public List<TestBoardVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return selectList("listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return selectOne("listSearchCount", cri);
	}
	
}
