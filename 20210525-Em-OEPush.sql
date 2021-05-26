
select vcEmail, Suburb, mCLMedianSalePriceLast3MonthsHouse, mCLMedianSalePriceLast3MonthsUnit, Percentile, HouseAndUnitPriceDiff
into #Result
from 
(
select * , NTILE (100) OVER ( order by HouseAndUnitPriceDiff desc )  Percentile
from 
(
select vcEmail, Suburb
, case when iCLSalesLast3MonthsHouse >= 5 then case when mCLMedianSalePriceLast3MonthsHouse >= 200000 then mCLMedianSalePriceLast3MonthsHouse end end mCLMedianSalePriceLast3MonthsHouse
, case when iCLSalesLast3MonthsUnit >= 5 then case when mCLMedianSalePriceLast3MonthsUnit >= 200000 then mCLMedianSalePriceLast3MonthsUnit end   end mCLMedianSalePriceLast3MonthsUnit
, round(1.0*mCLMedianSalePriceLast3MonthsHouse/mCLMedianSalePriceLast3MonthsUnit, 2) HouseAndUnitPriceDiff
from oaanalysis..Dim_VeroUsersSuburbs L 
left join [openagent-dev]..tbl_PostCodeInfo R 
on L.PostCodeId = R.iPostCodeId
where dtCLDateUpdate >= dateadd(month, -1, current_timestamp)
and NumSuburbsForUser = 1
)L 
where mCLMedianSalePriceLast3MonthsHouse is not null 
and mCLMedianSalePriceLast3MonthsUnit is not null 
and mCLMedianSalePriceLast3MonthsHouse <> mCLMedianSalePriceLast3MonthsUnit
)L 
where Percentile between 5 and 95

union

select vcEmail, Suburb, mCLMedianSalePriceLast3MonthsHouse, mCLMedianSalePriceLast3MonthsUnit, Percentile, HouseAndUnitPriceDiff
from 
(
select * , NTILE (100) OVER ( order by HouseAndUnitPriceDiff desc )  Percentile
from 
(
select vcEmail, Suburb
, case when iCLSalesLast3MonthsHouse >= 5 then case when mCLMedianSalePriceLast3MonthsHouse >= 200000 then mCLMedianSalePriceLast3MonthsHouse end end mCLMedianSalePriceLast3MonthsHouse
, case when iCLSalesLast3MonthsUnit >= 5 then case when mCLMedianSalePriceLast3MonthsUnit >= 200000 then mCLMedianSalePriceLast3MonthsUnit end   end mCLMedianSalePriceLast3MonthsUnit
, round(1.0*mCLMedianSalePriceLast3MonthsHouse/mCLMedianSalePriceLast3MonthsUnit, 2) HouseAndUnitPriceDiff
from oaanalysis..Dim_VeroUsersSuburbs L 
left join [openagent-dev]..tbl_PostCodeInfo R 
on L.PostCodeId = R.iPostCodeId
where dtCLDateUpdate >= dateadd(month, -1, current_timestamp)
and NumSuburbsForUser = 1
)L 
where (mCLMedianSalePriceLast3MonthsHouse is null 
or mCLMedianSalePriceLast3MonthsUnit is null)
and not (mCLMedianSalePriceLast3MonthsHouse is null and mCLMedianSalePriceLast3MonthsUnit is null )
)L 
where Percentile between 5 and 95


select distinct top 10  suburb,mCLMedianSalePriceLast3MonthsHouse, mCLMedianSalePriceLast3MonthsUnit, 1.0*mCLMedianSalePriceLast3MonthsHouse/mCLMedianSalePriceLast3MonthsUnit Proportion
from #Result
order by Proportion asc

select vcEmail, Suburb, mCLMedianSalePriceLast3MonthsHouse, mCLMedianSalePriceLast3MonthsUnit
from #Result


select *
from 
(
select vcEmail, Suburb
, dAverageSalePrice
from oaanalysis..Dim_VeroUsersSuburbs L 
left join [openagent-dev]..tbl_PostCodeInfo R 
on L.PostCodeId = R.iPostCodeId
where dtCLDateUpdate >= dateadd(month, -1, current_timestamp)
and NumSuburbsForUser = 1
)L 
where dAverageSalePrice >= 100000
order by 2 


SELECT COUNT(DISTINCT COALESCE(L.iVisitorId, L.iUserId)) Users, COUNT(*) Captures
FROM [openagent-dev].[dbo].[tbl_UserPropertyAddressMapping] L
LEFT JOIN [openagent-dev].[dbo].[tbl_UserPropertyAddressAVMMapping] R
ON L.iUserPropertyAddressMappingId = R.iUserPropertyAddressMappingId
WHERE R.iUserPropertyAddressAvmMappingId IS NOT NULL
AND L.dtCreatedDate < '2021-06-01'
