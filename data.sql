USE [DB_QLSieuThi]
GO
INSERT [dbo].[THANTHIET] ([MucThanThiet], [QuaTang], [MucGiamMemberSale], [GiaTriMuaSamToiThieu], [GiaTriMuaSamToiDa]) VALUES (N'T1', 1, CAST(5.00 AS Decimal(5, 2)), 100000, 500000)
INSERT [dbo].[THANTHIET] ([MucThanThiet], [QuaTang], [MucGiamMemberSale], [GiaTriMuaSamToiThieu], [GiaTriMuaSamToiDa]) VALUES (N'T2', 2, CAST(10.00 AS Decimal(5, 2)), 200000, 1000000)
INSERT [dbo].[THANTHIET] ([MucThanThiet], [QuaTang], [MucGiamMemberSale], [GiaTriMuaSamToiThieu], [GiaTriMuaSamToiDa]) VALUES (N'T3', 3, CAST(15.00 AS Decimal(5, 2)), 500000, 2000000)
GO
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SDT], [NgaySinh], [DiaChi], [MucThanThiet], [NgayLap]) VALUES (N'KH001', N'Nguyễn Văn A', N'0123456789', CAST(N'1990-01-01' AS Date), N'123 Đường ABC, Quận 1, TP.HCM', N'T1', CAST(N'2024-11-01' AS Date))
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SDT], [NgaySinh], [DiaChi], [MucThanThiet], [NgayLap]) VALUES (N'KH002', N'Trần Thị B', N'0987654321', CAST(N'1985-05-15' AS Date), N'456 Đường DEF, Quận 2, TP.HCM', N'T2', CAST(N'2024-11-10' AS Date))
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SDT], [NgaySinh], [DiaChi], [MucThanThiet], [NgayLap]) VALUES (N'KH003', N'Phạm Minh C', N'0912345678', CAST(N'2000-08-20' AS Date), N'789 Đường GHI, Quận 3, TP.HCM', N'T3', CAST(N'2024-12-01' AS Date))
GO
INSERT [dbo].[PHIEUMUAHANG] ([MaPhieuMuaHang], [MaKH], [QuaTang], [TrangThai], [NgayBatDau], [NgayKetThuc]) VALUES (N'PMH001', N'KH001', 50000, N'Chưa sử dụng', CAST(N'2024-11-01' AS Date), CAST(N'2024-11-10' AS Date))
INSERT [dbo].[PHIEUMUAHANG] ([MaPhieuMuaHang], [MaKH], [QuaTang], [TrangThai], [NgayBatDau], [NgayKetThuc]) VALUES (N'PMH002', N'KH002', 10000, N'Chưa sử dụng', CAST(N'2024-11-05' AS Date), CAST(N'2024-11-15' AS Date))
INSERT [dbo].[PHIEUMUAHANG] ([MaPhieuMuaHang], [MaKH], [QuaTang], [TrangThai], [NgayBatDau], [NgayKetThuc]) VALUES (N'PMH003', N'KH003', 100000, N'Chưa sử dụng', CAST(N'2024-12-01' AS Date), CAST(N'2024-12-10' AS Date))
GO
INSERT [dbo].[DONHANG] ([MaDH], [MaKH], [NgayLap], [MaPhieuMuaHang], [HinhThucDatHang], [TongTien], [ThanhTien]) VALUES (N'DH001', N'KH001', CAST(N'2024-11-01' AS Date), NULL, N'Online', 0, 0)
INSERT [dbo].[DONHANG] ([MaDH], [MaKH], [NgayLap], [MaPhieuMuaHang], [HinhThucDatHang], [TongTien], [ThanhTien]) VALUES (N'DH002', N'KH002', CAST(N'2024-11-02' AS Date), NULL, N'Offine', 0, 0)
INSERT [dbo].[DONHANG] ([MaDH], [MaKH], [NgayLap], [MaPhieuMuaHang], [HinhThucDatHang], [TongTien], [ThanhTien]) VALUES (N'DH003', N'KH003', CAST(N'2024-11-03' AS Date), NULL, N'Online', 0, 0)
INSERT [dbo].[DONHANG] ([MaDH], [MaKH], [NgayLap], [MaPhieuMuaHang], [HinhThucDatHang], [TongTien], [ThanhTien]) VALUES (N'DH004', N'KH001', CAST(N'2024-11-04' AS Date), NULL, N'Offine', 0, 0)
INSERT [dbo].[DONHANG] ([MaDH], [MaKH], [NgayLap], [MaPhieuMuaHang], [HinhThucDatHang], [TongTien], [ThanhTien]) VALUES (N'DH005', N'KH002', CAST(N'2024-11-05' AS Date), NULL, N'Online', 0, 0)
GO
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM001', CAST(N'2024-11-01' AS Date), CAST(N'2025-11-30' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM002', CAST(N'2024-11-10' AS Date), CAST(N'2025-12-10' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM003', CAST(N'2024-12-01' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM004', CAST(N'2024-12-01' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM005', CAST(N'2024-02-01' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM006', CAST(N'2024-07-21' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [dbo].[SALE] ([MaKM], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM007', CAST(N'2024-07-12' AS Date), CAST(N'2025-12-31' AS Date))
GO
INSERT [dbo].[MEMBERSALE] ([MaKM], [MucThanThiet], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM004', N'T1', CAST(0.30 AS Decimal(5, 2)), 50, 0)
INSERT [dbo].[MEMBERSALE] ([MaKM], [MucThanThiet], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM005', N'T2', CAST(0.30 AS Decimal(5, 2)), 50, 0)
INSERT [dbo].[MEMBERSALE] ([MaKM], [MucThanThiet], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM006', N'T3', CAST(0.30 AS Decimal(5, 2)), 50, 0)
GO
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM001', N'Dồ uống', N'Nước giải khát, sữa các loại')
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM002', N'Bánh kẹo', N'Bánh quy, bánh mì, các loại kẹo')
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM003', N'Mỹ phẩm', N'Chăm sóc sắc đẹp, kem dưỡng da')
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM004', N'Hàng gia dụng', N'Sản phẩm sử dụng trong gia đình như bột giặt, nước rửa chén')
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM005', N'Gia vị và thực phẩm đóng hộp', N'Gia vị và các loại thực phẩm tiện lợi, đóng hộp')
INSERT [dbo].[DANHMUC] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'DM006', N'Mỹ phẩm và làm đẹp', N'Sản phẩm mỹ phẩm và chăm sóc cá nhân, làm đẹp')
GO
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP001', N'Sữa tươi', N'DM001', 100, N'Vinamilk', 30000, N'Sữa tươi chất lượng cao')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP002', N'Bánh quy', N'DM002', 200, N'Kinh Đô', 50000, N'Bánh quy giòn thơm ngon')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP003', N'Kem đánh răng', N'DM003', 150, N'Colgate', 20000, N'Kem đánh răng trắng răng')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP004', N'Nước ngọt Coca-Cola', N'DM001', 300, N'Coca-Cola', 15000, N'Nước ngọt giải khát')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP005', N'Mì ăn liền', N'DM002', 500, N'Acecook', 6000, N'Mì ăn liền tiện lợi')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP006', N'Dầu gội Head & Shoulders', N'DM003', 100, N'P&G', 120000, N'Dầu gội sạch gàu')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP007', N'Bột giặt OMO', N'DM004', 200, N'Unilever', 45000, N'Bột giặt trắng sạch vượt trội')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP008', N'Nước tương Maggi', N'DM005', 250, N'Nestle', 20000, N'Nước tương ngon đậm đà')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP009', N'Sữa đặc Ông Thọ', N'DM001', 150, N'Vinamilk', 25000, N'Sữa đặc ngon cho nấu ăn')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP010', N'Trái cây sấy khô', N'DM002', 100, N'Lâm Đồng', 75000, N'Trái cây sấy khô bổ dưỡng')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP011', N'Son môi', N'DM006', 80, N'Maybelline', 150000, N'Son môi màu đẹp và dưỡng môi')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP012', N'Nước rửa chén Sunlight', N'DM004', 300, N'Unilever', 30000, N'Nước rửa chén sạch dầu mỡ')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP013', N'Cháo ăn liền', N'DM002', 200, N'VinaBowl', 10000, N'Cháo ăn liền tiện lợi')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP014', N'Xịt khử mùi', N'DM003', 150, N'Axe', 90000, N'Xịt khử mùi thơm mát cả ngày')
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [MaDanhMuc], [SoLuongTD], [NSX], [GiaNiemYet], [MoTa]) VALUES (N'SP015', N'Thịt hộp Spam', N'DM005', 120, N'Hormel Foods', 60000, N'Thịt hộp cao cấp và tiện lợi')
GO
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH001', N'SP001', 2, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH001', N'SP002', 1, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH002', N'SP001', 3, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH002', N'SP002', 2, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH003', N'SP002', 1, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH003', N'SP003', 2, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH003', N'SP004', 2, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH004', N'SP002', 3, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH004', N'SP003', 4, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH004', N'SP005', 1, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH005', N'SP001', 5, 0, NULL, 0, 0)
INSERT [dbo].[CHITIETDH] ([MaDH], [MaSP], [SoLuong], [GiaNiemYet], [MaKM], [SoLuongSPDaApDung], [ThanhTien]) VALUES (N'DH005', N'SP002', 5, 0, NULL, 0, 0)
GO
INSERT [dbo].[FLASHSALE] ([MaKM], [MaSP], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM001', N'SP001', CAST(0.30 AS Decimal(5, 2)), 50, 0)
INSERT [dbo].[FLASHSALE] ([MaKM], [MaSP], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM002', N'SP002', CAST(0.20 AS Decimal(5, 2)), 100, 0)
GO
INSERT [dbo].[COMBOSALE] ([MaKM], [MaSP1], [MaSP2], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM003', N'SP001', N'SP002', CAST(0.25 AS Decimal(5, 2)), 40, 0)
INSERT [dbo].[COMBOSALE] ([MaKM], [MaSP1], [MaSP2], [TiLeGiamGia], [SoLuongGioiHan], [SoLuongSPDaApDung]) VALUES (N'KM007', N'SP003', N'SP004', CAST(0.25 AS Decimal(5, 2)), 40, 0)
GO
INSERT [dbo].[DONDATHANG] ([MaDDH], [MaSP], [GiaNhap], [SoLuongDat], [SoLuongNhan], [NgayDat], [NgayNhanDuKien], [TrangThai]) VALUES (N'DDH001', N'SP001', 25000, 20, 20, CAST(N'2024-11-05' AS Date), CAST(N'2024-11-10' AS Date), N'Đã nhận')
INSERT [dbo].[DONDATHANG] ([MaDDH], [MaSP], [GiaNhap], [SoLuongDat], [SoLuongNhan], [NgayDat], [NgayNhanDuKien], [TrangThai]) VALUES (N'DDH002', N'SP002', 40000, 50, 50, CAST(N'2024-11-10' AS Date), CAST(N'2024-11-15' AS Date), N'Chưa nhận')
GO
INSERT [dbo].[LOHANG] ([MaLH], [MaSP], [MaDDH], [SoLuong], [HSD], [NgayNhan]) VALUES (N'LH001', N'SP001', N'DDH001', 50, CAST(N'2024-12-01' AS Date), CAST(N'2024-11-10' AS Date))
INSERT [dbo].[LOHANG] ([MaLH], [MaSP], [MaDDH], [SoLuong], [HSD], [NgayNhan]) VALUES (N'LH002', N'SP002', N'DDH002', 100, CAST(N'2024-12-15' AS Date), CAST(N'2024-11-15' AS Date))
GO
INSERT [dbo].[LICHSUGIA] ([MaGia], [MaSP], [NgayBatDau], [NgayKetThuc], [GiaBan]) VALUES (N'LG001', N'SP001', CAST(N'2024-10-01' AS Date), CAST(N'2024-10-30' AS Date), 28000)
INSERT [dbo].[LICHSUGIA] ([MaGia], [MaSP], [NgayBatDau], [NgayKetThuc], [GiaBan]) VALUES (N'LG002', N'SP002', CAST(N'2024-11-01' AS Date), CAST(N'2024-11-30' AS Date), 45000)
GO
