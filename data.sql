-- ================= Thêm dữ liệu mẫu cho tất cả các bảng =================
USE DB_QLSieuThi
GO

-- Bảng THANTHIET
INSERT INTO THANTHIET (MucThanThiet, QuaTang, MucGiamMemberSale, GiaTriMuaSamToiThieu, GiaTriMuaSamToiDa)
VALUES ('T1', 1, 5.00, 100000, 500000);
INSERT INTO THANTHIET (MucThanThiet, QuaTang, MucGiamMemberSale, GiaTriMuaSamToiThieu, GiaTriMuaSamToiDa)
VALUES ('T2', 2, 10.00, 200000, 1000000);
INSERT INTO THANTHIET (MucThanThiet, QuaTang, MucGiamMemberSale, GiaTriMuaSamToiThieu, GiaTriMuaSamToiDa)
VALUES ('T3', 3, 15.00, 500000, 2000000);

-- Bảng KHACHHANG
INSERT INTO KHACHHANG (MaKH, TenKH, SDT, NgaySinh, DiaChi, MucThanThiet, NgayLap)
VALUES ('KH001', N'Nguyễn Văn A', '0123456789', '1990-01-01', N'123 Đường ABC, Quận 1, TP.HCM', 'T1', '2024-11-01');
INSERT INTO KHACHHANG (MaKH, TenKH, SDT, NgaySinh, DiaChi, MucThanThiet, NgayLap)
VALUES ('KH002', N'Trần Thị B', '0987654321', '1985-05-15', N'456 Đường DEF, Quận 2, TP.HCM', 'T2', '2024-11-10');
INSERT INTO KHACHHANG (MaKH, TenKH, SDT, NgaySinh, DiaChi, MucThanThiet, NgayLap)
VALUES ('KH003', N'Phạm Minh C', '0912345678', '2000-08-20', N'789 Đường GHI, Quận 3, TP.HCM', 'T3', '2024-12-01');

-- Bảng PHIEUMUAHANG
INSERT INTO PHIEUMUAHANG (MaPhieuMuaHang, MaKH, QuaTang, TrangThai, NgayBatDau, NgayKetThuc)
VALUES ('PMH001', 'KH001', 1, N'Đang xử lý', '2024-11-01', '2024-11-10');
INSERT INTO PHIEUMUAHANG (MaPhieuMuaHang, MaKH, QuaTang, TrangThai, NgayBatDau, NgayKetThuc)
VALUES ('PMH002', 'KH002', 2, N'Đã hoàn thành', '2024-11-05', '2024-11-15');
INSERT INTO PHIEUMUAHANG (MaPhieuMuaHang, MaKH, QuaTang, TrangThai, NgayBatDau, NgayKetThuc)
VALUES ('PMH003', 'KH003', 1, N'Đang xử lý', '2024-12-01', '2024-12-10');

-- Bảng SALE
INSERT INTO SALE (MaKM, ThoiGianBatDau, ThoiGianKetThuc)
VALUES ('KM001', '2024-11-01', '2024-11-30');
INSERT INTO SALE (MaKM, ThoiGianBatDau, ThoiGianKetThuc)
VALUES ('KM002', '2024-11-10', '2024-12-10');
INSERT INTO SALE (MaKM, ThoiGianBatDau, ThoiGianKetThuc)
VALUES ('KM003', '2024-12-01', '2024-12-31');
INSERT INTO SALE (MaKM, ThoiGianBatDau, ThoiGianKetThuc)
VALUES ('KM004', '2024-12-01', '2024-12-31');

-- Bảng DANHMUC
INSERT INTO DANHMUC (MaDanhMuc, TenDanhMuc, MoTa)
VALUES ('DM001', N'Dồ uống', N'Nước giải khát, sữa các loại');
INSERT INTO DANHMUC (MaDanhMuc, TenDanhMuc, MoTa)
VALUES ('DM002', N'Bánh kẹo', N'Bánh quy, bánh mì, các loại kẹo');
INSERT INTO DANHMUC (MaDanhMuc, TenDanhMuc, MoTa)
VALUES ('DM003', N'Mỹ phẩm', N'Chăm sóc sắc đẹp, kem dưỡng da');

-- Bảng SANPHAM
INSERT INTO SANPHAM (MaSP, TenSP, MaDanhMuc, SoLuongTD, NSX, GiaNiemYet, MoTa)
VALUES ('SP001', N'Sữa tươi', 'DM001', 100, N'Vinamilk', 30000, N'Sữa tươi chất lượng cao');
INSERT INTO SANPHAM (MaSP, TenSP, MaDanhMuc, SoLuongTD, NSX, GiaNiemYet, MoTa)
VALUES ('SP002', N'Bánh quy', 'DM002', 200, N'Kinh Đô', 50000, N'Bánh quy giòn thơm ngon');
INSERT INTO SANPHAM (MaSP, TenSP, MaDanhMuc, SoLuongTD, NSX, GiaNiemYet, MoTa)
VALUES ('SP003', N'Kem đánh răng', 'DM003', 150, N'Colgate', 20000, N'Kem đánh răng trắng răng');

-- Bảng FLASHSALE 
INSERT INTO FLASHSALE (MaKM, MaSP, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM001', 'SP001', 0.30, 50, 10); 
INSERT INTO FLASHSALE (MaKM, MaSP, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM002', 'SP002', 0.20, 100, 20); 
INSERT INTO FLASHSALE (MaKM, MaSP, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM003', 'SP003', 0.15, 30, 5);
INSERT INTO FLASHSALE (MaKM, MaSP, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM004', 'SP002', 0.30, 50, 10); 

-- Bảng COMBOSALE
INSERT INTO COMBOSALE (MaKM, MaSP1, MaSP2, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM001', 'SP001', 'SP002', 0.25, 40, 5);
INSERT INTO COMBOSALE (MaKM, MaSP1, MaSP2, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM002', 'SP002', 'SP003', 0.10, 60, 10);

-- Bảng MEMBERSALE
INSERT INTO MEMBERSALE (MaKM, MaSP, MucThanThiet, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM001', 'SP001', 'T1', 0.30, 50, 10);
INSERT INTO MEMBERSALE (MaKM, MaSP, MucThanThiet, TiLeGiamGia, SoLuongGioiHan, SoLuongSPDaApDung)
VALUES ('KM002', 'SP002', 'T2', 0.20, 100, 20);

-- Bảng LICHSUGIA 
INSERT INTO LICHSUGIA (MaGia, MaSP, NgayBatDau, NgayKetThuc, GiaBan)
VALUES ('LG001', 'SP001', '2024-10-01', '2024-10-30', 28000);
INSERT INTO LICHSUGIA (MaGia, MaSP, NgayBatDau, NgayKetThuc, GiaBan)
VALUES ('LG002', 'SP002', '2024-11-01', '2024-11-30', 45000);

-- Bảng DONDATHANG
INSERT INTO DONDATHANG (MaDDH, MaSP, GiaNhap, SoLuongDat, SoLuongNhan, NgayDat, NgayNhanDuKien, TrangThai)
VALUES ('DDH001', 'SP001', 25000, 20, 20, '2024-11-05', '2024-11-10', N'Đã nhận');
INSERT INTO DONDATHANG (MaDDH, MaSP, GiaNhap, SoLuongDat, SoLuongNhan, NgayDat, NgayNhanDuKien, TrangThai)
VALUES ('DDH002', 'SP002', 40000, 50, 50, '2024-11-10', '2024-11-15', N'Chưa nhận');

-- Bảng LOHANG 
INSERT INTO LOHANG (MaLH, MaSP, MaDDH, SoLuong, HSD, NgayNhan)
VALUES ('LH001', 'SP001', 'DDH001', 50, '2024-12-01', '2024-11-10');
INSERT INTO LOHANG (MaLH, MaSP, MaDDH, SoLuong, HSD, NgayNhan)
VALUES ('LH002', 'SP002', 'DDH002', 100, '2024-12-15', '2024-11-15');

-- Bảng DONHANG
INSERT INTO DONHANG (MaDH, MaKH, NgayLap, MaPhieuMuaHang, HinhThucDatHang, TongTien, ThanhTien)
VALUES ('DH001', 'KH001', '2024-11-01', 'PMH001', 'Online', 100000, 95000);
INSERT INTO DONHANG (MaDH, MaKH, NgayLap, MaPhieuMuaHang, HinhThucDatHang, TongTien, ThanhTien)
VALUES ('DH002', 'KH002', '2024-11-02', 'PMH002', 'Cửa hàng', 200000, 180000);
INSERT INTO DONHANG (MaDH, MaKH, NgayLap, MaPhieuMuaHang, HinhThucDatHang, TongTien, ThanhTien)
VALUES ('DH003', 'KH003', '2024-11-03', 'PMH003', 'Online', 150000, 140000);
INSERT INTO DONHANG (MaDH, MaKH, NgayLap, MaPhieuMuaHang, HinhThucDatHang, TongTien, ThanhTien)
VALUES ('DH004', 'KH001', '2024-11-04', 'PMH002', 'Cửa hàng', 250000, 240000);
INSERT INTO DONHANG (MaDH, MaKH, NgayLap, MaPhieuMuaHang, HinhThucDatHang, TongTien, ThanhTien)
VALUES ('DH005', 'KH002', '2024-11-05', 'PMH003', 'Online', 300000, 290000);

-- Bảng CHITIETDH
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH001', 'SP001', 2, 50000, 'KM001', 1, 95000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH001', 'SP002', 1, 50000, 'KM001', 0, 50000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH002', 'SP001', 3, 60000, 'KM002', 1, 180000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH002', 'SP002', 2, 70000, 'KM002', 0, 140000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH003', 'SP003', 2, 75000, 'KM003', 1, 150000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH003', 'SP002', 1, 50000, 'KM003', 0, 50000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH004', 'SP003', 4, 80000, 'KM001', 1, 320000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH004', 'SP002', 3, 70000, 'KM002', 0, 210000);
INSERT INTO CHITIETDH (MaDH, MaSP, SoLuong, GiaNiemYet, MaKM, SoLuongSPDaApDung, ThanhTien)
VALUES ('DH005', 'SP001', 5, 60000, 'KM003', 1, 300000);