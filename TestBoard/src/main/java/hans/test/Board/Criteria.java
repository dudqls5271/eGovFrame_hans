package hans.test.Board;

public class Criteria {
      
   private int page = 1;
   private int perPageNum = 10;
   
   public void setPage(int page) {
      if(page <= 0) {
         this.page = 1;
         return;
      }
      
      this.page = page;
   }
   
   public void setPerPageNum(int perPageNum) {
      
      if(perPageNum <= 0 || perPageNum > 100) {
         this.perPageNum = 10;
         return;
      }
      
      this.perPageNum = perPageNum;
   }
   
   public int getPage() {
      
         return page;
   }
   
   //method for Mybatis sql mapper
   public int getPageStart() {
         
      return (this.page - 1) * perPageNum;
   }
   
   //method for MyBatis sql mapper
   public int getPerPageNum() {
      
      return this.perPageNum;
   }
   
	private String searchType;
	private String keyword;
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
   
   
   

@Override
public String toString() {
	return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]"
			+ "SearchCriteria [searchType=\" + searchType + \", keyword=\" + keyword + \"]";
}
   
}