USE [lkdb]
GO
/****** Object:  StoredProcedure [dbo].[Sys_CauseSuggestionadd]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Sys_CauseSuggestionadd]
(
    @CauseContent nvarchar(500),
	@ParentId int,
	@Sort int,
	@CauseCode nvarchar(50),
	@SuggestionContent nvarchar(500),
	@RelatedContent nvarchar(500),
	@CreateTime datetime,
	@CreateUserId int,
    @CreateUserName nvarchar(50)

) AS
DECLARE @CauseLevel as int
SET @CauseLevel=
(
	select CauseLevel from Sys_CauseSuggestion where CauseId=@ParentId
)
if @CauseLevel is null
	begin
		set @CauseLevel=0
	end

INSERT INTO [dbo].[Sys_CauseSuggestion]
           ([CauseContent]
           ,[ParentId]
           ,[Code]
           ,[Sort]
           ,[CauseLevel]
           ,[CauseCode]
           ,[SuggestionContent]
           ,[RelatedContent]
           ,[CreateTime]
           ,[CreateUserId]
           ,[CreateUserName])
     VALUES
	 (
	   @CauseContent,
	   @ParentId,
	  '',
	   @Sort,
	   @CauseLevel+1,
	   @CauseCode,
	   @SuggestionContent,
	   @RelatedContent,
	   @CreateTime,
	   @CreateUserId,
	   @CreateUserName
	 )

	 DECLARE @Code as varchar(50)
SET @Code=
(
	select Code from Sys_CauseSuggestion where CauseId=@ParentId
)

if @Code is null
	begin
		Update
					Sys_CauseSuggestion
		Set
					Code = '.'+ltrim(str(@@Identity))+'.'
		WHERE
					CauseId = @@Identity
	end
else
	begin
		Update
					Sys_CauseSuggestion
		Set
					Code =@Code+ltrim(str(@@Identity))+'.'
		WHERE
					CauseId = @@Identity
	end



RETURN @@Identity











GO
/****** Object:  Table [dbo].[BaseUser]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Account] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[RealName] [nvarchar](20) NULL,
	[Gender] [nvarchar](10) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Telephone] [nvarchar](20) NULL,
	[OICQ] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[ChangePasswordDate] [datetime] NULL,
	[LogOnCount] [int] NULL,
	[FirstVisit] [datetime] NULL,
	[PreviousVisit] [datetime] NULL,
	[LastVisit] [datetime] NULL,
	[AuditStatus] [int] NULL,
	[AuditUserId] [int] NULL,
	[AuditUserName] [nvarchar](50) NULL,
	[AuditDateTime] [datetime] NULL,
	[Remark] [nvarchar](100) NULL,
	[Enabled] [int] NULL,
	[SortCode] [int] NULL,
	[DeleteMark] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NULL,
	[CreateUserName] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUserId] [int] NULL,
	[ModifyUserName] [nvarchar](50) NULL,
	[IsDelete] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[C_ClubActivityInfo]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C_ClubActivityInfo](
	[ClubActivityInfoId] [int] IDENTITY(1,1) NOT NULL,
	[ClubName] [nvarchar](50) NOT NULL,
	[ClubActivityTypeId] [int] NOT NULL,
	[ActivityDate] [date] NOT NULL,
	[ActivityCost] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[IsShow] [int] NOT NULL,
	[IsDelete] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_C_ClubActivityInfo] PRIMARY KEY CLUSTERED 
(
	[ClubActivityInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[C_ClubActivityType]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C_ClubActivityType](
	[ClubActivityTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ClubActivityTypeName] [nvarchar](50) NOT NULL,
	[SortCode] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[IsShow] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[IsDelete] [int] NOT NULL,
 CONSTRAINT [PK_C_ClubActivityType] PRIMARY KEY CLUSTERED 
(
	[ClubActivityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[C_ClubInfo]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C_ClubInfo](
	[ClubInfoId] [int] IDENTITY(1,1) NOT NULL,
	[ClubDate] [date] NOT NULL,
	[BuildedClubNumber] [int] NOT NULL,
	[PlaneBuilderClubNumber] [int] NOT NULL,
	[NotBuilderClubNumber] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsShow] [int] NOT NULL,
	[IsDelete] [int] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[ActivitAreaId] [int] NOT NULL,
 CONSTRAINT [PK_C_ClubInfo] PRIMARY KEY CLUSTERED 
(
	[ClubInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Module]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Module](
	[ModuleId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](50) NOT NULL,
	[ParentId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Sort] [int] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[ControllerName] [varchar](50) NULL,
	[ActionName] [varchar](50) NULL,
	[Code] [nvarchar](100) NULL,
	[Icon] [nvarchar](50) NULL,
	[ModuleLevel] [int] NULL,
	[IsShow] [int] NULL,
 CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ModuleOperate]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleOperate](
	[ModuleOperateId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleOperateName] [nvarchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[Enabled] [int] NOT NULL,
	[ModuleId] [int] NOT NULL,
	[JsEvent] [nvarchar](50) NULL,
	[Icon] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_ModuleOperate] PRIMARY KEY CLUSTERED 
(
	[ModuleOperateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ModuleOperateRole]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleOperateRole](
	[ModuleOperateRoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[ModuleOperateId] [int] NOT NULL,
 CONSTRAINT [PK_ModuleOperateRole] PRIMARY KEY CLUSTERED 
(
	[ModuleOperateRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ModuleRole]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleRole](
	[ModuleRoleId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_ModuleRole] PRIMARY KEY CLUSTERED 
(
	[ModuleRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Remark] [nvarchar](50) NULL,
	[DeleteMark] [int] NULL,
	[CreateUserName] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUserId] [int] NULL,
	[ModifyUserName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ep] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysLog]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysLog](
	[SysLogId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NULL,
	[IPAddress] [varchar](50) NULL,
	[IPAddressName] [nvarchar](100) NULL,
	[LogType] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NULL,
	[CreateUserName] [nvarchar](50) NULL,
	[Remark] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[ObjectId] [nvarchar](50) NULL,
 CONSTRAINT [PK_SysLog] PRIMARY KEY CLUSTERED 
(
	[SysLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SysLogDetail]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysLogDetail](
	[SysLogDetailId] [int] IDENTITY(1,1) NOT NULL,
	[SysLogId] [int] NOT NULL,
	[PropertyName] [nvarchar](50) NULL,
	[PropertyField] [nvarchar](50) NULL,
	[NewValue] [nvarchar](1000) NULL,
	[OldValue] [nvarchar](1000) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SysLOgDetail] PRIMARY KEY CLUSTERED 
(
	[SysLogDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_ActivityArea]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_ActivityArea](
	[ActivitAreaId] [int] IDENTITY(1,1) NOT NULL,
	[ActivityAreaName] [nvarchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[SortCode] [int] NOT NULL,
	[IsShow] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[IsDelete] [int] NULL,
 CONSTRAINT [PK_T_ActivityArea] PRIMARY KEY CLUSTERED 
(
	[ActivitAreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Agency]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Agency](
	[AgencyId] [int] IDENTITY(1,1) NOT NULL,
	[AgencyName] [nvarchar](100) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[IsShow] [int] NOT NULL,
	[IsDelete] [int] NOT NULL,
	[SortCode] [int] NOT NULL,
 CONSTRAINT [PK_T_Agency] PRIMARY KEY CLUSTERED 
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SaleActivity]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SaleActivity](
	[SaleActivityId] [int] IDENTITY(1,1) NOT NULL,
	[AgencyId] [int] NOT NULL,
	[AreaId] [int] NOT NULL,
	[ActivityDate] [date] NOT NULL,
	[SaleActivityTypeId] [int] NOT NULL,
	[PassengerFlow] [int] NOT NULL,
	[LatentPassengerFlow] [int] NOT NULL,
	[CarOwner] [int] NOT NULL,
	[OrderQuantity] [int] NOT NULL,
	[PrimeCost] [int] NOT NULL,
	[LaterOrderQuantity] [int] NOT NULL,
	[PublishWay] [nvarchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[ActivityName] [nvarchar](100) NULL,
	[IsShow] [int] NOT NULL,
	[IsDelete] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_SaleActivity] PRIMARY KEY CLUSTERED 
(
	[SaleActivityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SaleActivityType]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SaleActivityType](
	[SaleActivityTypeId] [int] IDENTITY(1,1) NOT NULL,
	[SaleActivityTypeName] [nvarchar](50) NOT NULL,
	[SortCode] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[IsShow] [int] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[IsDelete] [int] NOT NULL,
 CONSTRAINT [PK_T_SaleActivityType] PRIMARY KEY CLUSTERED 
(
	[SaleActivityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[C_ClubActivityInfoView]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C_ClubActivityInfoView]
AS
SELECT   dbo.C_ClubActivityType.ClubActivityTypeName, dbo.C_ClubActivityInfo.*
FROM      dbo.C_ClubActivityInfo INNER JOIN
                dbo.C_ClubActivityType ON dbo.C_ClubActivityInfo.ClubActivityTypeId = dbo.C_ClubActivityType.ClubActivityTypeId

GO
/****** Object:  View [dbo].[C_ClubInfoView]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C_ClubInfoView]
AS
SELECT   dbo.C_ClubInfo.*, dbo.T_ActivityArea.ActivityAreaName
FROM      dbo.C_ClubInfo INNER JOIN
                dbo.T_ActivityArea ON dbo.C_ClubInfo.ActivitAreaId = dbo.T_ActivityArea.ActivitAreaId

GO
/****** Object:  View [dbo].[View_Activity]    Script Date: 2018/1/15 18:28:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Activity]
AS
SELECT   dbo.T_SaleActivityType.SaleActivityTypeName, dbo.T_Agency.AgencyName, dbo.T_SaleActivity.AgencyId, 
                dbo.T_SaleActivity.AreaId, dbo.T_SaleActivity.SaleActivityTypeId, dbo.T_SaleActivity.PassengerFlow, 
                dbo.T_SaleActivity.LatentPassengerFlow, dbo.T_SaleActivity.CarOwner, dbo.T_SaleActivity.OrderQuantity, 
                dbo.T_SaleActivity.PrimeCost, dbo.T_SaleActivity.LaterOrderQuantity, dbo.T_SaleActivity.PublishWay, 
                dbo.T_SaleActivity.CreateTime, dbo.T_SaleActivity.CreateUserId, dbo.T_SaleActivity.IsShow, 
                dbo.T_SaleActivity.IsDelete, dbo.T_SaleActivity.ActivityDate, dbo.T_SaleActivity.SaleActivityId, 
                dbo.T_ActivityArea.ActivityAreaName
FROM      dbo.T_SaleActivity INNER JOIN
                dbo.T_SaleActivityType ON 
                dbo.T_SaleActivity.SaleActivityTypeId = dbo.T_SaleActivityType.SaleActivityTypeId INNER JOIN
                dbo.T_Agency ON dbo.T_SaleActivity.AgencyId = dbo.T_Agency.AgencyId INNER JOIN
                dbo.T_ActivityArea ON dbo.T_SaleActivity.AreaId = dbo.T_ActivityArea.ActivitAreaId

GO
SET IDENTITY_INSERT [dbo].[BaseUser] ON 

INSERT [dbo].[BaseUser] ([UserId], [Account], [UserPassword], [Code], [RealName], [Gender], [Mobile], [Telephone], [OICQ], [Email], [ChangePasswordDate], [LogOnCount], [FirstVisit], [PreviousVisit], [LastVisit], [AuditStatus], [AuditUserId], [AuditUserName], [AuditDateTime], [Remark], [Enabled], [SortCode], [DeleteMark], [CreateTime], [CreateUserId], [CreateUserName], [ModifyDate], [ModifyUserId], [ModifyUserName], [IsDelete]) VALUES (1, N'小明', N'123456', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, CAST(0x0000A7CF00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[BaseUser] ([UserId], [Account], [UserPassword], [Code], [RealName], [Gender], [Mobile], [Telephone], [OICQ], [Email], [ChangePasswordDate], [LogOnCount], [FirstVisit], [PreviousVisit], [LastVisit], [AuditStatus], [AuditUserId], [AuditUserName], [AuditDateTime], [Remark], [Enabled], [SortCode], [DeleteMark], [CreateTime], [CreateUserId], [CreateUserName], [ModifyDate], [ModifyUserId], [ModifyUserName], [IsDelete]) VALUES (17, N'admin', N'43abc3cd22c649e5c2ee33fdf638072f', NULL, NULL, NULL, N'18516717582', NULL, NULL, N'lishuguang1990@126.com', NULL, 1, NULL, CAST(0x0000A86600B949D4 AS DateTime), CAST(0x0000A869009D42CA AS DateTime), 0, NULL, NULL, NULL, NULL, 1, 0, 0, CAST(0x0000A7D100FE8ECC AS DateTime), 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[BaseUser] ([UserId], [Account], [UserPassword], [Code], [RealName], [Gender], [Mobile], [Telephone], [OICQ], [Email], [ChangePasswordDate], [LogOnCount], [FirstVisit], [PreviousVisit], [LastVisit], [AuditStatus], [AuditUserId], [AuditUserName], [AuditDateTime], [Remark], [Enabled], [SortCode], [DeleteMark], [CreateTime], [CreateUserId], [CreateUserName], [ModifyDate], [ModifyUserId], [ModifyUserName], [IsDelete]) VALUES (19, N'小刚', N'f55c2e0cf602051e382e29c1c8e89b84', NULL, NULL, NULL, N'18516717582', NULL, NULL, N'15666@qq.com', NULL, 1, NULL, CAST(0x0000A86300ABB40B AS DateTime), CAST(0x0000A86300ABC74F AS DateTime), 0, NULL, NULL, NULL, N'测试数据', 1, 0, 0, CAST(0x0000A86300A5DA34 AS DateTime), 17, N'admin', NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[BaseUser] OFF
SET IDENTITY_INSERT [dbo].[C_ClubActivityInfo] ON 

INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (1, N'火箭俱乐部', 3, CAST(0xC93D0B00 AS Date), 522, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (2, N'马刺俱乐部', 3, CAST(0xC93D0B00 AS Date), 944, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (3, N'勇士俱乐部', 4, CAST(0xE83D0B00 AS Date), 300, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (4, N'雷霆俱乐部', 4, CAST(0xE83D0B00 AS Date), 200, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (5, N'凯尔特人俱乐部', 5, CAST(0x043E0B00 AS Date), 877, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (6, N'骑士俱乐部', 3, CAST(0x233E0B00 AS Date), 99, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
INSERT [dbo].[C_ClubActivityInfo] ([ClubActivityInfoId], [ClubName], [ClubActivityTypeId], [ActivityDate], [ActivityCost], [CreateTime], [CreateUserId], [IsShow], [IsDelete], [CreateUserName]) VALUES (7, N'猛龙俱乐部', 5, CAST(0x413E0B00 AS Date), 113, CAST(0x0000A86500EDCA38 AS DateTime), 17, 1, 0, N'admin')
SET IDENTITY_INSERT [dbo].[C_ClubActivityInfo] OFF
SET IDENTITY_INSERT [dbo].[C_ClubActivityType] ON 

INSERT [dbo].[C_ClubActivityType] ([ClubActivityTypeId], [ClubActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (3, N'自驾游', 1, CAST(0x0000A86500C0E6D0 AS DateTime), 17, 1, N'admin', 0)
INSERT [dbo].[C_ClubActivityType] ([ClubActivityTypeId], [ClubActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (4, N'讲堂', 2, CAST(0x0000A86500C0FF6C AS DateTime), 17, 1, N'admin', 0)
INSERT [dbo].[C_ClubActivityType] ([ClubActivityTypeId], [ClubActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (5, N'其他类', 3, CAST(0x0000A86500D31454 AS DateTime), 17, 1, N'admin', 0)
SET IDENTITY_INSERT [dbo].[C_ClubActivityType] OFF
SET IDENTITY_INSERT [dbo].[C_ClubInfo] ON 

INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (1, CAST(0xBF3D0B00 AS Date), 2, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (2, CAST(0xBF3D0B00 AS Date), 3, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (3, CAST(0xBF3D0B00 AS Date), 4, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (4, CAST(0xBF3D0B00 AS Date), 5, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (5, CAST(0xBF3D0B00 AS Date), 6, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (6, CAST(0xBF3D0B00 AS Date), 7, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
INSERT [dbo].[C_ClubInfo] ([ClubInfoId], [ClubDate], [BuildedClubNumber], [PlaneBuilderClubNumber], [NotBuilderClubNumber], [CreateTime], [IsShow], [IsDelete], [CreateUserId], [CreateUserName], [ActivitAreaId]) VALUES (7, CAST(0xBF3D0B00 AS Date), 8, 3, 2, CAST(0x0000A86600B7BF10 AS DateTime), 0, 0, 17, N'admin', 1)
SET IDENTITY_INSERT [dbo].[C_ClubInfo] OFF
SET IDENTITY_INSERT [dbo].[Module] ON 

INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1, N'系统设置', 0, CAST(0x0000A7EF009D9824 AS DateTime), 1, 17, N'System', NULL, N'1', N'&#xe62e;', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (2, N'用户管理', 1, CAST(0x0000A7EF009CBAA8 AS DateTime), 2, 17, N'System', N'UserManage', N'1,2', N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (3, N'模块管理', 1, CAST(0x0000A7EF009CD344 AS DateTime), 3, 17, N'System', N'ModuleManage', N'1,3', N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (4, N'角色管理', 1, CAST(0x0000A7EF009E2AA0 AS DateTime), 6, 17, N'System', N'RoleManage', N'1,4', N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (5, N'模块按钮', 1, CAST(0x0000A7EF009D173C AS DateTime), 4, 17, N'System', N'OperateManage', NULL, NULL, 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (10, N'日志列表', 1, CAST(0x0000A7EF009D8564 AS DateTime), 5, 17, N'Log', NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1018, N'经销商活动管理', 0, CAST(0x0000A8590106BE1C AS DateTime), 2, 17, N'SaleActivity', NULL, NULL, N'&#xe62e;', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1019, N'经销商活动列表', 1018, CAST(0x0000A8590106EF54 AS DateTime), 0, 17, N'SaleActivity', N'List', NULL, NULL, 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1020, N'区域管理', 1018, CAST(0x0000A86300F31AC4 AS DateTime), 0, 17, N'SaleActivity', N'AreaList', NULL, N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1021, N'活动类型', 1018, CAST(0x0000A86100E08170 AS DateTime), 2, 17, N'SaleActivity', N'TypeList', NULL, N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1022, N'经销商管理', 1018, CAST(0x0000A861010315C8 AS DateTime), 0, 17, N'SaleActivity', N'AgencyList', NULL, NULL, 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1023, N'俱乐部活动管理', 0, CAST(0x0000A86500A0E894 AS DateTime), 5, 17, N'ClubActivity', NULL, NULL, N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1024, N'车主俱乐部概况管理', 1023, CAST(0x0000A86500A34544 AS DateTime), 0, 17, N'ClubActivity', N'ClubInfoList', NULL, N'', 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1025, N'车主俱乐部活动管理', 1023, CAST(0x0000A86500A394F4 AS DateTime), 1, 17, N'ClubActivity', N'ClubActivityList', NULL, NULL, 0, 1)
INSERT [dbo].[Module] ([ModuleId], [ModuleName], [ParentId], [CreateTime], [Sort], [CreateUserId], [ControllerName], [ActionName], [Code], [Icon], [ModuleLevel], [IsShow]) VALUES (1026, N'车主俱乐部活动类别', 1023, CAST(0x0000A86500A4112C AS DateTime), 2, 17, N'ClubActivity', N'ClubTypeList', NULL, NULL, 0, 1)
SET IDENTITY_INSERT [dbo].[Module] OFF
SET IDENTITY_INSERT [dbo].[ModuleOperate] ON 

INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (5, N'添加', CAST(0x0000A7ED0119E53C AS DateTime), 17, N'admin', 1, 2, N'btn_add()', N'&#xe600', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (11, N'编辑', CAST(0x0000A7ED0119FB80 AS DateTime), 17, N'admin', 1, 2, N'btn_edit()', N'&#xe60c', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (12, N'添加', CAST(0x0000A7EF00928C68 AS DateTime), 17, N'admin', 1, 3, N'btn_add()', N'&#xe600', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (13, N'添加', CAST(0x0000A7ED011A19F8 AS DateTime), 17, N'admin', 1, 5, N'btn_add()', N'&#xe600', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (14, N'编辑	', CAST(0x0000A7ED011A03B4 AS DateTime), 17, N'admin', 1, 5, N'btn_edit()	', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (15, N'删除', CAST(0x0000A7ED011A9888 AS DateTime), 17, N'admin', 1, 5, N'btn_del()', N'&#xe6e2', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (16, N'添加', CAST(0x0000A7E400C28DDC AS DateTime), 17, N'admin', 1, 4, N'btn_add()', N'&#xe600', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (17, N'修改', CAST(0x0000A7E400F71AFC AS DateTime), 17, N'admin', 1, 4, N'btn_edit()', N'&#xe60c', NULL, 2)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (18, N'删除', CAST(0x0000A7E400F74400 AS DateTime), 17, N'admin', 1, 4, N'btn_del()', N'&#xe6e2', NULL, 3)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (20, N'赋权', CAST(0x0000A7E400FBFB08 AS DateTime), 17, N'admin', 1, 4, N'btn_power()', N'&#xe61f', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1018, N'禁用', CAST(0x0000A86300A02ABC AS DateTime), 17, N'admin', 1, 2, N'btn_disabled()', N'&#xe60e', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1019, N'修改', CAST(0x0000A7EF0092BFF8 AS DateTime), 17, N'admin', 1, 3, N'btn_edit()', N'&#xe60c', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1021, N'启用', CAST(0x0000A7F80100D664 AS DateTime), 17, N'admin', 0, 2, N'btn_qy()', N'&#xe605', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1028, N'添加', CAST(0x0000A85901076808 AS DateTime), 17, N'admin', 1, 1019, N'btn_add()', N'&#xe600', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1029, N'编辑', CAST(0x0000A85901077744 AS DateTime), 17, N'admin', 1, 1019, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1030, N'添加角色成员', CAST(0x0000A86000EA3828 AS DateTime), 17, N'admin', 1, 4, N'btn_adduser()', N'&#xe607;', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1031, N'添加', CAST(0x0000A86000ED5508 AS DateTime), 17, N'admin', 1, 1020, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1032, N'编辑', CAST(0x0000A86000ED5508 AS DateTime), 17, N'admin', 1, 1020, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1033, N'删除', CAST(0x0000A86000ED5508 AS DateTime), 17, N'admin', 1, 1020, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1034, N'添加', CAST(0x0000A86000EDB778 AS DateTime), 17, N'admin', 1, 1021, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1035, N'编辑', CAST(0x0000A86000EDB778 AS DateTime), 17, N'admin', 1, 1021, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1036, N'删除', CAST(0x0000A86000EDB778 AS DateTime), 17, N'admin', 1, 1021, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1037, N'添加', CAST(0x0000A861010315C8 AS DateTime), 17, N'admin', 1, 1022, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1038, N'编辑', CAST(0x0000A861010315C8 AS DateTime), 17, N'admin', 1, 1022, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1039, N'删除', CAST(0x0000A861010315C8 AS DateTime), 17, N'admin', 1, 1022, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1040, N'删除', CAST(0x0000A863009EA0FC AS DateTime), 17, N'admin', 1, 2, N'btn_del()', N'&#xe6e2', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1041, N'添加', CAST(0x0000A86500A0DE08 AS DateTime), 17, N'admin', 1, 1023, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1042, N'编辑', CAST(0x0000A86500A0DE08 AS DateTime), 17, N'admin', 1, 1023, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1043, N'删除', CAST(0x0000A86500A0DE08 AS DateTime), 17, N'admin', 1, 1023, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1044, N'添加', CAST(0x0000A86500A2F468 AS DateTime), 17, N'admin', 1, 1024, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1045, N'编辑', CAST(0x0000A86500A2F468 AS DateTime), 17, N'admin', 1, 1024, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1046, N'删除', CAST(0x0000A86500A2F468 AS DateTime), 17, N'admin', 1, 1024, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1047, N'添加', CAST(0x0000A86500A394F4 AS DateTime), 17, N'admin', 1, 1025, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1048, N'编辑', CAST(0x0000A86500A394F4 AS DateTime), 17, N'admin', 1, 1025, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1049, N'删除', CAST(0x0000A86500A394F4 AS DateTime), 17, N'admin', 1, 1025, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1050, N'添加', CAST(0x0000A86500A4112C AS DateTime), 17, N'admin', 1, 1026, N'btn_add()', N'&#xe600', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1051, N'编辑', CAST(0x0000A86500A4112C AS DateTime), 17, N'admin', 1, 1026, N'btn_edit()', N'&#xe60c', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1052, N'删除', CAST(0x0000A86500A4112C AS DateTime), 17, N'admin', 1, 1026, N'btn_del()', N'&#xe6e2', NULL, 1)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1053, N'删除', CAST(0x0000A86500F409D4 AS DateTime), 17, N'admin', 1, 1019, N'btn_del()', N'&#xe6e2', NULL, 0)
INSERT [dbo].[ModuleOperate] ([ModuleOperateId], [ModuleOperateName], [CreateTime], [CreateUserId], [CreateUserName], [Enabled], [ModuleId], [JsEvent], [Icon], [Code], [Sort]) VALUES (1054, N'导出', CAST(0x0000A86900F2A594 AS DateTime), 17, N'admin', 1, 1019, N'btn_print()', N'&#xe644', NULL, 0)
SET IDENTITY_INSERT [dbo].[ModuleOperate] OFF
SET IDENTITY_INSERT [dbo].[ModuleOperateRole] ON 

INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2587, 1, 5)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2588, 1, 11)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2589, 1, 1018)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2590, 1, 1021)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2591, 1, 1040)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2592, 1, 12)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2593, 1, 1019)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2594, 1, 16)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2595, 1, 17)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2596, 1, 18)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2597, 1, 20)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2598, 1, 1030)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2599, 1, 13)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2600, 1, 14)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2601, 1, 15)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2602, 1, 1028)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2603, 1, 1029)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2604, 1, 1053)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2605, 1, 1054)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2606, 1, 1031)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2607, 1, 1032)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2608, 1, 1033)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2609, 1, 1034)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2610, 1, 1035)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2611, 1, 1036)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2612, 1, 1037)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2613, 1, 1038)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2614, 1, 1039)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2615, 1, 1044)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2616, 1, 1045)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2617, 1, 1046)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2618, 1, 1047)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2619, 1, 1048)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2620, 1, 1049)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2621, 1, 1050)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2622, 1, 1051)
INSERT [dbo].[ModuleOperateRole] ([ModuleOperateRoleId], [RoleId], [ModuleOperateId]) VALUES (2623, 1, 1052)
SET IDENTITY_INSERT [dbo].[ModuleOperateRole] OFF
SET IDENTITY_INSERT [dbo].[ModuleRole] ON 

INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2363, 1, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2364, 2, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2365, 3, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2366, 4, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2367, 5, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2368, 1018, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2369, 1019, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2370, 1020, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2371, 1021, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2372, 1022, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2373, 1023, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2374, 1024, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2375, 1025, 1)
INSERT [dbo].[ModuleRole] ([ModuleRoleId], [ModuleId], [RoleId]) VALUES (2376, 1026, 1)
SET IDENTITY_INSERT [dbo].[ModuleRole] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName], [CreateTime], [CreateUserId], [Sort], [Code], [Remark], [DeleteMark], [CreateUserName], [ModifyDate], [ModifyUserId], [ModifyUserName]) VALUES (1, N'管理员', CAST(0x0000A7E100000000 AS DateTime), 1, 1, N'01', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[SysLog] ON 

INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1, NULL, N'1', N'1', 1, CAST(0x0000A7C500000000 AS DateTime), 1, N'444', NULL, 0, NULL)
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (3, NULL, NULL, NULL, 1, CAST(0x0000A7D100F7A670 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市IANA保留地址用于本地回送', 1, N'3312321')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4, NULL, NULL, NULL, 1, CAST(0x0000A7D100F7F878 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'789')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (5, NULL, NULL, NULL, 1, CAST(0x0000A7D100F8A138 AS DateTime), NULL, NULL, N'账户锁定、IP所在城市局域网 ', 1, N'33')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (6, NULL, NULL, NULL, 1, CAST(0x0000A7D100F8A390 AS DateTime), NULL, NULL, N'账户锁定、IP所在城市局域网 ', 1, N'33')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (7, NULL, NULL, NULL, 1, CAST(0x0000A7D100F8B524 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'12312')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (8, NULL, NULL, NULL, 1, CAST(0x0000A7D100F8B77C AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'12312')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (9, NULL, NULL, NULL, 1, CAST(0x0000A7D100F8DE28 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'12312')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (10, NULL, NULL, NULL, 1, CAST(0x0000A7D100F90024 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'333')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (11, NULL, NULL, NULL, 1, CAST(0x0000A7D100F95B8C AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'333')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (12, NULL, NULL, NULL, 1, CAST(0x0000A7D100F95F10 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'333')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (13, NULL, NULL, NULL, 1, CAST(0x0000A7D100F963C0 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市局域网 ', 1, N'333')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (14, NULL, NULL, NULL, 1, CAST(0x0000A7D100F999A8 AS DateTime), NULL, NULL, N'账户锁定、IP所在城市局域网 ', 1, N'33')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (15, NULL, NULL, NULL, 1, CAST(0x0000A7D100F99D2C AS DateTime), NULL, NULL, N'账户锁定、IP所在城市局域网 ', 1, N'33')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (16, NULL, NULL, NULL, 1, CAST(0x0000A7D100F9B820 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'1233')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (17, NULL, NULL, NULL, 1, CAST(0x0000A7D100FE1870 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'1233')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (18, NULL, NULL, NULL, 1, CAST(0x0000A7D100FE1F78 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'1233')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (19, NULL, NULL, NULL, 1, CAST(0x0000A7D100FE2428 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'1233')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (20, NULL, NULL, NULL, 1, CAST(0x0000A7D101145EC8 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (21, NULL, NULL, NULL, 1, CAST(0x0000A7D101148DA8 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (22, NULL, NULL, NULL, 1, CAST(0x0000A7D101151214 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (23, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D10116A534 AS DateTime), 17, NULL, N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (24, NULL, NULL, NULL, 1, CAST(0x0000A7D200AC0008 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (25, NULL, NULL, NULL, 1, CAST(0x0000A7D200AC05E4 AS DateTime), NULL, NULL, N'密码错误、IP所在城市局域网 ', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (26, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D200AEA308 AS DateTime), 17, NULL, N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (27, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D300A24824 AS DateTime), 17, NULL, N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (28, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7D300F3CA8C AS DateTime), 17, NULL, N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (29, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7D300F44B74 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (30, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D30103B8AC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (31, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D301050C84 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (32, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7D6009D5EB8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (33, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7D60101F7D8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (34, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7DD00A33608 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (35, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7DE00DE68B8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (36, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7DF00F6D4AC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (37, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7E000EB6A04 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (38, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7E1009A5F24 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (39, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7E40095C7C0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (40, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7E400B95DE8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1036, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7E5009FC84C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1037, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7E500B912E8 AS DateTime), 17, N'admin', N'角色添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1038, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7E500B99E5C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1039, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7E500B9BE00 AS DateTime), 17, N'admin', N'角色添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1040, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7E500BACB88 AS DateTime), 17, N'admin', N'角色添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1041, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7E500BB8960 AS DateTime), 17, N'admin', N'角色添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1042, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7E500BDFC54 AS DateTime), 17, N'admin', N'角色添加', 0, N'1016')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1043, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7E500BE4628 AS DateTime), 17, N'admin', N'角色添加', 0, N'1017')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1049, 4, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7E50112CBA8 AS DateTime), 17, N'admin', N'角色修改', 0, N'4')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1050, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7E600BDCD74 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (1051, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7EB00957360 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2051, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB00B21A24 AS DateTime), 17, N'admin', N'角色删除', 0, N'1007')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2052, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7EB00B5AFB8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2053, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB00E998C8 AS DateTime), 17, N'admin', N'角色删除', 0, N'1011')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2054, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB00F09AEC AS DateTime), 17, N'admin', N'角色删除', 0, N'1016')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2055, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB00F09AEC AS DateTime), 17, N'admin', N'角色删除', 0, N'1017')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2056, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB01097C10 AS DateTime), 17, N'admin', N'角色删除', 0, N'1009')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2057, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB010987C8 AS DateTime), 17, N'admin', N'角色删除', 0, N'1015')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2058, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EB0109AC1C AS DateTime), 17, N'admin', N'角色删除', 0, N'1014')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2059, 4, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7EC0095BE60 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2060, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2061, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2062, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2063, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2064, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2065, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEE5D0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2066, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2067, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2068, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2069, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2070, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2071, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2072, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2073, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2074, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2075, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC00EEFD40 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2076, 4, N'192.168.0.71', N'局域网 ', 3, CAST(0x0000A7EC00EF2644 AS DateTime), 17, N'admin', N'角色删除', 0, N'1006')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2077, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2078, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2079, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2080, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2081, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2082, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2083, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2084, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2085, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2086, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2087, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2088, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2089, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2090, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2091, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2092, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2093, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2094, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2095, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2096, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2097, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2098, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2099, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
GO
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2100, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (2101, 4, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EC0118C170 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (3059, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7ED0093885C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (3060, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7ED0095D4A4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4059, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7ED00C0B91C AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4060, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED00C108CC AS DateTime), 17, N'admin', N'模块操作修改', 0, N'12')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4061, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED011354C4 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'15')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4062, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED0119E53C AS DateTime), 17, N'admin', N'模块操作修改', 0, N'5')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4063, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED0119FB80 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'11')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4064, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED011A03B4 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'14')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4065, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED011A19F8 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'13')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4066, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7ED011A8118 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4067, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED011A9888 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'15')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4068, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7ED011AA698 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1018')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4069, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7EE00AF0C80 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4070, 2, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7EE00AF0C80 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4071, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF009279A8 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'12')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4072, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF00928C68 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'12')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4073, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EF0092AAE0 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4074, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF0092BFF8 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1019')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4075, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EF00942A14 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4076, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF009EBD1C AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1018')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4077, 2, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7EF00B573F4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4078, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EF00C26BE0 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4079, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF00C314A0 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1021')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4080, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF00C32760 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1018')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4081, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7EF01074BE8 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4082, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7EF010759F8 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1022')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4083, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7EF010B3BB8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4084, 1010, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7EF011F19A8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4085, NULL, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7F200913188 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4086, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F200983988 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4087, 5, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F200985800 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4088, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009D5A08 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4089, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009F51F0 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4090, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009F9714 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4091, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009F9BC4 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4092, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FAE84 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4093, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FB7E4 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4094, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FC4C8 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4095, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FDB0C AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4096, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FDE90 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4097, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F2009FF984 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4098, 1011, N'192.168.0.71', N'局域网 ', 1, CAST(0x0000A7F200A01478 AS DateTime), 17, N'admin', N'角色添加', 1, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4099, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200A8393C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4100, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7F200DE8604 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1024')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4101, 5, N'192.168.0.71', N'局域网 ', 2, CAST(0x0000A7F200DEA6D4 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1023')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4102, 4, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7F200E44134 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4103, 1011, N'192.168.0.71', N'局域网 ', 0, CAST(0x0000A7F2010CB060 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4104, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F40173B1E8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4105, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F40177AB18 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4106, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F5000F5820 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4107, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F800968340 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4108, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F800A0D700 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4109, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F800A19730 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4110, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7F800E9E29C AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4111, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A7F800E9F688 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1025')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4112, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7F800F76020 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4113, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A7F800F78474 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1026')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4114, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7F800FD6D58 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4115, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A7F800FD8144 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1027')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4116, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A7F80100BEF4 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1026')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4117, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A7F80100D664 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1021')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4118, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F20010101C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4119, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F200101BD4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4120, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F200104988 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4121, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F200107610 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4122, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F2001088D0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4123, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F200109104 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4124, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F2001096E0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4125, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F20010D9AC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4126, NULL, N'192.168.0.111', N'局域网 ', 1, CAST(0x0000A7F20010EB40 AS DateTime), 17, N'admin', N'密码错误、IP所在城市局域网 ', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4127, NULL, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F20010F11C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4128, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200111ED0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4129, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200112830 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4130, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F2001133E8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4131, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200115134 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4132, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200115260 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4133, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F20011538C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4134, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F2001154B8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4135, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200115F44 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4136, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F20011CFC4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4137, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200126498 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4138, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200126498 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4139, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200127758 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4140, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F200135F60 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4141, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F20013E624 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4142, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F9001442B8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4143, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A7F900147198 AS DateTime), 17, N'admin', N'密码错误、IP所在城市局域网 ', 1, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4144, 1011, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F900147774 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4145, 1011, N'192.168.0.111', N'局域网 ', 0, CAST(0x0000A7F90015516C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市局域网 ', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4146, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A7F90017A390 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4147, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8070170D324 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4148, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8070181C0BC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4149, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8070182D420 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4150, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8070183A134 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4151, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A80701841538 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4152, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A807018515DC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4153, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A80701857270 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4154, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A807018A0D58 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
GO
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4155, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A80800031BB4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4156, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A80800051AA4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4157, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A808000A24E0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4158, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A808000ADA84 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4159, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A808000BA66C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4160, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A808000C5E68 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4161, 1013, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A808000C91F8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4162, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81400FC0B70 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4163, 1016, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81400FF46C8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4164, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8140100B6C0 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4165, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81401215204 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4166, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81401237EA8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4167, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81401256754 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4168, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81401772904 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4169, 1016, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A814017AEB20 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4170, 1011, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A814017B3170 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4171, 1016, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A814017DD59C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4172, 1016, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A81500096F3C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4173, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A83801617E88 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4174, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A83801618DC4 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4175, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8380161F3B8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4176, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A85900F84120 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4177, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A85901072D70 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4178, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A859010751C4 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4179, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A85901076808 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1028')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4180, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A85901077744 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1029')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4181, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A85901101F48 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4182, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000E4D4DC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4183, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000E73894 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4184, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7BD00 AS DateTime), 17, N'admin', N'角色删除', 0, N'1013')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4185, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C084 AS DateTime), 17, N'admin', N'角色删除', 0, N'1012')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4186, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C660 AS DateTime), 17, N'admin', N'角色删除', 0, N'1010')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4187, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C660 AS DateTime), 17, N'admin', N'角色删除', 0, N'1011')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4188, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C9E4 AS DateTime), 17, N'admin', N'角色删除', 0, N'1003')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4189, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C9E4 AS DateTime), 17, N'admin', N'角色删除', 0, N'1004')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4190, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C9E4 AS DateTime), 17, N'admin', N'角色删除', 0, N'1005')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4191, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A86000E7C9E4 AS DateTime), 17, N'admin', N'角色删除', 0, N'1008')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4192, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A86000E9A6D8 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4193, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A86000EA3828 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1030')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4194, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A86000EA72C0 AS DateTime), 17, N'admin', N'角色添加用户', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4195, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000EE3AB8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4196, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000EE929C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4197, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000EFA3A8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4198, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000F03C00 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4199, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86000F2DDD4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4200, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86100D7E2CC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4201, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86100E724A8 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4202, 1021, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300E976CC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4203, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A8610103F218 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4204, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86200988938 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4205, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86200F87CE4 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4206, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A863009D7C04 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4207, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A863009E8AB8 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4208, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A863009EA0FC AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1040')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4209, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A863009EB290 AS DateTime), 17, N'admin', N'角色删除', 0, N'4')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4210, 4, N'127.0.0.1', N'IANA保留地址用于本地回送', 3, CAST(0x0000A863009EB290 AS DateTime), 17, N'admin', N'角色删除', 0, N'1002')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4211, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A86300A02ABC AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1018')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4212, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300A3C17C AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4213, 2, NULL, NULL, 1, CAST(0x0000A86300AB7DF4 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'18516717582')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4214, 2, NULL, NULL, 1, CAST(0x0000A86300AB8D30 AS DateTime), NULL, NULL, N'账号不存在、IP所在城市IANA保留地址用于本地回送', 1, N'1816717582')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4215, 2, NULL, NULL, 1, CAST(0x0000A86300AB9438 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'18516717582')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4216, 2, NULL, NULL, 1, CAST(0x0000A86300AB9690 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'18516717582')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4217, 2, NULL, NULL, 1, CAST(0x0000A86300ABAE00 AS DateTime), NULL, NULL, N'密码错误、IP所在城市IANA保留地址用于本地回送', 1, N'18516717582')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4218, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300ABB3DC AS DateTime), 19, N'小刚', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'小刚')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4219, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300ABC69C AS DateTime), 19, N'小刚', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'小刚')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4220, 2, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300ABD254 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4221, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86300DB3210 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4222, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86301434828 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4223, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86400A512FC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4224, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A864011A8A78 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4225, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A864013196DC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4226, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A865009D1F70 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4227, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A86500F3F390 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4228, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A86500F409D4 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1053')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4229, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A866009C6774 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4230, 1024, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A86600B949FC AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4231, NULL, N'127.0.0.1', N'IANA保留地址用于本地回送', 0, CAST(0x0000A869009D4298 AS DateTime), 17, N'admin', N'登陆成功、IP所在城市IANA保留地址用于本地回送', 0, N'admin')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4232, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 1, CAST(0x0000A86900DD8434 AS DateTime), 17, N'admin', N'模块操作添加', 0, N'0')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4233, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A86900DDDAEC AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1054')
INSERT [dbo].[SysLog] ([SysLogId], [ModuleId], [IPAddress], [IPAddressName], [LogType], [CreateTime], [CreateUserId], [CreateUserName], [Remark], [Status], [ObjectId]) VALUES (4234, 5, N'127.0.0.1', N'IANA保留地址用于本地回送', 2, CAST(0x0000A86900F2A594 AS DateTime), 17, N'admin', N'模块操作修改', 0, N'1054')
SET IDENTITY_INSERT [dbo].[SysLog] OFF
SET IDENTITY_INSERT [dbo].[SysLogDetail] ON 

INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1, 1041, N'RoleId', N'RoleId', N'0', NULL, CAST(0x0000A7E500BB9770 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (2, 1041, N'RoleName', N'RoleName', N'3334444', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (3, 1041, N'CreateTime', N'CreateTime', N'2017/9/5 11:22:30', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (4, 1041, N'CreateUserId', N'CreateUserId', N'17', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (5, 1041, N'Sort', N'Sort', N'0', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (6, 1041, N'Remark', N'Remark', N'21312', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (7, 1041, N'DeleteMark', N'DeleteMark', N'0', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (8, 1041, N'CreateUserName', N'CreateUserName', N'admin', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (9, 1041, N'ModifyDate', N'ModifyDate', N'2017/9/5 11:22:30', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (10, 1041, N'ModifyUserId', N'ModifyUserId', N'17', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (11, 1041, N'ModifyUserName', N'ModifyUserName', N'admin', NULL, CAST(0x0000A7E500BB989C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (12, 1042, N'', N'', N'RoleId:1016RoleName:测试角色1CreateTime:2017/9/5 11:31:43CreateUserId:17Sort:0Remark:123DeleteMark:0CreateUserName:adminModifyDate:2017/9/5 11:31:43ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7E500BDFC54 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (13, 1043, N'', N'', N'RoleId:1017,RoleName:测试2,CreateTime:2017/9/5 11:32:46,CreateUserId:17,Sort:0,Remark:33,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:32:46,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7E500BE4628 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (19, 1049, N'', N'', N'RoleName:客服123,Remark:测试123,ModifyDate:2017/9/5 16:40:30,', N'RoleName:客服3,Remark:测试33,ModifyDate:2017/9/5 16:27:58,', CAST(0x0000A7E50112CBA8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (20, 2051, N'', N'', N'RoleId:0,CreateTime:0001/1/1 0:00:00,CreateUserId:0,Sort:0,DeleteMark:0,ModifyDate:0001/1/1 0:00:00,ModifyUserId:0,', NULL, CAST(0x0000A7EB00B21A24 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (21, 2053, N'', N'', N'RoleId:1011,RoleName:33123,CreateTime:2017/9/5 11:10:17,CreateUserId:17,Sort:0,Remark:213,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:10:17,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB00E998C8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (22, 2054, N'', N'', N'RoleId:1016,RoleName:测试角色1,CreateTime:2017/9/5 11:31:43,CreateUserId:17,Sort:0,Remark:123,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:31:43,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB00F09AEC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (23, 2055, N'', N'', N'RoleId:1017,RoleName:测试2,CreateTime:2017/9/5 11:32:46,CreateUserId:17,Sort:0,Remark:33,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:32:46,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB00F09AEC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (24, 2056, N'', N'', N'RoleId:1009,RoleName:123312,CreateTime:2017/9/5 11:08:52,CreateUserId:17,Sort:0,Remark:21312,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:08:52,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB01097C10 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (25, 2057, N'', N'', N'RoleId:1015,RoleName:3334444,CreateTime:2017/9/5 11:22:30,CreateUserId:17,Sort:0,Remark:21312,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:22:30,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB010987C8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (26, 2058, N'', N'', N'RoleId:1014,RoleName:3333,CreateTime:2017/9/5 11:20:01,CreateUserId:17,Sort:0,Remark:333123,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:20:01,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EB0109AC1C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (27, 2060, N'', N'', N'UserRoleId:0,UserId:35,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (28, 2061, N'', N'', N'UserRoleId:0,UserId:38,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (29, 2062, N'', N'', N'UserRoleId:0,UserId:39,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (30, 2063, N'', N'', N'UserRoleId:0,UserId:40,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (31, 2064, N'', N'', N'UserRoleId:0,UserId:41,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (32, 2065, N'', N'', N'UserRoleId:0,UserId:42,RoleId:1010,', NULL, CAST(0x0000A7EC00EEE5D0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (33, 2066, N'', N'', N'UserRoleId:0,UserId:12,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (34, 2067, N'', N'', N'UserRoleId:0,UserId:14,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (35, 2068, N'', N'', N'UserRoleId:0,UserId:15,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (36, 2069, N'', N'', N'UserRoleId:0,UserId:16,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (37, 2070, N'', N'', N'UserRoleId:0,UserId:18,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (38, 2071, N'', N'', N'UserRoleId:0,UserId:21,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (39, 2072, N'', N'', N'UserRoleId:0,UserId:24,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (40, 2073, N'', N'', N'UserRoleId:0,UserId:29,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (41, 2074, N'', N'', N'UserRoleId:0,UserId:47,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (42, 2075, N'', N'', N'UserRoleId:0,UserId:55,RoleId:1006,', NULL, CAST(0x0000A7EC00EEFD40 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (43, 2076, N'', N'', N'RoleId:1006,RoleName:小明,CreateTime:2017/9/5 11:04:53,CreateUserId:17,Sort:0,Remark:测试,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:04:53,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A7EC00EF2644 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (44, 2077, N'', N'', N'UserRoleId:0,UserId:3,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (45, 2078, N'', N'', N'UserRoleId:0,UserId:4,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (46, 2079, N'', N'', N'UserRoleId:0,UserId:5,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (47, 2080, N'', N'', N'UserRoleId:0,UserId:6,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (48, 2081, N'', N'', N'UserRoleId:0,UserId:7,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (49, 2082, N'', N'', N'UserRoleId:0,UserId:8,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (50, 2083, N'', N'', N'UserRoleId:0,UserId:9,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (51, 2084, N'', N'', N'UserRoleId:0,UserId:10,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (52, 2085, N'', N'', N'UserRoleId:0,UserId:11,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (53, 2086, N'', N'', N'UserRoleId:0,UserId:13,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (54, 2087, N'', N'', N'UserRoleId:0,UserId:14,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (55, 2088, N'', N'', N'UserRoleId:0,UserId:15,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (56, 2089, N'', N'', N'UserRoleId:0,UserId:17,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (57, 2090, N'', N'', N'UserRoleId:0,UserId:18,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (58, 2091, N'', N'', N'UserRoleId:0,UserId:19,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (59, 2092, N'', N'', N'UserRoleId:0,UserId:21,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (60, 2093, N'', N'', N'UserRoleId:0,UserId:22,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (61, 2094, N'', N'', N'UserRoleId:0,UserId:26,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (62, 2095, N'', N'', N'UserRoleId:0,UserId:27,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (63, 2096, N'', N'', N'UserRoleId:0,UserId:28,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (64, 2097, N'', N'', N'UserRoleId:0,UserId:29,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (65, 2098, N'', N'', N'UserRoleId:0,UserId:30,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (66, 2099, N'', N'', N'UserRoleId:0,UserId:31,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (67, 2100, N'', N'', N'UserRoleId:0,UserId:32,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (68, 2101, N'', N'', N'UserRoleId:0,UserId:33,RoleId:1,', NULL, CAST(0x0000A7EC0118C170 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1027, 4059, N'', N'', N'ModuleOperateId:0ModuleOperateName:添加角色人员1CreateTime:2017/9/13 11:41:41CreateUserId:17CreateUserName:adminEnabled:1ModuleId:4JsEvent:btn_adduser()Icon:&#xe610;Sort:0', NULL, CAST(0x0000A7ED00C0B91C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1028, 4060, N'', N'', N'ModuleOperateName:添加3,CreateTime:2017/9/13 11:42:49,', N'ModuleOperateName:添加,CreateTime:2017/8/21 9:33:30,', CAST(0x0000A7ED00C108CC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1029, 4061, N'', N'', N'CreateTime:2017/9/13 16:42:27,JsEvent:btn_del(),', N'CreateTime:2017/8/21 9:54:17,JsEvent:btn_add(),', CAST(0x0000A7ED011354C4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1030, 4062, N'', N'', N'CreateTime:2017/9/13 17:06:21,', N'CreateTime:2017/8/18 14:50:26,', CAST(0x0000A7ED0119E53C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1031, 4063, N'', N'', N'CreateTime:2017/9/13 17:06:40,', N'CreateTime:2017/8/18 15:50:51,', CAST(0x0000A7ED0119FB80 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1032, 4064, N'', N'', N'CreateTime:2017/9/13 17:06:47,', N'CreateTime:2017/8/21 9:52:55,', CAST(0x0000A7ED011A03B4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1033, 4065, N'', N'', N'CreateTime:2017/9/13 17:07:06,', N'CreateTime:2017/8/21 9:51:51,', CAST(0x0000A7ED011A19F8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1034, 4066, N'', N'', N'ModuleOperateId:0ModuleOperateName:删除CreateTime:2017/9/13 17:08:34CreateUserId:17CreateUserName:adminEnabled:1ModuleId:2JsEvent:btn_del()Sort:0', NULL, CAST(0x0000A7ED011A8118 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1035, 4067, N'', N'', N'CreateTime:2017/9/13 17:08:54,', N'CreateTime:2017/9/13 16:42:27,', CAST(0x0000A7ED011A9888 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1036, 4068, N'', N'', N'CreateTime:2017/9/13 17:09:06,', N'CreateTime:2017/9/13 17:08:34,', CAST(0x0000A7ED011AA698 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1037, 4071, N'', N'', N'ModuleOperateName:添加,CreateTime:2017/9/15 8:53:18,', N'ModuleOperateName:添加3,CreateTime:2017/9/13 11:42:49,', CAST(0x0000A7EF009279A8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1038, 4072, N'', N'', N'CreateTime:2017/9/15 8:53:34,', N'CreateTime:2017/9/15 8:53:18,', CAST(0x0000A7EF00928C68 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1039, 4073, N'', N'', N'ModuleOperateId:0ModuleOperateName:修改CreateTime:2017/9/15 8:54:00CreateUserId:17CreateUserName:adminEnabled:1ModuleId:3JsEvent:btn_eIcon:&#xe60cSort:0', NULL, CAST(0x0000A7EF0092AAE0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1040, 4074, N'', N'', N'CreateTime:2017/9/15 8:54:18,JsEvent:btn_edit(),', N'CreateTime:2017/9/15 8:54:00,JsEvent:btn_e,', CAST(0x0000A7EF0092BFF8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1041, 4075, N'', N'', N'ModuleOperateId:0ModuleOperateName:隐藏CreateTime:2017/9/15 8:59:27CreateUserId:17CreateUserName:adminEnabled:1ModuleId:3JsEvent:btn_hidden()Icon:&#xe6e2Sort:0', NULL, CAST(0x0000A7EF00942A14 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1042, 4076, N'', N'', N'ModuleOperateName:禁用,CreateTime:2017/9/15 9:37:57,', N'ModuleOperateName:删除,CreateTime:2017/9/13 17:09:06,', CAST(0x0000A7EF009EBD1C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1043, 4078, N'', N'', N'ModuleOperateId:0ModuleOperateName:启用CreateTime:2017/9/15 11:47:52CreateUserId:17CreateUserName:adminEnabled:1ModuleId:2JsEvent:btn_qy()Sort:0', NULL, CAST(0x0000A7EF00C26BE0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1044, 4079, N'', N'', N'CreateTime:2017/9/15 11:50:16,', N'CreateTime:2017/9/15 11:47:52,', CAST(0x0000A7EF00C314A0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1045, 4080, N'', N'', N'CreateTime:2017/9/15 11:50:32,Icon:&#xe60e,', N'CreateTime:2017/9/15 9:37:57,Icon:&#xe6e2,', CAST(0x0000A7EF00C32760 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1046, 4081, N'', N'', N'ModuleOperateId:0ModuleOperateName:添加CreateTime:2017/9/15 15:58:38CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1010JsEvent:btn_add()Sort:0', NULL, CAST(0x0000A7EF01074BE8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1047, 4082, N'', N'', N'CreateTime:2017/9/15 15:58:50,', N'CreateTime:2017/9/15 15:58:38,', CAST(0x0000A7EF010759F8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1048, 4086, N'', N'', N'ModuleOperateId:0ModuleOperateName:添加CreateTime:2017/9/18 9:14:14CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1011JsEvent:btn_add()Sort:0', NULL, CAST(0x0000A7F200983988 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1049, 4087, N'', N'', N'ModuleOperateId:0ModuleOperateName:导入CreateTime:2017/9/18 9:14:40CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1011JsEvent:btn_leadingin()Sort:0', NULL, CAST(0x0000A7F200985800 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1050, 4088, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:32:54CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:32:54ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009D5A08 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1051, 4089, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:40:03CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:40:03ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009F51F0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1052, 4090, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:41:03CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:41:03ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009F9714 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1053, 4091, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:41:07CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:41:07ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009F9BC4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1054, 4092, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:41:23CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:41:23ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FAE84 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1055, 4093, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:41:31CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:41:31ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FB7E4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1056, 4094, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:41:42CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:41:42ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FC4C8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1057, 4095, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:42:01CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:42:01ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FDB0C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1058, 4096, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:42:04CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:42:04ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FDE90 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1059, 4097, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:42:27CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:42:27ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F2009FF984 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1060, 4098, N'', N'', N'RoleId:0CreateTime:2017/9/18 9:42:50CreateUserId:17Sort:0DeleteMark:0CreateUserName:adminModifyDate:2017/9/18 9:42:50ModifyUserId:17ModifyUserName:admin', NULL, CAST(0x0000A7F200A01478 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1061, 4100, N'', N'', N'CreateTime:2017/9/18 13:30:11,', N'CreateTime:2017/9/18 9:14:40,', CAST(0x0000A7F200DE8604 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1062, 4101, N'', N'', N'CreateTime:2017/9/18 13:30:39,', N'CreateTime:2017/9/18 9:14:14,', CAST(0x0000A7F200DEA6D4 AS DateTime))
GO
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1063, 4110, N'', N'', N'ModuleOperateId:0ModuleOperateName:编辑CreateTime:2017/9/24 14:11:33CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1010JsEvent:btn_edit()Sort:0', NULL, CAST(0x0000A7F800E9E29C AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1064, 4111, N'', N'', N'CreateTime:2017/9/24 14:11:50,', N'CreateTime:2017/9/24 14:11:33,', CAST(0x0000A7F800E9F688 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1065, 4112, N'', N'', N'ModuleOperateId:0ModuleOperateName:删除CreateTime:2017/9/24 15:00:40CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1011JsEvent:btn_del()Sort:0', NULL, CAST(0x0000A7F800F76020 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1066, 4113, N'', N'', N'CreateTime:2017/9/24 15:01:11,', N'CreateTime:2017/9/24 15:00:40,', CAST(0x0000A7F800F78474 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1067, 4114, N'', N'', N'ModuleOperateId:0ModuleOperateName:删除CreateTime:2017/9/24 15:22:42CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1010JsEvent:btn_del()Sort:0', NULL, CAST(0x0000A7F800FD6D58 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1068, 4115, N'', N'', N'CreateTime:2017/9/24 15:22:59,', N'CreateTime:2017/9/24 15:22:42,', CAST(0x0000A7F800FD8144 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1069, 4116, N'', N'', N'CreateTime:2017/9/24 15:34:47,Enabled:0,', N'CreateTime:2017/9/24 15:01:11,Enabled:1,', CAST(0x0000A7F80100BEF4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1070, 4117, N'', N'', N'CreateTime:2017/9/24 15:35:07,Enabled:0,', N'CreateTime:2017/9/15 11:50:16,Enabled:1,', CAST(0x0000A7F80100D664 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1071, 4174, N'', N'', N'ModuleOperateId:0ModuleOperateName:3123CreateTime:2017/11/27 21:27:15CreateUserId:17CreateUserName:adminEnabled:1ModuleId:2JsEvent:213213Icon:123Sort:0', NULL, CAST(0x0000A83801618DC4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1072, 4177, N'', N'', N'ModuleOperateId:0ModuleOperateName:添加CreateTime:2017/12/30 15:58:12CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1019JsEvent:btn_add()Sort:0', NULL, CAST(0x0000A85901072D70 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1073, 4178, N'', N'', N'ModuleOperateId:0ModuleOperateName:编辑CreateTime:2017/12/30 15:58:43CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1019JsEvent:btn_edit()Sort:1', NULL, CAST(0x0000A859010751C4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1074, 4179, N'', N'', N'CreateTime:2017/12/30 15:59:02,', N'CreateTime:2017/12/30 15:58:12,', CAST(0x0000A85901076808 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1075, 4180, N'', N'', N'CreateTime:2017/12/30 15:59:15,', N'CreateTime:2017/12/30 15:58:43,', CAST(0x0000A85901077744 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1076, 4184, N'', N'', N'RoleId:1013,RoleName:123456,CreateTime:2017/9/5 11:16:00,CreateUserId:17,Sort:0,Remark:123,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:16:00,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7BD00 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1077, 4185, N'', N'', N'RoleId:1012,RoleName:12312,CreateTime:2017/9/5 11:13:50,CreateUserId:17,Sort:0,Remark:21321,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:13:50,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C084 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1078, 4186, N'', N'', N'RoleId:1010,RoleName:2312,CreateTime:2017/9/5 11:09:40,CreateUserId:17,Sort:0,Remark:33331,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:09:40,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C660 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1079, 4187, N'', N'', N'RoleId:1011,RoleName:33123,CreateTime:2017/9/5 11:10:17,CreateUserId:17,Sort:0,Remark:213,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:10:17,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C660 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1080, 4188, N'', N'', N'RoleId:1003,RoleName:ceshi123,CreateTime:2017/9/5 11:01:16,CreateUserId:17,Sort:0,Remark:shuoming,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:01:16,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C9E4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1081, 4189, N'', N'', N'RoleId:1004,RoleName:产品,CreateTime:2017/9/5 11:01:44,CreateUserId:17,Sort:0,Remark:测试1,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:01:44,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C9E4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1082, 4190, N'', N'', N'RoleId:1005,RoleName:班长,CreateTime:2017/9/5 11:03:38,CreateUserId:17,Sort:0,Remark:112,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:03:38,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C9E4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1083, 4191, N'', N'', N'RoleId:1008,RoleName:213,CreateTime:2017/9/5 11:07:21,CreateUserId:17,Sort:0,Remark:12312,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 11:07:21,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A86000E7C9E4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1084, 4192, N'', N'', N'ModuleOperateId:0ModuleOperateName:添加角色成员CreateTime:2018/1/6 14:10:42CreateUserId:17CreateUserName:adminEnabled:1ModuleId:4JsEvent:btn_adduser()Sort:0', NULL, CAST(0x0000A86000E9A6D8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1085, 4193, N'', N'', N'CreateTime:2018/1/6 14:12:46,', N'CreateTime:2018/1/6 14:10:42,', CAST(0x0000A86000EA3828 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1086, 4194, N'', N'', N'UserRoleId:0,UserId:17,RoleId:1,', NULL, CAST(0x0000A86000EA72C0 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1087, 4207, N'', N'', N'ModuleOperateId:0ModuleOperateName:删除CreateTime:2018/1/9 9:37:14CreateUserId:17CreateUserName:adminEnabled:1ModuleId:2JsEvent:btn_del()Sort:0', NULL, CAST(0x0000A863009E8AB8 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1088, 4208, N'', N'', N'CreateTime:2018/1/9 9:37:33,', N'CreateTime:2018/1/9 9:37:14,', CAST(0x0000A863009EA0FC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1089, 4209, N'', N'', N'RoleId:4,RoleName:客服123,CreateTime:2017/9/4 17:09:39,CreateUserId:0,Sort:0,Remark:测试123,DeleteMark:0,ModifyDate:2017/9/5 16:40:30,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A863009EB290 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1090, 4210, N'', N'', N'RoleId:1002,RoleName:测试橘色3331,CreateTime:2017/9/5 10:59:09,CreateUserId:0,Sort:0,Remark:测试3331,DeleteMark:0,CreateUserName:admin,ModifyDate:2017/9/5 16:29:13,ModifyUserId:17,ModifyUserName:admin,', NULL, CAST(0x0000A863009EB290 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1091, 4211, N'', N'', N'CreateTime:2018/1/9 9:43:09,JsEvent:btn_disabled(),', N'CreateTime:2017/9/15 11:50:32,JsEvent:btn_del(),', CAST(0x0000A86300A02ABC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1092, 4227, N'', N'', N'ModuleOperateId:0ModuleOperateName:删除CreateTime:2018/1/11 14:48:12CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1019JsEvent:btn_del()Sort:0', NULL, CAST(0x0000A86500F3F390 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1093, 4228, N'', N'', N'CreateTime:2018/1/11 14:48:31,', N'CreateTime:2018/1/11 14:48:12,', CAST(0x0000A86500F409D4 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1094, 4232, N'', N'', N'ModuleOperateId:0ModuleOperateName:打印CreateTime:2018/1/15 13:26:31CreateUserId:17CreateUserName:adminEnabled:1ModuleId:1019JsEvent:btn_print()Sort:0', NULL, CAST(0x0000A86900DD8434 AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1095, 4233, N'', N'', N'CreateTime:2018/1/15 13:27:44,', N'CreateTime:2018/1/15 13:26:31,', CAST(0x0000A86900DDDAEC AS DateTime))
INSERT [dbo].[SysLogDetail] ([SysLogDetailId], [SysLogId], [PropertyName], [PropertyField], [NewValue], [OldValue], [CreateTime]) VALUES (1096, 4234, N'', N'', N'ModuleOperateName:导出,CreateTime:2018/1/15 14:43:27,Icon:&#xe644,', N'ModuleOperateName:打印,CreateTime:2018/1/15 13:27:44,Icon:&#xe652; ,', CAST(0x0000A86900F2A594 AS DateTime))
SET IDENTITY_INSERT [dbo].[SysLogDetail] OFF
SET IDENTITY_INSERT [dbo].[T_ActivityArea] ON 

INSERT [dbo].[T_ActivityArea] ([ActivitAreaId], [ActivityAreaName], [CreateTime], [CreateUserId], [SortCode], [IsShow], [CreateUserName], [IsDelete]) VALUES (1, N'南区', CAST(0x0000A86000F7FBFC AS DateTime), 17, 0, 1, N'admin', 0)
INSERT [dbo].[T_ActivityArea] ([ActivitAreaId], [ActivityAreaName], [CreateTime], [CreateUserId], [SortCode], [IsShow], [CreateUserName], [IsDelete]) VALUES (2, N'北区', CAST(0x0000A86000F80304 AS DateTime), 17, 0, 1, N'admin', 0)
SET IDENTITY_INSERT [dbo].[T_ActivityArea] OFF
SET IDENTITY_INSERT [dbo].[T_Agency] ON 

INSERT [dbo].[T_Agency] ([AgencyId], [AgencyName], [CreateTime], [CreateUserId], [CreateUserName], [IsShow], [IsDelete], [SortCode]) VALUES (1, N'上海宝利德', CAST(0x0000A8610105BB20 AS DateTime), 17, N'admin', 1, 0, 0)
INSERT [dbo].[T_Agency] ([AgencyId], [AgencyName], [CreateTime], [CreateUserId], [CreateUserName], [IsShow], [IsDelete], [SortCode]) VALUES (14, N'上海宝利德2', CAST(0x0000A8610105BB20 AS DateTime), 17, N'admin', 1, 0, 0)
INSERT [dbo].[T_Agency] ([AgencyId], [AgencyName], [CreateTime], [CreateUserId], [CreateUserName], [IsShow], [IsDelete], [SortCode]) VALUES (15, N'上海宝利德3', CAST(0x0000A8610105BB20 AS DateTime), 17, N'admin', 1, 0, 0)
INSERT [dbo].[T_Agency] ([AgencyId], [AgencyName], [CreateTime], [CreateUserId], [CreateUserName], [IsShow], [IsDelete], [SortCode]) VALUES (16, N'上海宝利德4', CAST(0x0000A8610105BB20 AS DateTime), 17, N'admin', 1, 0, 0)
SET IDENTITY_INSERT [dbo].[T_Agency] OFF
SET IDENTITY_INSERT [dbo].[T_SaleActivity] ON 

INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (5, 1, 1, CAST(0xD43E0B00 AS Date), 2, 120, 120, 1, 5, 200, 5, N'0,1,2', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (7, 14, 1, CAST(0xD43E0B00 AS Date), 3, 520, 50, 1, 9, 300, 8, N'1', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (8, 1, 1, CAST(0xD43E0B00 AS Date), 2, 600, 80, 1, 8, 500, 9, N'2', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (9, 15, 1, CAST(0xB63E0B00 AS Date), 2, 722, 722, 1, 7, 955, 2, N'0', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (10, 1, 1, CAST(0xB63E0B00 AS Date), 3, 455, 50, 1, 5, 200, 7, N'1', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (11, 16, 1, CAST(0xB63E0B00 AS Date), 2, 77, 600, 1, 6, 800, 4, N'0,1,2', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1009, 1, 1, CAST(0x973E0B00 AS Date), 2, 200, 600, 1, 8, 200, 5, N'0', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1010, 14, 1, CAST(0x973E0B00 AS Date), 3, 88, 300, 1, 25, 300, 6, N'1', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1011, 15, 1, CAST(0x973E0B00 AS Date), 2, 63, 800, 1, 2, 500, 4, N'0', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1012, 14, 1, CAST(0x783E0B00 AS Date), 2, 71, 500, 1, 78, 955, 2, N'1', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1013, 1, 1, CAST(0x783E0B00 AS Date), 3, 80, 500, 1, 8, 200, 8, N'2', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1014, 15, 1, CAST(0x783E0B00 AS Date), 2, 45, 400, 1, 8, 800, 6, N'0', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 0, N'admin')
INSERT [dbo].[T_SaleActivity] ([SaleActivityId], [AgencyId], [AreaId], [ActivityDate], [SaleActivityTypeId], [PassengerFlow], [LatentPassengerFlow], [CarOwner], [OrderQuantity], [PrimeCost], [LaterOrderQuantity], [PublishWay], [CreateTime], [CreateUserId], [ActivityName], [IsShow], [IsDelete], [CreateUserName]) VALUES (1015, 1, 1, CAST(0x783E0B00 AS Date), 2, 45, 300, 1, 8, 800, 9, N'0,1,2', CAST(0x0000A86200FA5654 AS DateTime), 17, NULL, 1, 1, N'admin')
SET IDENTITY_INSERT [dbo].[T_SaleActivity] OFF
SET IDENTITY_INSERT [dbo].[T_SaleActivityType] ON 

INSERT [dbo].[T_SaleActivityType] ([SaleActivityTypeId], [SaleActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (1, N'派对类', 1, CAST(0x0000A86300EA5C7C AS DateTime), 17, 1, N'admin', 0)
INSERT [dbo].[T_SaleActivityType] ([SaleActivityTypeId], [SaleActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (2, N'爱好类', 0, CAST(0x0000A86300EA6384 AS DateTime), 17, 1, N'admin', 0)
INSERT [dbo].[T_SaleActivityType] ([SaleActivityTypeId], [SaleActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (3, N'职业类', 2, CAST(0x0000A8630100764C AS DateTime), 17, 1, N'admin', 0)
INSERT [dbo].[T_SaleActivityType] ([SaleActivityTypeId], [SaleActivityTypeName], [SortCode], [CreateTime], [CreateUserId], [IsShow], [CreateUserName], [IsDelete]) VALUES (4, N'车主', 4, CAST(0x0000A86500DAB4AC AS DateTime), 17, 1, N'admin', 0)
SET IDENTITY_INSERT [dbo].[T_SaleActivityType] OFF
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (45, 17, 1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
ALTER TABLE [dbo].[BaseUser] ADD  CONSTRAINT [DF_BaseUser_LogOnCount]  DEFAULT ((1)) FOR [LogOnCount]
GO
ALTER TABLE [dbo].[BaseUser] ADD  CONSTRAINT [DF_BaseUser_AuditStatus]  DEFAULT ((1)) FOR [AuditStatus]
GO
ALTER TABLE [dbo].[BaseUser] ADD  CONSTRAINT [DF_BaseUser_SortCode]  DEFAULT ((1)) FOR [SortCode]
GO
ALTER TABLE [dbo].[BaseUser] ADD  CONSTRAINT [DF_BaseUser_DeleteMark]  DEFAULT ((0)) FOR [DeleteMark]
GO
ALTER TABLE [dbo].[SysLog] ADD  CONSTRAINT [DF_SysLog_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SysLogDetail] ADD  CONSTRAINT [DF_SysLogDetail_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[C_ClubActivityInfo]  WITH CHECK ADD  CONSTRAINT [FK_C_ClubActivityInfo_C_ClubActivityType] FOREIGN KEY([ClubActivityTypeId])
REFERENCES [dbo].[C_ClubActivityType] ([ClubActivityTypeId])
GO
ALTER TABLE [dbo].[C_ClubActivityInfo] CHECK CONSTRAINT [FK_C_ClubActivityInfo_C_ClubActivityType]
GO
ALTER TABLE [dbo].[C_ClubInfo]  WITH CHECK ADD  CONSTRAINT [FK_C_ClubInfo_T_ActivityArea] FOREIGN KEY([ActivitAreaId])
REFERENCES [dbo].[T_ActivityArea] ([ActivitAreaId])
GO
ALTER TABLE [dbo].[C_ClubInfo] CHECK CONSTRAINT [FK_C_ClubInfo_T_ActivityArea]
GO
ALTER TABLE [dbo].[ModuleOperate]  WITH CHECK ADD  CONSTRAINT [FK_ModuleOperate_Module] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Module] ([ModuleId])
GO
ALTER TABLE [dbo].[ModuleOperate] CHECK CONSTRAINT [FK_ModuleOperate_Module]
GO
ALTER TABLE [dbo].[ModuleRole]  WITH CHECK ADD  CONSTRAINT [FK_ModuleRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[ModuleRole] CHECK CONSTRAINT [FK_ModuleRole_Role]
GO
ALTER TABLE [dbo].[SysLog]  WITH CHECK ADD  CONSTRAINT [FK_SysLog_BaseUser] FOREIGN KEY([CreateUserId])
REFERENCES [dbo].[BaseUser] ([UserId])
GO
ALTER TABLE [dbo].[SysLog] CHECK CONSTRAINT [FK_SysLog_BaseUser]
GO
ALTER TABLE [dbo].[SysLogDetail]  WITH CHECK ADD  CONSTRAINT [FK_SysLOgDetail_SysLog] FOREIGN KEY([SysLogId])
REFERENCES [dbo].[SysLog] ([SysLogId])
GO
ALTER TABLE [dbo].[SysLogDetail] CHECK CONSTRAINT [FK_SysLOgDetail_SysLog]
GO
ALTER TABLE [dbo].[T_SaleActivity]  WITH CHECK ADD  CONSTRAINT [FK_T_SaleActivity_BaseUser] FOREIGN KEY([CreateUserId])
REFERENCES [dbo].[BaseUser] ([UserId])
GO
ALTER TABLE [dbo].[T_SaleActivity] CHECK CONSTRAINT [FK_T_SaleActivity_BaseUser]
GO
ALTER TABLE [dbo].[T_SaleActivity]  WITH CHECK ADD  CONSTRAINT [FK_T_SaleActivity_T_ActivityArea] FOREIGN KEY([AreaId])
REFERENCES [dbo].[T_ActivityArea] ([ActivitAreaId])
GO
ALTER TABLE [dbo].[T_SaleActivity] CHECK CONSTRAINT [FK_T_SaleActivity_T_ActivityArea]
GO
ALTER TABLE [dbo].[T_SaleActivity]  WITH CHECK ADD  CONSTRAINT [FK_T_SaleActivity_T_Agency] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[T_Agency] ([AgencyId])
GO
ALTER TABLE [dbo].[T_SaleActivity] CHECK CONSTRAINT [FK_T_SaleActivity_T_Agency]
GO
ALTER TABLE [dbo].[T_SaleActivity]  WITH CHECK ADD  CONSTRAINT [FK_T_SaleActivity_T_SaleActivityType] FOREIGN KEY([SaleActivityTypeId])
REFERENCES [dbo].[T_SaleActivityType] ([SaleActivityTypeId])
GO
ALTER TABLE [dbo].[T_SaleActivity] CHECK CONSTRAINT [FK_T_SaleActivity_T_SaleActivityType]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Telephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'OICQ'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改密码的日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'ChangePasswordDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'LogOnCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'第一次访问时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'FirstVisit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上一次访问时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'PreviousVisit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'AuditStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0无效 1有效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标记 1删除0不删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BaseUser', @level2type=N'COLUMN',@level2name=N'DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'控制器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'ControllerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'方法' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'ActionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'Icon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'等级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'ModuleLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否显示1显示0不显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Module', @level2type=N'COLUMN',@level2name=N'IsShow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块操作名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ModuleOperate', @level2type=N'COLUMN',@level2name=N'ModuleOperateName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SysLog', @level2type=N'COLUMN',@level2name=N'ModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经销商活动区域' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_ActivityArea', @level2type=N'COLUMN',@level2name=N'ActivitAreaId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经销商Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_Agency', @level2type=N'COLUMN',@level2name=N'AgencyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经销商活动ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'SaleActivityId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'SaleActivityTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活动客流量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'PassengerFlow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'潜在客流量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'LatentPassengerFlow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活动车主量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'CarOwner'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成本金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'PrimeCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'后续订单量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'LaterOrderQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'活动名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivity', @level2type=N'COLUMN',@level2name=N'ActivityName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'经销商活动类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_SaleActivityType', @level2type=N'COLUMN',@level2name=N'SaleActivityTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C_ClubActivityInfo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C_ClubActivityType"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 146
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'C_ClubActivityInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'C_ClubActivityInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C_ClubInfo"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_ActivityArea"
            Begin Extent = 
               Top = 6
               Left = 311
               Bottom = 146
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'C_ClubInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'C_ClubInfoView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T_SaleActivity"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_SaleActivityType"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 146
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_Agency"
            Begin Extent = 
               Top = 150
               Left = 38
               Bottom = 290
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T_ActivityArea"
            Begin Extent = 
               Top = 150
               Left = 265
               Bottom = 290
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Activity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Activity'
GO
