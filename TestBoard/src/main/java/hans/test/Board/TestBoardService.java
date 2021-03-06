package hans.test.Board;

import java.io.File;
import java.util.List;

import egovframework.let.cop.bbs.service.BoardVO;

public interface TestBoardService {
	List<TestBoardVO> selectAll() throws Exception;
	TestBoardVO selectBoard(TestBoardVO vo) throws Exception;
	
	int list_rno(TestBoardVO vo) throws Exception;
	int updateBoard(TestBoardVO vo) throws Exception;
	int insertBoard(TestBoardVO vo) throws Exception;
	int deleteBoard(TestBoardVO vo) throws Exception;
	int insertJoin(TestBoardVO vo) throws Exception;
	int updateJoin(TestBoardVO vo) throws Exception;
	int pw_re(TestBoardVO vo) throws Exception;
	int neck_re(TestBoardVO vo) throws Exception;
	int pw_delete(TestBoardVO vo) throws Exception;
	
	TestBoardVO pw_riar(TestBoardVO vo) throws Exception;
	TestBoardVO find_id(TestBoardVO vo) throws Exception;
	TestBoardVO selectLogin(TestBoardVO vo) throws Exception;
	TestBoardVO ragedate_id(TestBoardVO vo) throws Exception;
	
	TestBoardVO user_info(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> listCriteria(Criteria cri) throws Exception;
	public BoardVO read(Integer bno)throws Exception;
	public void regist(BoardVO boader)throws Exception;
	public void modify(BoardVO boader)throws Exception;
	public void remove(Integer bno)throws Exception;
	public List<BoardVO> listAll() throws Exception;
	
	int listCountCriteria(Criteria cri)throws Exception;

	TestBoardVO selectidChack(TestBoardVO vo) throws Exception;
	
	TestBoardVO pw_ch(TestBoardVO vo) throws Exception;
	
	TestBoardVO selectBoardModify(TestBoardVO vo) throws Exception;
	int updateImg(TestBoardVO vo) throws Exception;
	
	TestBoardVO insertImg(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> selectName(TestBoardVO vo) throws Exception;
	
	boolean idCheck(TestBoardVO vo) throws Exception;
	
	List<TestBoardVO> list(Integer bno) throws Exception;
	
	int create(TestBoardVO vo) throws Exception;
	
	int update(TestBoardVO vo) throws Exception;
	
	int delete (Integer rno) throws Exception;
	static void excelUpload(File destFile) {
		// TODO Auto-generated method stub
		
	}

}
