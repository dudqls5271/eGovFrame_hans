package hans.test.Board;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.session.SqlSession;
import org.hsqldb.Session;
import org.springframework.stereotype.Repository;

import com.sun.mail.imap.protocol.Namespaces.Namespace;

import antlr.NameSpace;
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
	public TestBoardVO insertImg(TestBoardVO vo) throws Exception {
		return selectOne("add_img", vo);
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

	@Override
	public List<TestBoardVO> selectName(TestBoardVO vo) throws Exception {
		return selectList("selectName", vo);
	}

	@Override
	public TestBoardVO pw_ch(TestBoardVO vo) throws Exception {
		return selectOne("pw_ch", vo);
	}

	@Override
	public TestBoardVO selectBoardModify(TestBoardVO vo) throws Exception {
		return selectOne("selectBoardModify", vo);
	}

	@Override
	public int updateImg(TestBoardVO vo) throws Exception {
		return update("updateImg", vo);
	}
	

	@Override
	public List<TestBoardVO> list(Integer bno) throws Exception {
		return selectList("list", bno);
	}

	@Override
	public int create(TestBoardVO vo) throws Exception {
		return insert("create", vo);
	}

	@Override
	public int update(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return update("update", vo);
	}

	@Override
	public int delete(Integer seqno) throws Exception {
		// TODO Auto-generated method stub
		return delete("delete", seqno);
	}

	@Override
	public TestBoardVO list_rno(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return selectOne("list_rno", vo);
	}

	@Override
	public TestBoardVO find_id(TestBoardVO vo) throws Exception {
		return selectOne("find_id", vo);
	}

	@Override
	public TestBoardVO ragedate_id(TestBoardVO vo) throws Exception {
		return selectOne("ragedate_id", vo);
	}

	@Override
	public int pw_re(TestBoardVO vo) throws Exception {
		return update("pw_re", vo);
	}

	@Override
	public TestBoardVO user_info(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return selectOne("user_info", vo);
	}

	@Override
	public int neck_re(TestBoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return update("neck_re", vo);
	}

	@Override
	public TestBoardVO pw_riar(TestBoardVO vo) throws Exception {
		return selectOne("pw_riar", vo);
	}

	@Override
	public int pw_delete(TestBoardVO vo) throws Exception {
		return delete("pw_delete", vo);
	}
	
}
