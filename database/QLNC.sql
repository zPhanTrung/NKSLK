USE [QLNC]
GO
/****** Object:  UserDefinedFunction [dbo].[getFirstAndLastDayOfWeek]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getFirstAndLastDayOfWeek](@week int, @month int, @year int)
RETURNS @mondayAndSunday TABLE(
	firstDay date,
	lastDay date
)
AS
BEGIN
	DECLARE @i int
	DECLARE @daysOfMonth int
	DECLARE @fisrtDayOfMonth date
	DECLARE @firstDay date
	DECLARE @lastDay date
	SET @fisrtDayOfMonth = cast(@year as varchar(4)) + '-' + cast(@month as varchar(2)) +'-'+ '01'
	SET @daysOfMonth = DAY(EOMONTH(@fisrtDayOfMonth))
	SET @i = 1

	WHILE (@i < @daysOfMonth)
	BEGIN
		SET @week = @week - 1
		IF(@week = 0 )
		BEGIN
			IF(@i+7 < @daysOfMonth)
			BEGIN
				SET @firstDay = cast(@year as varchar(4)) + '-' + cast(@month as varchar(2)) + '-' + cast(@i as varchar(2))
				SET @lastDay = DATEADD(wk, DATEDIFF(wk, 0, @firstDay), 0) + 6
			END
			ELSE
			BEGIN
				SET @firstDay = cast(@year as varchar(4)) + '-' + cast(@month as varchar(2)) + '-' + cast(@i as varchar(2))
				SET @lastDay = cast(@year as varchar(4)) + '-' + cast(@month as varchar(2)) + '-' + cast(@daysOfMonth as varchar(2))
			END
			INSERT INTO @mondayAndSunday(firstDay, lastDay) VALUES(@firstDay, @lastDay)
			RETURN
		END
		IF(@i=1)
		BEGIN
			SET @i = DAY(DATEADD(wk, DATEDIFF(wk, 0, @fisrtDayOfMonth) + 1, 0))
		END
		ELSE
		BEGIN
			SET @i = @i + 7
		END
	END
	RETURN
END
GO
/****** Object:  Table [dbo].[CALAMVIEC]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALAMVIEC](
	[MaCa] [int] IDENTITY(1,1) NOT NULL,
	[TenCa] [nvarchar](10) NULL,
	[GioBatDau] [time](7) NULL,
	[GioKetThuc] [time](7) NULL,
 CONSTRAINT [PK_dbo.CALAMVIEC] PRIMARY KEY CLUSTERED 
(
	[MaCa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONGNHAN]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONGNHAN](
	[MaCN] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[PhongBan] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[QueQuan] [nvarchar](100) NULL,
	[LuongHopDong] [decimal](8, 0) NULL,
	[LuongBaoHiem] [decimal](8, 0) NULL,
 CONSTRAINT [PK_dbo.CONGNHAN] PRIMARY KEY CLUSTERED 
(
	[MaCN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONGVIEC]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONGVIEC](
	[MaCV] [int] IDENTITY(1,1) NOT NULL,
	[TenCV] [nvarchar](30) NULL,
	[DinhMucKhoan] [decimal](4, 2) NULL,
	[DonViKhoan] [nvarchar](15) NULL,
	[HeSoKhoan] [decimal](4, 2) NULL,
	[DinhMucLaoDong] [decimal](4, 2) NULL,
	[DonGia] [decimal](8, 0) NULL,
 CONSTRAINT [PK_dbo.CONGVIEC] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONGVIECDALAM]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONGVIECDALAM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaCV] [int] NULL,
	[MaSP] [varchar](10) NULL,
	[SanLuong] [int] NULL,
	[SoLo] [varchar](10) NULL,
	[MaChiTietCaLam] [int] NULL,
 CONSTRAINT [PK_dbo.CONGVIECDALAM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETCALAM]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETCALAM](
	[MaChiTietCaLam] [int] IDENTITY(1,1) NOT NULL,
	[MaTo] [int] NULL,
	[MaCa] [int] NULL,
	[NgayThucHien] [date] NULL,
 CONSTRAINT [PK_dbo.CHITIETCALAM] PRIMARY KEY CLUSTERED 
(
	[MaChiTietCaLam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DANHSACHCONGNHAN]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DANHSACHCONGNHAN](
	[MaDanhSach] [int] IDENTITY(1,1) NOT NULL,
	[MaTo] [int] NULL,
	[MaCN] [int] NULL,
	[NgayThamGia] [date] NULL,
	[NgayRoi] [date] NULL,
 CONSTRAINT [PK_dbo.DANHSACHCONGNHAN] PRIMARY KEY CLUSTERED 
(
	[MaDanhSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NKSLK]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NKSLK](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDanhSach] [int] NULL,
	[NgayThucHien] [date] NULL,
	[GioBatDau] [time](7) NULL,
	[GioKetThuc] [time](7) NULL,
 CONSTRAINT [PK_dbo.NKSLK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MaSP] [varchar](10) NOT NULL,
	[TenSP] [nvarchar](100) NULL,
	[SoDangKy] [varchar](10) NULL,
	[NgayDangKy] [date] NULL,
	[HanSuDung] [int] NOT NULL,
	[QuyCach] [nvarchar](100) NULL,
	[Anh] [text] NULL,
 CONSTRAINT [PK_dbo.SANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TAIKHOAN]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TAIKHOAN](
	[TaiKhoan] [varchar](50) NOT NULL,
	[MatKhau] [varchar](50) NULL,
	[VaiTro] [varchar](20) NULL,
 CONSTRAINT [PK_TAIKHOAN] PRIMARY KEY CLUSTERED 
(
	[TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOCONGNHAN]    Script Date: 12/30/2021 10:29:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOCONGNHAN](
	[MaTo] [int] IDENTITY(1,1) NOT NULL,
	[NgayTao] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_dbo.TOCONGNHAN] PRIMARY KEY CLUSTERED 
(
	[MaTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CALAMVIEC] ON 

INSERT [dbo].[CALAMVIEC] ([MaCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (1, N'Ca 1', CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[CALAMVIEC] ([MaCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (2, N'Ca 2', CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[CALAMVIEC] ([MaCa], [TenCa], [GioBatDau], [GioKetThuc]) VALUES (3, N'Ca 3', CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[CALAMVIEC] OFF
GO
SET IDENTITY_INSERT [dbo].[CONGNHAN] ON 

INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (1, N'Nguyễn Văn A', CAST(N'1980-02-12' AS Date), 1, N'PB1', N'Quản lý', N'Hà Nội', CAST(10000000 AS Decimal(8, 0)), CAST(12000000 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (2, N'Phan Văn B', CAST(N'1975-05-12' AS Date), 1, N'PB2', N'Quản lý', N'Hà Nội', CAST(8000000 AS Decimal(8, 0)), CAST(9000000 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (3, N'Nguyễn Thị C', CAST(N'1973-10-20' AS Date), 0, N'PB3', N'Quản lý', N'Thái Nguyên', CAST(8500000 AS Decimal(8, 0)), CAST(9500000 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (4, N'Nguyễn Thu D', CAST(N'1974-02-28' AS Date), 0, N'PB4', N'Quản lý', N'Sài Gòn', CAST(10500000 AS Decimal(8, 0)), CAST(12000000 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (5, N'Trần Văn E ', CAST(N'1966-01-18' AS Date), 1, N'PB2', N'Nhân viên', N'Hà Nội', CAST(7000000 AS Decimal(8, 0)), CAST(8000000 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (6, N'Nguyễn Văn S', CAST(N'1984-04-15' AS Date), 1, N'PB1', N'Nhân viên', NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (7, N'Nguyễn Văn N', CAST(N'1990-06-14' AS Date), 1, N'PB2', N'Nhân viên', NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (8, N'Trần Văn P', CAST(N'1989-09-18' AS Date), 1, N'PB1', N'Nhân viên', NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (9, N'Phan Quốc T', CAST(N'1992-08-19' AS Date), 1, N'PB2', N'Nhân viên', NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (10, N'Phan Văn Q', CAST(N'1981-06-22' AS Date), 1, N'PB1', N'Nhân viên', NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (11, N'Nguyễn Thị T', CAST(N'1970-02-10' AS Date), 0, N'PB1', N'Nhân viên', N'TP.HCM', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (12, N'Nguyễn Thu T', CAST(N'1973-09-12' AS Date), 0, N'PB2', N'Nhân viên', N'TP.HCM', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (13, N'Trần Thu C', CAST(N'1992-05-22' AS Date), 0, N'PB3', N'Nhân viên', N'TP.HCM', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (14, N'Phan Thị A', CAST(N'1987-03-12' AS Date), 0, N'PB1', N'Nhân viên', N'TP.HCM', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (15, N'Nguyễn Thu D', CAST(N'1977-01-09' AS Date), 0, N'PB3', N'Nhân viên', N'TP.HCM', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (16, N'Nguyễn Thu T', NULL, 0, N'PB1', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (17, N'Nguyễn Văn S', NULL, 1, N'PB4', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (18, N'Trần Văn T', NULL, 1, N'PB1', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (19, N'Nguyễn Văn Q', NULL, 1, N'PB4', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (20, N'Nguyễn Văn P', NULL, 1, N'PB4', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (21, N'Nguyễn Quốc T', CAST(N'1975-10-09' AS Date), 1, N'PB3', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (22, N'Nguyễn Quốc T', CAST(N'1968-11-09' AS Date), 1, N'PB1', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (23, N'Nguyễn Quốc T', CAST(N'1976-12-09' AS Date), 1, N'PB4', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (24, N'Nguyễn Quốc T', CAST(N'1969-09-10' AS Date), 1, N'PB1', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (25, N'Nguyễn Quốc T', CAST(N'1969-10-20' AS Date), 1, N'PB2', N'Nhân viên', N'Hà Nội', NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (27, N'testa', CAST(N'2021-11-30' AS Date), 1, N'1', N'12', N'a', CAST(113 AS Decimal(8, 0)), CAST(11 AS Decimal(8, 0)))
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (28, N'test1', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (29, N'test2', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (30, N'test3', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (31, N'test4', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (32, N'test5', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (33, N'test6', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (34, N'test8', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (35, N'test9', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (36, N'test10', NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CONGNHAN] ([MaCN], [HoTen], [NgaySinh], [GioiTinh], [PhongBan], [ChucVu], [QueQuan], [LuongHopDong], [LuongBaoHiem]) VALUES (37, N'test11', NULL, 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CONGNHAN] OFF
GO
SET IDENTITY_INSERT [dbo].[CONGVIEC] ON 

INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (1, N'Công việc 1', CAST(1.50 AS Decimal(4, 2)), N'Kg', CAST(1.30 AS Decimal(4, 2)), CAST(1.80 AS Decimal(4, 2)), CAST(197122 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (2, N'Công việc 2', CAST(1.40 AS Decimal(4, 2)), N'Thùng', CAST(1.20 AS Decimal(4, 2)), CAST(1.50 AS Decimal(4, 2)), CAST(162463 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (3, N'Công việc 3', CAST(2.00 AS Decimal(4, 2)), N'Gói', CAST(1.40 AS Decimal(4, 2)), CAST(1.80 AS Decimal(4, 2)), CAST(159214 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (4, N'Công việc 4', CAST(1.80 AS Decimal(4, 2)), N'Tuýp', CAST(1.30 AS Decimal(4, 2)), CAST(1.60 AS Decimal(4, 2)), CAST(146016 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (5, N'Công việc 5', CAST(2.00 AS Decimal(4, 2)), N'Vỉ', CAST(1.10 AS Decimal(4, 2)), CAST(1.50 AS Decimal(4, 2)), CAST(104247 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (6, N'Công việc 6', CAST(2.20 AS Decimal(4, 2)), N'Chiếc', CAST(1.60 AS Decimal(4, 2)), CAST(1.80 AS Decimal(4, 2)), CAST(165417 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (7, N'Công việc 7', CAST(1.50 AS Decimal(4, 2)), N'Kg', CAST(1.00 AS Decimal(4, 2)), CAST(1.10 AS Decimal(4, 2)), CAST(92664 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (8, N'Công việc 8', CAST(1.70 AS Decimal(4, 2)), N'Gói', CAST(1.60 AS Decimal(4, 2)), CAST(1.10 AS Decimal(4, 2)), CAST(130820 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (9, N'Công việc 9', CAST(1.50 AS Decimal(4, 2)), N'Thùng', CAST(1.30 AS Decimal(4, 2)), CAST(1.40 AS Decimal(4, 2)), CAST(153317 AS Decimal(8, 0)))
INSERT [dbo].[CONGVIEC] ([MaCV], [TenCV], [DinhMucKhoan], [DonViKhoan], [HeSoKhoan], [DinhMucLaoDong], [DonGia]) VALUES (10, N'Công việc 10', CAST(1.30 AS Decimal(4, 2)), N'Kg', CAST(1.00 AS Decimal(4, 2)), CAST(1.20 AS Decimal(4, 2)), CAST(116640 AS Decimal(8, 0)))
SET IDENTITY_INSERT [dbo].[CONGVIEC] OFF
GO
SET IDENTITY_INSERT [dbo].[CONGVIECDALAM] ON 

INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (1, 1, N'SP1', 10, N'SL1', 1)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (2, 2, N'SP2', 30, N'SL1', 2)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (3, 3, N'SP3', 41, N'SL1', 3)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (4, 4, N'SP1', 15, N'SL2', 4)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (5, 3, N'SP2', 35, N'SL2', 5)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (6, 6, N'SP3', 48, N'SL2', 6)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (7, 7, N'SP4', 13, N'SL1', 7)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (8, 2, N'SP5', 36, N'SL1', 8)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (9, 9, N'SP6', 50, N'SL1', 9)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (10, 10, N'SP4', 14, N'SL2', 10)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (11, 1, N'SP5', 40, N'SL2', 11)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (12, 2, N'SP6', 55, N'SL2', 12)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (13, 3, N'SP7', 9, N'SL1', 13)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (14, 4, N'SP8', 33, N'SL1', 14)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (15, 5, N'SP9', 44, N'SL1', 15)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (16, 6, N'SP10', 12, N'SL1', 16)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (17, 7, N'SP1', 39, N'SL3', 17)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (18, 1, N'SP2', 48, N'SL3', 18)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (19, 9, N'SP3', 13, N'SL3', 19)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (20, 10, N'SP4', 31, N'SL3', 20)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (21, 1, N'SP5', 40, N'SL3', 21)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (22, 2, N'SP6', 12, N'SL3', 22)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (23, 2, N'SP7', 36, N'SL2', 23)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (24, 4, N'SP8', 48, N'SL2', 24)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (25, 5, N'SP9', 11, N'SL2', 25)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (26, 1, N'SP10', 31, N'SL2', 26)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (27, 7, N'SP1', 39, N'SL4', 27)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (28, 8, N'SP2', 15, N'SL4', 28)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (29, 9, N'SP3', 37, N'SL4', 29)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (30, 2, N'SP4', 40, N'SL4', 30)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (31, 1, N'SP5', 10, N'SL4', 31)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (32, 2, N'SP6', 12, N'SL4', 34)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (33, 3, N'SP7', 11, N'SL3', 37)
INSERT [dbo].[CONGVIECDALAM] ([ID], [MaCV], [MaSP], [SanLuong], [SoLo], [MaChiTietCaLam]) VALUES (34, 4, N'SP8', 10, N'SL3', 40)
SET IDENTITY_INSERT [dbo].[CONGVIECDALAM] OFF
GO
SET IDENTITY_INSERT [dbo].[CHITIETCALAM] ON 

INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (1, 1, 1, CAST(N'2021-09-01' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (2, 2, 2, CAST(N'2021-09-01' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (3, 3, 3, CAST(N'2021-09-01' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (4, 1, 1, CAST(N'2021-09-02' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (5, 2, 2, CAST(N'2021-09-02' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (6, 3, 3, CAST(N'2021-09-02' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (7, 1, 1, CAST(N'2021-09-03' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (8, 2, 2, CAST(N'2021-09-03' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (9, 3, 3, CAST(N'2021-09-03' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (10, 1, 1, CAST(N'2021-09-04' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (11, 2, 2, CAST(N'2021-09-04' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (12, 3, 3, CAST(N'2021-09-04' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (13, 1, 3, CAST(N'2021-09-06' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (14, 2, 2, CAST(N'2021-09-06' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (15, 3, 1, CAST(N'2021-09-06' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (16, 1, 3, CAST(N'2021-09-07' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (17, 2, 2, CAST(N'2021-09-07' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (18, 3, 1, CAST(N'2021-09-07' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (19, 1, 3, CAST(N'2021-09-08' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (20, 2, 2, CAST(N'2021-09-08' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (21, 3, 1, CAST(N'2021-09-08' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (22, 1, 3, CAST(N'2021-09-09' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (23, 2, 2, CAST(N'2021-09-09' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (24, 3, 1, CAST(N'2021-09-09' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (25, 1, 3, CAST(N'2021-09-10' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (26, 2, 2, CAST(N'2021-09-10' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (27, 3, 1, CAST(N'2021-09-10' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (28, 1, 3, CAST(N'2021-09-11' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (29, 2, 2, CAST(N'2021-09-11' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (30, 3, 1, CAST(N'2021-09-11' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (31, 1, 1, CAST(N'2021-09-27' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (32, 2, 2, CAST(N'2021-09-27' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (33, 3, 3, CAST(N'2021-09-27' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (34, 1, 1, CAST(N'2021-09-28' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (35, 2, 2, CAST(N'2021-09-28' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (36, 3, 3, CAST(N'2021-09-28' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (37, 1, 1, CAST(N'2021-09-29' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (38, 2, 2, CAST(N'2021-09-29' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (39, 3, 3, CAST(N'2021-09-29' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (40, 1, 1, CAST(N'2021-09-30' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (41, 2, 2, CAST(N'2021-09-30' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (42, 3, 3, CAST(N'2021-09-30' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (51, 6, 2, CAST(N'2021-12-13' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (56, 19, 3, CAST(N'2021-12-13' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (57, 19, 2, CAST(N'2021-12-13' AS Date))
INSERT [dbo].[CHITIETCALAM] ([MaChiTietCaLam], [MaTo], [MaCa], [NgayThucHien]) VALUES (58, 17, 1, CAST(N'2021-12-14' AS Date))
SET IDENTITY_INSERT [dbo].[CHITIETCALAM] OFF
GO
SET IDENTITY_INSERT [dbo].[DANHSACHCONGNHAN] ON 

INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (1, 1, 1, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (2, 2, 2, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (3, 2, 3, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (4, 2, 4, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (5, 3, 5, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (6, 3, 6, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (7, 3, 7, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (8, 3, 8, CAST(N'2021-08-30' AS Date), NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (15, 6, 27, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (16, 6, 28, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (17, 6, 29, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (18, 6, 30, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (19, 6, 31, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (20, 6, 32, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (25, 17, 25, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (27, 17, 20, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (28, 17, 23, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (29, 17, 24, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (30, 17, 21, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (31, 18, 16, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (32, 18, 17, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (33, 18, 18, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (34, 18, 19, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (35, 18, 25, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (36, 19, 17, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (37, 19, 14, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (38, 19, 15, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (39, 19, 12, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (40, 19, 10, NULL, NULL)
INSERT [dbo].[DANHSACHCONGNHAN] ([MaDanhSach], [MaTo], [MaCN], [NgayThamGia], [NgayRoi]) VALUES (41, 21, 25, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DANHSACHCONGNHAN] OFF
GO
SET IDENTITY_INSERT [dbo].[NKSLK] ON 

INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (1, 1, CAST(N'2021-09-01' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (2, 1, CAST(N'2021-09-02' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (3, 1, CAST(N'2021-09-03' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (4, 1, CAST(N'2021-09-04' AS Date), CAST(N'07:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (5, 1, CAST(N'2021-09-06' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (6, 1, CAST(N'2021-09-07' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (7, 1, CAST(N'2021-09-08' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (8, 1, CAST(N'2021-09-09' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (9, 1, CAST(N'2021-09-10' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (10, 1, CAST(N'2021-09-11' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (11, 1, CAST(N'2021-09-27' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (12, 1, CAST(N'2021-09-28' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (13, 1, CAST(N'2021-09-29' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (14, 1, CAST(N'2021-09-30' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (15, 2, CAST(N'2021-09-01' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (16, 3, CAST(N'2021-09-01' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (17, 4, CAST(N'2021-09-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (18, 5, CAST(N'2021-09-01' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (19, 6, CAST(N'2021-09-01' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (20, 7, CAST(N'2021-09-01' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (21, 8, CAST(N'2021-09-01' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (22, 2, CAST(N'2021-09-02' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (23, 3, CAST(N'2021-09-02' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (24, 4, CAST(N'2021-09-02' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (25, 5, CAST(N'2021-09-02' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (26, 6, CAST(N'2021-09-02' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (27, 7, CAST(N'2021-09-02' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (28, 8, CAST(N'2021-09-02' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (29, 2, CAST(N'2021-09-03' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (30, 3, CAST(N'2021-09-03' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (31, 4, CAST(N'2021-09-03' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (32, 5, CAST(N'2021-09-03' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (33, 6, CAST(N'2021-09-03' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (34, 7, CAST(N'2021-09-03' AS Date), CAST(N'23:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (35, 8, CAST(N'2021-09-03' AS Date), CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (36, 2, CAST(N'2021-09-04' AS Date), CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (37, 3, CAST(N'2021-09-04' AS Date), CAST(N'14:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (38, 4, CAST(N'2021-09-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (39, 5, CAST(N'2021-09-04' AS Date), CAST(N'23:00:00' AS Time), CAST(N'04:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (40, 6, CAST(N'2021-09-04' AS Date), CAST(N'22:00:00' AS Time), CAST(N'04:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (41, 7, CAST(N'2021-09-04' AS Date), CAST(N'23:00:00' AS Time), CAST(N'05:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (42, 8, CAST(N'2021-09-04' AS Date), CAST(N'23:00:00' AS Time), CAST(N'05:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (43, 2, CAST(N'2021-09-06' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (44, 3, CAST(N'2021-09-06' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (45, 4, CAST(N'2021-09-06' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (46, 5, CAST(N'2021-09-06' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (47, 6, CAST(N'2021-09-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (48, 7, CAST(N'2021-09-06' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (49, 8, CAST(N'2021-09-06' AS Date), CAST(N'07:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (50, 2, CAST(N'2021-09-07' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (51, 3, CAST(N'2021-09-07' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (52, 4, CAST(N'2021-09-07' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (53, 5, CAST(N'2021-09-07' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (54, 6, CAST(N'2021-09-07' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (55, 7, CAST(N'2021-09-07' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (56, 8, CAST(N'2021-09-07' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (57, 2, CAST(N'2021-09-08' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (58, 3, CAST(N'2021-09-08' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (59, 4, CAST(N'2021-09-08' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (60, 5, CAST(N'2021-09-08' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (61, 6, CAST(N'2021-09-08' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (62, 7, CAST(N'2021-09-08' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (63, 8, CAST(N'2021-09-08' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (64, 2, CAST(N'2021-09-09' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (65, 3, CAST(N'2021-09-09' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (66, 4, CAST(N'2021-09-09' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (67, 5, CAST(N'2021-09-09' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (68, 6, CAST(N'2021-09-09' AS Date), CAST(N'07:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (69, 7, CAST(N'2021-09-09' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (70, 8, CAST(N'2021-09-09' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (71, 2, CAST(N'2021-09-10' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (72, 3, CAST(N'2021-09-10' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (73, 4, CAST(N'2021-09-10' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (74, 5, CAST(N'2021-09-10' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (75, 6, CAST(N'2021-09-10' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (76, 7, CAST(N'2021-09-10' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (77, 8, CAST(N'2021-09-10' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (78, 2, CAST(N'2021-09-11' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (79, 3, CAST(N'2021-09-11' AS Date), CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (80, 4, CAST(N'2021-09-11' AS Date), CAST(N'15:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (81, 5, CAST(N'2021-09-11' AS Date), CAST(N'07:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (82, 6, CAST(N'2021-09-11' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (83, 7, CAST(N'2021-09-11' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (84, 8, CAST(N'2021-09-11' AS Date), CAST(N'06:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (92, 16, CAST(N'2021-12-13' AS Date), CAST(N'16:29:38' AS Time), CAST(N'16:29:41' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (115, 36, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (116, 37, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (117, 38, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (118, 39, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (119, 40, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (120, 36, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (121, 37, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (122, 38, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (123, 39, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (124, 40, CAST(N'2021-12-13' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (125, 25, CAST(N'2021-12-14' AS Date), CAST(N'08:52:25' AS Time), CAST(N'08:52:26' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (126, 27, CAST(N'2021-12-14' AS Date), CAST(N'08:52:27' AS Time), CAST(N'08:52:27' AS Time))
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (127, 28, CAST(N'2021-12-14' AS Date), NULL, NULL)
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (128, 29, CAST(N'2021-12-14' AS Date), NULL, NULL)
GO
INSERT [dbo].[NKSLK] ([ID], [MaDanhSach], [NgayThucHien], [GioBatDau], [GioKetThuc]) VALUES (129, 30, CAST(N'2021-12-14' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[NKSLK] OFF
GO
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP1', N'Sản phẩm 1', N'SDK1', CAST(N'2021-04-12' AS Date), 365, N'Quy cách 1', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP10', N'Sản phẩm 10', N'SDK10', CAST(N'2021-05-20' AS Date), 500, N'Quy cách 10', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP2', N'Sản phẩm 2', N'SDK2', CAST(N'2020-05-12' AS Date), 200, N'Quy cách 2', N'~/Image/tai-xuong-36-removebg-preview.png')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP3', N'Sản phẩm 3', N'SDK3', CAST(N'2018-04-01' AS Date), 400, N'Quy cách 3', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP4', N'Sản phẩm 4', N'SDK4', CAST(N'2019-12-12' AS Date), 120, N'Quy cách 4', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP5', N'Sản phẩm 5', N'SDK5', CAST(N'2018-10-12' AS Date), 90, N'Quy cách 5', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP6', N'Sản phẩm 6', N'SDK6', CAST(N'2021-01-20' AS Date), 60, N'Quy cách 6', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP7', N'Sản phẩm 7', N'SDK7', CAST(N'2019-09-28' AS Date), 7, N'Quy cách 7', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP8', N'Sản phẩm 8', N'SDK8', CAST(N'2019-01-16' AS Date), 30, N'Quy cách 8', NULL)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [SoDangKy], [NgayDangKy], [HanSuDung], [QuyCach], [Anh]) VALUES (N'SP9', N'Sản phẩm 9', N'SDK9', CAST(N'2018-03-21' AS Date), 21, N'Quy cách 9', NULL)
GO
INSERT [dbo].[TAIKHOAN] ([TaiKhoan], [MatKhau], [VaiTro]) VALUES (N'admin', N'admin', N'admin')
GO
SET IDENTITY_INSERT [dbo].[TOCONGNHAN] ON 

INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (1, CAST(N'2021-08-30' AS Date), NULL, 1)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (2, CAST(N'2021-08-30' AS Date), NULL, 3)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (3, CAST(N'2021-08-30' AS Date), NULL, 4)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (6, CAST(N'2021-12-11' AS Date), NULL, 6)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (17, CAST(N'2021-12-13' AS Date), NULL, 5)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (18, CAST(N'2021-12-13' AS Date), NULL, 5)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (19, CAST(N'2021-12-13' AS Date), NULL, 5)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (20, CAST(N'2021-12-13' AS Date), NULL, 0)
INSERT [dbo].[TOCONGNHAN] ([MaTo], [NgayTao], [NgayKetThuc], [SoLuong]) VALUES (21, CAST(N'2021-12-14' AS Date), NULL, 1)
SET IDENTITY_INSERT [dbo].[TOCONGNHAN] OFF
GO
ALTER TABLE [dbo].[CONGVIECDALAM]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.CONGVIEC] FOREIGN KEY([MaCV])
REFERENCES [dbo].[CONGVIEC] ([MaCV])
GO
ALTER TABLE [dbo].[CONGVIECDALAM] CHECK CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.CONGVIEC]
GO
ALTER TABLE [dbo].[CONGVIECDALAM]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.CHITIETCALAM] FOREIGN KEY([MaChiTietCaLam])
REFERENCES [dbo].[CHITIETCALAM] ([MaChiTietCaLam])
GO
ALTER TABLE [dbo].[CONGVIECDALAM] CHECK CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.CHITIETCALAM]
GO
ALTER TABLE [dbo].[CONGVIECDALAM]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.SANPHAM] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SANPHAM] ([MaSP])
GO
ALTER TABLE [dbo].[CONGVIECDALAM] CHECK CONSTRAINT [FK_dbo.CONGVIECDALAM_dbo.SANPHAM]
GO
ALTER TABLE [dbo].[CHITIETCALAM]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CHITIETCALAM_dbo.CALAMVIEC] FOREIGN KEY([MaCa])
REFERENCES [dbo].[CALAMVIEC] ([MaCa])
GO
ALTER TABLE [dbo].[CHITIETCALAM] CHECK CONSTRAINT [FK_dbo.CHITIETCALAM_dbo.CALAMVIEC]
GO
ALTER TABLE [dbo].[CHITIETCALAM]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CHITIETCALAM_dbo.TOCONGNHAN] FOREIGN KEY([MaTo])
REFERENCES [dbo].[TOCONGNHAN] ([MaTo])
GO
ALTER TABLE [dbo].[CHITIETCALAM] CHECK CONSTRAINT [FK_dbo.CHITIETCALAM_dbo.TOCONGNHAN]
GO
ALTER TABLE [dbo].[DANHSACHCONGNHAN]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DANHSACHCONGNHAN_dbo.CONGNHAN] FOREIGN KEY([MaCN])
REFERENCES [dbo].[CONGNHAN] ([MaCN])
GO
ALTER TABLE [dbo].[DANHSACHCONGNHAN] CHECK CONSTRAINT [FK_dbo.DANHSACHCONGNHAN_dbo.CONGNHAN]
GO
ALTER TABLE [dbo].[DANHSACHCONGNHAN]  WITH CHECK ADD  CONSTRAINT [FK_dbo.DANHSACHCONGNHAN_dbo.TOCONGNHAN] FOREIGN KEY([MaTo])
REFERENCES [dbo].[TOCONGNHAN] ([MaTo])
GO
ALTER TABLE [dbo].[DANHSACHCONGNHAN] CHECK CONSTRAINT [FK_dbo.DANHSACHCONGNHAN_dbo.TOCONGNHAN]
GO
ALTER TABLE [dbo].[NKSLK]  WITH CHECK ADD  CONSTRAINT [FK_dbo.NKSLK_dbo.DANHSACHCONGNHAN] FOREIGN KEY([MaDanhSach])
REFERENCES [dbo].[DANHSACHCONGNHAN] ([MaDanhSach])
GO
ALTER TABLE [dbo].[NKSLK] CHECK CONSTRAINT [FK_dbo.NKSLK_dbo.DANHSACHCONGNHAN]
GO
/****** Object:  StoredProcedure [dbo].[getCNLamVuotGioChuan]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getCNLamVuotGioChuan] (@firstDay date, @lastDay date)
AS
BEGIN
	DECLARE @gioCongChuan decimal(4,2)	SET @gioCongChuan = 0
	DECLARE @date date
	DECLARE @n int SET @n = DATEDIFF(DAY, @firstDay, @lastDay)
	DECLARE @i int SET @i = 0

	WHILE(@i <= @n)
	BEGIN
		SET @date = DATEADD(DAY, @i, @firstDay)
		IF(DATEPART(dw, @date) != 1)
		BEGIN
			IF(DATEPART(dw, @date) != 7)
			BEGIN
			
				SET @gioCongChuan = @gioCongChuan + 8.00
			END
			ELSE
			BEGIN
				SET @gioCongChuan = @gioCongChuan + 4.00
			END
		END
		SET @i = @i + 1
	END



	DECLARE @table1 TABLE(
		MaCN int,
		TenCN nvarchar(30),
		MaCa int,
		GioBatDau time,
		GioKetThuc time,
		NgayThucHien date,
		SoGioThucHien decimal(4,2)
	)

	INSERT @table1(MaCN, TenCN, NgayThucHien, MaCa, GioBatDau, GioKetThuc)
	SELECT	DANHSACHCONGNHAN.MaCN, CONGNHAN.HoTen, 
			NKSLK.NgayThucHien, CHITIETCALAM.MaCa, NKSLK.GioBatDau, NKSLK.GioKetThuc  
			FROM NKSLK JOIN
			DANHSACHCONGNHAN on NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
			CONGNHAN on CONGNHAN.MaCN = DANHSACHCONGNHAN.MaCN JOIN
			TOCONGNHAN on TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
			CHITIETCALAM on CHITIETCALAM.MaTo = TOCONGNHAN.MaTo
			WHERE CHITIETCALAM.NgayThucHien = NKSLK.NgayThucHien AND (NKSLK.NgayThucHien BETWEEN @firstDay AND @lastDay)


	DECLARE @ngay date
	DECLARE @maca int

	WHILE((select count(*) from @table1 where SoGioThucHien IS NULL) > 0)
	BEGIN
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoGioThucHien IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoGioThucHien = 
			CAST(CAST(DATEDIFF(MINUTE, CAST(@ngay as varchar) + ' ' + CAST(GioBatDau as varchar), 
			CAST(CAST(DATEADD(DAY, 1, @ngay) as date) as varchar) + ' ' + CAST(GioKetThuc as varchar)) as float)/60
			as decimal(4,2))
			WHERE MaCa = @maca
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoGioThucHien = CAST(CAST(DATEDIFF(MINUTE, GioBatDau, GioKetThuc) as float)/60 as decimal(4,2))
			WHERE MaCa = @maca
		END
	END

	SELECT MaCN, TenCN, SUM(SoGioThucHien) as SoGioThucHien
	FROM @table1
	GROUP BY MaCN, TenCN
	HAVING SUM(SoGioThucHien) > @gioCongChuan
	ORDER BY MaCN


END
GO
/****** Object:  StoredProcedure [dbo].[getCVNhieuNKSLK]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCVNhieuNKSLK]

AS
	SELECT *
	FROM
		(SELECT cv.MaCV, cv.TenCV, cv.DinhMucKhoan, cv.DinhMucLaoDong, cv.DonViKhoan, cv.HeSoKhoan, cv.DonGia, COUNT(cv.TenCV) as total
			FROM    NKSLK JOIN
					DANHSACHCONGNHAN ON NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
					TOCONGNHAN ON TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
					CHITIETCALAM ON CHITIETCALAM.MaTo = TOCONGNHAN.MaTo JOIN
					CONGVIECDALAM  ON CONGVIECDALAM.MaChiTietCaLam = CHITIETCALAM.MaChiTietCaLam JOIN
					CONGVIEC as cv ON cv.MaCV = CONGVIECDALAM.MaCV
			WHERE NKSLK.NgayThucHien = CHITIETCALAM.NgayThucHien
			GROUP BY cv.MaCV, cv.TenCV, cv.DinhMucKhoan, cv.DinhMucLaoDong, cv.DonViKhoan, cv.HeSoKhoan, cv.DonGia) as t
	WHERE t.total >= (SELECT MAX(t.total)
					  FROM (SELECT COUNT(cv.TenCV) as total
							FROM    NKSLK JOIN
									DANHSACHCONGNHAN ON NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
									TOCONGNHAN ON TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
									CHITIETCALAM ON CHITIETCALAM.MaTo = TOCONGNHAN.MaTo JOIN
									CONGVIECDALAM  ON CONGVIECDALAM.MaChiTietCaLam = CHITIETCALAM.MaChiTietCaLam JOIN
									CONGVIEC as cv ON cv.MaCV = CONGVIECDALAM.MaCV
							WHERE NKSLK.NgayThucHien = CHITIETCALAM.NgayThucHien
							GROUP BY cv.TenCV) as t)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[getLuongCN]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getLuongCN](@firstDay date, @lastDay date)
AS
BEGIN

DECLARE @table1 TABLE(
	MaTo int,
	SoLuongCNTrongTo int,
	MaCN int,
	TenCN nvarchar(30),
	NgayThucHien date,
	MaCa int,
	GioBatDau time,
	GioKetThuc time,
	SoGioThucHien decimal(4,2),
	SanLuong int,
	DonGia decimal(8,0),
	LuongCN decimal(8,0)
)

INSERT @table1(MaTo, SoLuongCNTrongTo, MaCN, TenCN, NgayThucHien, MaCa, GioBatDau, GioKetThuc, SanLuong, DonGia)
SELECT TOCONGNHAN.MaTo, TOCONGNHAN.SoLuong as SoLuongCN, DANHSACHCONGNHAN.MaCN, CONGNHAN.HoTen, 
		NKSLK.NgayThucHien, CHITIETCALAM.MaCa, NKSLK.GioBatDau, NKSLK.GioKetThuc, CONGVIECDALAM.SanLuong, 
		CONGVIEC.DonGia  from 
		NKSLK JOIN
		DANHSACHCONGNHAN on NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
		CONGNHAN on CONGNHAN.MaCN = DANHSACHCONGNHAN.MaCN JOIN
		TOCONGNHAN on TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
		CHITIETCALAM on CHITIETCALAM.MaTo = TOCONGNHAN.MaTo	JOIN
		CONGVIECDALAM on CONGVIECDALAM.MaChiTietCaLam = CHITIETCALAM.MaChiTietCaLam JOIN
		CONGVIEC ON CONGVIEC.MaCV = CONGVIECDALAM.MaCV
		WHERE CHITIETCALAM.NgayThucHien = NKSLK.NgayThucHien AND NKSLK.NgayThucHien BETWEEN @firstDay AND @lastDay
		ORDER BY NKSLK.NgayThucHien, DANHSACHCONGNHAN.MaCN

DECLARE @ngay date
DECLARE @maca int
DECLARE @macn int

while((select count(*) from @table1 where SoGioThucHien IS NULL) > 0)
BEGIN
	
	SELECT @maca = t.MaCa, @ngay = t.NgayThucHien, @macn = t.MaCN 
	FROM (SELECT TOP 1 * FROM @table1 WHERE SoGioThucHien IS NULL) as t
	IF(@maca = 3)
	BEGIN
		UPDATE @table1 SET SoGioThucHien = 
		CAST(CAST(DATEDIFF(MINUTE, CAST(@ngay as varchar) + ' ' + CAST(GioBatDau as varchar), 
		CAST(CAST(DATEADD(DAY, 1, @ngay) as date) as varchar) + ' ' + CAST(GioKetThuc as varchar)) as float)/60
		as decimal(4,2))
		WHERE MaCa = @maca
	END
	ELSE
	BEGIN
		UPDATE @table1 
		SET SoGioThucHien = CAST(CAST(DATEDIFF(MINUTE, GioBatDau, GioKetThuc) as float)/60 as decimal(4,2))
		WHERE MaCa = @maca
	END
END


DECLARE @table2 TABLE(
	MaTo int,
	NgayThucHien date,
	SoGioLamCaTo decimal(4,2)
)

INSERT @table2 SELECT MaTo, NgayThucHien, SUM(SoGioThucHien)
FROM @table1 
GROUP BY NgayThucHien, MaTo

DECLARE @soluongCN int

WHILE((SELECT COUNT(*) FROM @table1 WHERE LuongCN IS NULL) > 0)
BEGIN
	SELECT @soluongCN = t.SoLuongCNTrongTo, @ngay = t.NgayThucHien, @macn = t.MaCN 
	FROM (SELECT TOP 1 * FROM @table1 WHERE LuongCN IS NULL) as t
	IF(@soluongCN = 1)
	BEGIN
		UPDATE @table1 
		SET LuongCN = SanLuong * DonGia
		WHERE NgayThucHien = @ngay AND MaCN = @macn
	END
	ELSE
	BEGIN
		UPDATE @table1 
		SET LuongCN = 
		(SELECT t1.SanLuong * t1.DonGia *(t1.SoGioThucHien/t2.SoGioLamCaTo) 
						FROM @table1 as t1 
						JOIN @table2 as t2 ON t1.MaTo = t2.MaTo AND t1.NgayThucHien = t2.NgayThucHien
						WHERE t1.NgayThucHien = @ngay AND MaCN = @macn)
		WHERE NgayThucHien = @ngay AND MaCN = @macn
	END
END

SELECT t1.MaCN, t1.TenCN, t1.MaTo, SUM(t1.LuongCN) as Luong
FROM @table1 as t1 
GROUP BY MaCN, TenCN, MaTo 
ORDER BY MaCN



END
GO
/****** Object:  StoredProcedure [dbo].[getMaxMinLuongSP]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getMaxMinLuongSP](@type int)
AS
BEGIN
	DECLARE @table1 TABLE(
		MaTo int,
		SoLuongCNTrongTo int,
		MaCN int,
		TenCN nvarchar(30),
		NgayThucHien date,
		MaCa int,
		GioBatDau time,
		GioKetThuc time,
		SoGioThucHien decimal(4,2),
		SanLuong int,
		DonGia decimal(8,0),
		LuongCN decimal(8,0)
	)

	INSERT @table1(MaTo, SoLuongCNTrongTo, MaCN, TenCN, NgayThucHien, MaCa, GioBatDau, GioKetThuc, SanLuong, DonGia)
	SELECT TOCONGNHAN.MaTo, TOCONGNHAN.SoLuong as SoLuongCN, DANHSACHCONGNHAN.MaCN, CONGNHAN.HoTen, 
			NKSLK.NgayThucHien, CHITIETCALAM.MaCa, NKSLK.GioBatDau, NKSLK.GioKetThuc, CONGVIECDALAM.SanLuong, 
			CONGVIEC.DonGia  from 
			NKSLK JOIN
			DANHSACHCONGNHAN on NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
			CONGNHAN on CONGNHAN.MaCN = DANHSACHCONGNHAN.MaCN JOIN
			TOCONGNHAN on TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
			CHITIETCALAM on CHITIETCALAM.MaTo = TOCONGNHAN.MaTo	JOIN
			CONGVIECDALAM on CONGVIECDALAM.MaChiTietCaLam = CHITIETCALAM.MaChiTietCaLam JOIN
			CONGVIEC ON CONGVIEC.MaCV = CONGVIECDALAM.MaCV
			WHERE CHITIETCALAM.NgayThucHien = NKSLK.NgayThucHien

	DECLARE @ngay date
	DECLARE @maca int
	DECLARE @macn int

	while((select count(*) from @table1 where SoGioThucHien IS NULL) > 0)
	BEGIN
	
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien, @macn = t.MaCN 
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoGioThucHien IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoGioThucHien = 
			CAST(CAST(DATEDIFF(MINUTE, CAST(@ngay as varchar) + ' ' + CAST(GioBatDau as varchar), 
			CAST(CAST(DATEADD(DAY, 1, @ngay) as date) as varchar) + ' ' + CAST(GioKetThuc as varchar)) as float)/60
			as decimal(4,2))
			WHERE MaCa = @maca
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoGioThucHien = CAST(CAST(DATEDIFF(MINUTE, GioBatDau, GioKetThuc) as float)/60 as decimal(4,2))
			WHERE MaCa = @maca
		END
	END


	DECLARE @table2 TABLE(
		MaTo int,
		NgayThucHien date,
		SoGioLamCaTo decimal(4,2)
	)

	INSERT @table2 SELECT MaTo, NgayThucHien, SUM(SoGioThucHien)
	FROM @table1 
	GROUP BY NgayThucHien, MaTo

	DECLARE @soluongCN int

	WHILE((SELECT COUNT(*) FROM @table1 WHERE LuongCN IS NULL) > 0)
	BEGIN
		SELECT @soluongCN = t.SoLuongCNTrongTo, @ngay = t.NgayThucHien, @macn = t.MaCN 
		FROM (SELECT TOP 1 * FROM @table1 WHERE LuongCN IS NULL) as t
		IF(@soluongCN = 1)
		BEGIN
			UPDATE @table1 
			SET LuongCN = SanLuong * DonGia
			WHERE NgayThucHien = @ngay AND MaCN = @macn
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET LuongCN = 
			(SELECT t1.SanLuong * t1.DonGia *(t1.SoGioThucHien/t2.SoGioLamCaTo) 
							FROM @table1 as t1 
							JOIN @table2 as t2 ON t1.MaTo = t2.MaTo AND t1.NgayThucHien = t2.NgayThucHien
							WHERE t1.NgayThucHien = @ngay AND MaCN = @macn)
			WHERE NgayThucHien = @ngay AND MaCN = @macn
		END
	END

	IF(@type = 1)
	BEGIN
		SELECT * FROM @table1 WHERE LuongCN = (SELECT MAX(LuongCN) FROM @table1)
	END
	ELSE IF(@type = 0)
	BEGIN
		SELECT * FROM @table1 WHERE LuongCN = (SELECT MIN(LuongCN) FROM @table1)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[getSoNgayCong]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getSoNgayCong](@MaCN int, @firstDay date, @lastDay date)
AS
BEGIN
	DECLARE @table1 TABLE(
		MaCN int,
		TenCN nvarchar(30),
		MaCa int,
		GioBatDau time,
		GioKetThuc time,
		NgayThucHien date,
		SoGioThucHien decimal(4,2),
		SoNgayCong decimal(4,2)
	)
	INSERT @table1(MaCN, TenCN, NgayThucHien, MaCa, GioBatDau, GioKetThuc)
	SELECT	DANHSACHCONGNHAN.MaCN, CONGNHAN.HoTen, 
			NKSLK.NgayThucHien, CHITIETCALAM.MaCa, NKSLK.GioBatDau, NKSLK.GioKetThuc  
			FROM NKSLK JOIN
			DANHSACHCONGNHAN on NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
			CONGNHAN on CONGNHAN.MaCN = DANHSACHCONGNHAN.MaCN JOIN
			TOCONGNHAN on TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
			CHITIETCALAM on CHITIETCALAM.MaTo = TOCONGNHAN.MaTo
			WHERE CHITIETCALAM.NgayThucHien = NKSLK.NgayThucHien AND (NKSLK.NgayThucHien BETWEEN @firstDay AND @lastDay)
					AND DANHSACHCONGNHAN.MaCN = @MaCN

	DECLARE @ngay date
	DECLARE @maca int

	WHILE((select count(*) from @table1 where SoGioThucHien IS NULL) > 0)
	BEGIN
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien 
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoGioThucHien IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoGioThucHien = 
			CAST(CAST(DATEDIFF(MINUTE, CAST(@ngay as varchar) + ' ' + CAST(GioBatDau as varchar), 
			CAST(CAST(DATEADD(DAY, 1, @ngay) as date) as varchar) + ' ' + CAST(GioKetThuc as varchar)) as float)/60
			as decimal(4,2))
			WHERE MaCa = @maca
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoGioThucHien = CAST(CAST(DATEDIFF(MINUTE, GioBatDau, GioKetThuc) as float)/60 as decimal(4,2))
			WHERE MaCa = @maca
		END
	END

	WHILE((SELECT count(*) FROM @table1 WHERE SoNgayCong IS NULL) > 0)
	BEGIN
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoNgayCong IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoNgayCong = SoGioThucHien / 8 * 1.3
			WHERE NgayThucHien = @ngay AND MaCN = @MaCN
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoNgayCong = SoGioThucHien / 8
			WHERE NgayThucHien = @ngay AND MaCN = @MaCN
		END
	END

	SELECT MaCN, TenCN, SUM(SoNgayCong) as TongSoNgayCong
	FROM @table1
	GROUP BY MaCN, TenCN

	--SELECT * FROM @table1
END
GO
/****** Object:  StoredProcedure [dbo].[getSoNgayCong1]    Script Date: 12/30/2021 10:29:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getSoNgayCong1](@firstDay date, @lastDay date)
AS
BEGIN
	DECLARE @table1 TABLE(
		MaCN int,
		TenCN nvarchar(30),
		MaCa int,
		GioBatDau time,
		GioKetThuc time,
		NgayThucHien date,
		SoGioThucHien decimal(4,2),
		SoNgayCong decimal(4,2)
	)
	INSERT @table1(MaCN, TenCN, NgayThucHien, MaCa, GioBatDau, GioKetThuc)
	SELECT	DANHSACHCONGNHAN.MaCN, CONGNHAN.HoTen, 
			NKSLK.NgayThucHien, CHITIETCALAM.MaCa, NKSLK.GioBatDau, NKSLK.GioKetThuc  
			FROM NKSLK JOIN
			DANHSACHCONGNHAN on NKSLK.MaDanhSach = DANHSACHCONGNHAN.MaDanhSach JOIN
			CONGNHAN on CONGNHAN.MaCN = DANHSACHCONGNHAN.MaCN JOIN
			TOCONGNHAN on TOCONGNHAN.MaTo = DANHSACHCONGNHAN.MaTo JOIN
			CHITIETCALAM on CHITIETCALAM.MaTo = TOCONGNHAN.MaTo
			WHERE CHITIETCALAM.NgayThucHien = NKSLK.NgayThucHien AND 
					(NKSLK.NgayThucHien BETWEEN @firstDay AND @lastDay)

	DECLARE @ngay date
	DECLARE @maca int
	DECLARE @macn int

	WHILE((select count(*) from @table1 where SoGioThucHien IS NULL) > 0)
	BEGIN
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien 
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoGioThucHien IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoGioThucHien = 
			CAST(CAST(DATEDIFF(MINUTE, CAST(@ngay as varchar) + ' ' + CAST(GioBatDau as varchar), 
			CAST(CAST(DATEADD(DAY, 1, @ngay) as date) as varchar) + ' ' + CAST(GioKetThuc as varchar)) as float)/60
			as decimal(4,2))
			WHERE MaCa = @maca
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoGioThucHien = CAST(CAST(DATEDIFF(MINUTE, GioBatDau, GioKetThuc) as float)/60 as decimal(4,2))
			WHERE MaCa = @maca
		END
	END

	WHILE((SELECT count(*) FROM @table1 WHERE SoNgayCong IS NULL) > 0)
	BEGIN
		SELECT @maca = t.MaCa, @ngay = t.NgayThucHien, @macn = MaCN
		FROM (SELECT TOP 1 * FROM @table1 WHERE SoNgayCong IS NULL) as t
		IF(@maca = 3)
		BEGIN
			UPDATE @table1 SET SoNgayCong = SoGioThucHien / 8 * 1.3
			WHERE NgayThucHien = @ngay AND MaCN = @MaCN
		END
		ELSE
		BEGIN
			UPDATE @table1 
			SET SoNgayCong = SoGioThucHien / 8
			WHERE NgayThucHien = @ngay AND MaCN = @MaCN
		END
	END

	SELECT MaCN, TenCN, SUM(SoNgayCong) as TongSoNgayCong
	FROM @table1
	GROUP BY MaCN, TenCN
	ORDER BY MaCN

	--SELECT * FROM @table1
END
GO
