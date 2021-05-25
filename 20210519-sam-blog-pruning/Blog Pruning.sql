select ArticleTitle
, SecondPath
, min(CreatedDate)MinCreatedDate
, max(CreatedDate)MaxCreatedDate
, min(ModifiedDate)MinModifiedDate
, max(ModifiedDate)MaxModifiedDate
, ArticleId 
, sum(GAInteractions)GAInteractions
, sum(GALeads) GALeads
, sum(GAHots) GAHots
, sum(Interactions) Interactions
, sum(Leads) Leads
, sum(Hots) Hots
, sum(Sessions) Sessions
into #Result
from OAWarehouse..fact_GAPagePathSplit
where FirstPath = 'blog'
and Date >= dateadd(month, -6, current_timestamp)
group by ArticleTitle
, SecondPath
, ArticleId

drop table #Result

select ArticleTitle
, SecondPath
, AuthorSlug
, PrimaryArticlecategorySlug
, SecondaryCategoryList
, ArticleStatusType
, min(CreatedDate)MinCreatedDate
, max(CreatedDate)MaxCreatedDate
, min(ModifiedDate)MinModifiedDate
, max(ModifiedDate)MaxModifiedDate
, ArticleId 
, sum(GAInteractions)GAInteractions
, sum(GALeads) GALeads
, sum(GAHots) GAHots
, sum(Interactions) Interactions
, sum(Leads) Leads
, sum(Hots) Hots
, sum(Sessions) Sessions
into #Result
from OAWarehouse..fact_GAPagePathSplit
where FirstPath = 'blog'
and Date >= dateadd(month, -6, current_timestamp)
group by ArticleTitle
, SecondPath
, ArticleId
, AuthorSlug
, PrimaryArticlecategorySlug
, SecondaryCategoryList
, ArticleStatusType



select * 
from OAWarehouse..fact_GAPageComplete
where pagepath like '%amp/%'
and gaPageCompleteId > 125000000

where FirstPath like '%amp%'
and Date >= dateadd(month, -6, current_timestamp)

select * 
from OAWarehouse..Dim_interactionProfile L 
left join OAWarehouse..fact_Interaction R 
on L.InteractionId = R.Interactionid
where landingpageURl like '%amp%'
and marketsubChannel = 'SEo Non Brand'


select dateadd(month, -6, current_timestamp)

select ArticleTitle ArticleName
, concat('https://www.openagent.com.au/blog/', SecondPath) ArticleURL
, SecondPath
, AuthorSlug Author
, ArticleStatusType ArticleStatus
, PrimaryArticlecategorySlug PrimaryCategory
, SecondaryCategoryList SubCategories
, MinCreatedDate DateFirstPublished
, MinModifiedDate DateUpdated
, ArticleId
, Interactions
, Leads
, Hots
, Sessions
from #Result L 
where articleId is not null
order by minCreatedDate desc


select iArticleId, vcAuthorName, 
 FROM [openagent-dev]..tbl_Article L
LEFT JOIN [openagent-dev]..tbl_ArticleAuthor R
ON L.iArticleAuthorId = R.iArticleAuthorId
LEFT JOIN [openagent-dev]..tbl_ArticleCategory CAT
ON L.iPrimaryArticleCategoryId = CAT.iArticleCategoryId