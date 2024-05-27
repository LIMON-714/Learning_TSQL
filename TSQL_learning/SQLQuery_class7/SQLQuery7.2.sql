-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION Findmember 
(
	@pencipal_amount int
)
RETURNS 
@temploan TABLE 
(
	member_number varchar(50),
	pencipal_amount int,
	interest_rate float
)
AS
BEGIN
	insert into @temploan
	select* from loan
	where  pencipal_amount>@pencipal_amount
	RETURN 
END
GO
use TSQL2012;
select * from dbo.Findmember(5000);