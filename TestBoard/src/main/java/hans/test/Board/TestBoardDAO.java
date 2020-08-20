package hans.test.Board;

import java.util.List;

public interface TestBoardDAO {
	List<TestBoardVO> selectAll() throws Exception;
	TestBoardVO selectBoard(TestBoardVO vo) throws Exception;
	int updateBoard(TestBoardVO vo) throws Exception;
	int insertBoard(TestBoardVO vo) throws Exception;
	int deleteBoard(TestBoardVO vo) throws Exception;
	int updateJoin(TestBoardVO vo) throws Exception;
	int insertJoin(TestBoardVO vo) throws Exception;
	TestBoardVO selectLogin(TestBoardVO vo) throws Exception;

	TestBoardVO selectidChack(TestBoardVO vo) throws Exception;
}
