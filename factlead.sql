
select * 
from 
(
select count(LEadId) lead
from OAWarehouse..Fact_Lead
where DateLeadCreated >= '2021-05-01'
and MarketSubChannelId = 5
)L
left join 
(
select count(LEadId) intros
from OAWarehouse..Fact_Lead
where DateLeadHotIntro >= '2021-05-01'
and MarketSubChannelId = 5
)