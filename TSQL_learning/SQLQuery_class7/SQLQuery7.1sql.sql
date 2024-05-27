-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
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
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION calculateLoanDue
(
	@principal_amount int, 
	@interest_rate float
)
RETURNS int
AS
BEGIN
	DECLARE @loan_due int;
		SET @loan_due = (@principal_amount * @interest_rate) / 100;
	RETURN @loan_due;
END
GO

-- Calling the function
SELECT dbo.calculateLoanDue(1000, 5.5) AS LoanDueAmount;
