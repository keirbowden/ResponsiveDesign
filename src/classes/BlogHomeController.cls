public with sharing class BlogHomeController 
{
	private Integer offset {get;set;}
	public transient List<BlogWrapper> blogWrappers {get; set;}
	public String comname {get; set;} 
	public String combody {get; set;}
	public String comblogid {get; set;}
	public String searchStr {get; set;}
	
	public BlogHomeController()
	{
		offset=0;
		setupBlogs();
	}
	
	private void setupBlogs()
	{
		setupBlogs(null);
	}
	
	private void setupBlogs(List<Blog_Post__c> posts)
	{
		if (null==blogWrappers)
		{
			blogWrappers=new List<BlogWrapper>(); 
		
			String query='select id, Name, Content__c, Date_Posted__c, Author__r.Name, Small_Image_Id__c, Medium_Image_Id__c, Large_Image_Id__c, ' +
				   		' 	  (select Name__c, Email__c, Body__c, Posted__c from Blog_Comments__r order by Posted__c desc) ' +  
			   			'				from Blog_Post__c ' +
			   			'				where Status__c=\'Published\' ';
			if (null!=posts)
			{
				query+=' and id IN :posts ';
			}
		
			query+='				order by Date_Posted__c desc limit 5 offset :offset ';
		
			List<Blog_Post__c> blogs=Database.query(query);

			for (Blog_Post__c blog : blogs)
			{
				BlogWrapper wrap=new BlogWrapper(blog);
				blogWrappers.add(wrap);
			}
		}
	}
	
	public void addComment()
	{
		Blog_Comment__c comment=new Blog_Comment__c();
		comment.Blog_Post__c=comblogid;
		comment.Name__c=comname;
		comment.Body__c=combody;
		comment.Posted__c=System.now();
		
		insert comment;
		
		setupBlogs();
	}
	
	public void doSearch()
	{
		List<List<Blog_Post__c>> allObjs=[find :searchStr returning Blog_Post__c(id) limit 5];
		setupBlogs(allObjs[0]);
	}
	
	public class BlogWrapper
	{
		public Blog_Post__c blog {get; set;}
		public Integer commentCount {get; set;}
		
		public BlogWrapper(Blog_Post__c inBlog)
		{
			blog=inBlog;
			commentCount=blog.Blog_Comments__r.size();
		}
	}
}