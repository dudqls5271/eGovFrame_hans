package hans.test.Board;

import java.util.List;

import egovframework.let.cop.bbs.service.BoardVO;

public interface TestBoardDAO {
	List<TestBoardVO> selectAll() throws Exception;
	TestBoardVO selectBoard(TestBoardVO vo) throws Exception;
	int updateBoard(TestBoardVO vo) throws Exception;
	int insertBoard(TestBoardVO vo) throws Exception;
	int deleteBoard(TestBoardVO vo) throws Exception;
	int updateJoin(TestBoardVO vo) throws Exception;
	int insertJoin(TestBoardVO vo) throws Exception;
	TestBoardVO selectLogin(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> listPage(int page) throws Exception;
	List<TestBoardVO> listAll()throws Exception;
	
	List<TestBoardVO> listCriteria(Criteria cri) throws Exception;
	
	List<BoardVO> listSearch(SearchCriteria cri)throws Exception;
	int listSearchCount(SearchCriteria cri)throws Exception;
	
	int countPaging(Criteria cri) throws Exception;

	TestBoardVO selectidChack(TestBoardVO vo) throws Exception;
	
	int updateImg(TestBoardVO vo) throws Exception;
	
	TestBoardVO pw_ch(TestBoardVO vo) throws Exception;
	
	TestBoardVO selectBoardModify(TestBoardVO vo) throws Exception;
	
	TestBoardVO insertImg(TestBoardVO vo) throws Exception;
	List<TestBoardVO> selectName(TestBoardVO vo) throws Exception;
	
	
	List<TestBoardVO> list(Integer bno) throws Exception;
	
	int create(TestBoardVO vo) throws Exception;
	
	int update(TestBoardVO vo) throws Exception;
	
	int delete (Integer seqno) throws Exception;
	
}
