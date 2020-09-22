package hans.test.Board;

import java.util.List;

import egovframework.let.cop.bbs.service.BoardVO;

public interface TestBoardService {
	List<TestBoardVO> selectAll() throws Exception;
	TestBoardVO selectBoard(TestBoardVO vo) throws Exception;
	int updateBoard(TestBoardVO vo) throws Exception;
	int insertBoard(TestBoardVO vo) throws Exception;
	int deleteBoard(TestBoardVO vo) throws Exception;
	int insertJoin(TestBoardVO vo) throws Exception;
	int updateJoin(TestBoardVO vo) throws Exception;
	TestBoardVO selectLogin(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> listCriteria(Criteria cri) throws Exception;
	public BoardVO read(Integer bno)throws Exception;
	public void regist(BoardVO boader)throws Exception;
	public void modify(BoardVO boader)throws Exception;
	public void remove(Integer bno)throws Exception;
	public List<BoardVO> listAll() throws Exception;
	
	int listCountCriteria(Criteria cri)throws Exception;

	TestBoardVO selectidChack(TestBoardVO vo) throws Exception;
	
	TestBoardVO insertImg(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> selectName(TestBoardVO vo) throws Exception;
	
	boolean idCheck(TestBoardVO vo) throws Exception;

}
