-------------------------------------- usp_LoaiKhachHang --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_LoaiKhachHang
    @MaKH VARCHAR(10),
    @LoaiKhachHang INT OUTPUT
AS
BEGIN
    -- Gán giá trị 1 nếu tìm thấy, 0 nếu không tìm thấy
    SELECT @LoaiKhachHang = CASE 
        WHEN EXISTS (SELECT 1 FROM KHACHHANG WHERE MaKH = @MaKH) THEN 1
        ELSE 0
    END;
END;
GO

---- Kiểm tra
--DECLARE @LoaiKH INT;
--EXEC usp_LoaiKhachHang 'KH004', @LoaiKH OUTPUT;
--PRINT @LoaiKH; -- In giá trị của @LoaiKH
--GO
-------------------------------------- usp_ApDungFLASHSALE --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_ApDungFlashSale
    @MaDH VARCHAR(10),
    @MaSP VARCHAR(10),
    @SoLuong INT
AS
BEGIN
	BEGIN TRAN
    BEGIN TRY
        -- Khai báo các biến cần thiết
        DECLARE @MaKM VARCHAR(10);
        DECLARE @SoLuongConLai INT;
        DECLARE @TiLeGiamGia DECIMAL(5, 2);
        DECLARE @SoLuongApDung INT;

        -- Lấy thông tin khuyến mãi FLASHSALE
        WITH KhuyenMaiFS AS (
            SELECT TOP 1 
                FLASHSALE.MaKM,
                SoLuongGioiHan - SoLuongSPDaApDung AS SoLuongConLai,
                TiLeGiamGia
            FROM FLASHSALE
            LEFT JOIN SALE ON SALE.MaKM = FLASHSALE.MaKM
            WHERE MaSP = @MaSP
                AND SoLuongSPDaApDung < SoLuongGioiHan
                AND SALE.ThoiGianBatDau <= GETDATE()
                AND GETDATE() <= SALE.ThoiGianKetThuc
            ORDER BY SALE.ThoiGianBatDau DESC -- Ưu tiên khuyến mãi gần nhất
        )
        SELECT 
            @MaKM = MaKM, 
            @SoLuongConLai = SoLuongConLai, 
            @TiLeGiamGia = TiLeGiamGia
        FROM KhuyenMaiFS;

        -- Áp dụng KM nếu có
        IF @MaKM IS NOT NULL
        BEGIN
			-- Xác định số lượng áp dụng
			SET @SoLuongApDung = CASE 
									WHEN @SoLuong < @SoLuongConLai THEN @SoLuong 
									ELSE @SoLuongConLai 
								 END;

			-- Cập nhật CTDH và FLASHSALE
			UPDATE CHITIETDH
			SET 
				MaKM = @MaKM,
				SoLuongSPDaApDung = @SoLuongApDung,
				ThanhTien = @SoLuongApDung * GiaNiemYet * (1 - @TiLeGiamGia)
			WHERE MaDH = @MaDH AND MaSP = @MaSP;

			UPDATE FLASHSALE
			SET SoLuongSPDaApDung = SoLuongSPDaApDung + @SoLuongApDung
			WHERE MaKM = @MaKM;
        END;
		COMMIT TRAN
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO

---- Kiểm tra
--EXEC usp_ApDungFLASHSALE 'DH001', 'SP001', 200;
--GO
-------------------------------------- usp_ApDungCOMBOSALE --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_ApDungComboSale
    @MaDH VARCHAR(10),
    @MaSP VARCHAR(10)
AS
BEGIN
	BEGIN TRAN
    BEGIN TRY
        -- Khai báo các biến cần thiết
        DECLARE @MaKM VARCHAR(10);
        DECLARE @TiLeGiamGia DECIMAL(5, 2);
        DECLARE @MaSP1 VARCHAR(10);
        DECLARE @MaSP2 VARCHAR(10);

        -- Lấy thông tin khuyến mãi COMBOSALE
        SELECT TOP 1
            @MaKM = cs.MaKM,
            @TiLeGiamGia = cs.TiLeGiamGia,
            @MaSP1 = cs.MaSP1,
            @MaSP2 = cs.MaSP2
        FROM COMBOSALE cs
        JOIN SALE s ON cs.MaKM = s.MaKM
        JOIN CHITIETDH ctdh1 ON cs.MaSP1 = ctdh1.MaSP AND ctdh1.MaDH = @MaDH AND ctdh1.MaKM IS NULL
        JOIN CHITIETDH ctdh2 ON cs.MaSP2 = ctdh2.MaSP AND ctdh2.MaDH = @MaDH AND ctdh2.MaKM IS NULL
        WHERE (@MaSP = cs.MaSP1 OR @MaSP = cs.MaSP2)
            AND s.ThoiGianBatDau <= GETDATE()
            AND GETDATE() <= s.ThoiGianKetThuc
            AND cs.SoLuongSPDaApDung < cs.SoLuongGioiHan
        ORDER BY s.ThoiGianBatDau DESC;

        -- Áp dụng khuyến mãi nếu có
        IF @MaKM IS NOT NULL
        BEGIN
            -- Cập nhật CTDH cho 2 sản phẩm trong combo
            UPDATE ctdh
            SET 
                MaKM = @MaKM,
                SoLuongSPDaApDung = 1,
                ThanhTien = GiaNiemYet * (1 - @TiLeGiamGia)
            FROM CHITIETDH ctdh
            WHERE MaDH = @MaDH AND (MaSP = @MaSP1 OR MaSP = @MaSP2);

            -- Kiểm tra nếu không đủ 2 dòng được cập nhật
            IF @@ROWCOUNT != 2 
            BEGIN
                THROW 50001, 'Khuyến mãi combo không áp dụng được đầy đủ sản phẩm.', 1;
            END;

            -- Cập nhật số lượng sản phẩm đã áp dụng khuyến mãi
            UPDATE COMBOSALE
            SET SoLuongSPDaApDung = SoLuongSPDaApDung + 1
            WHERE MaKM = @MaKM;
			COMMIT TRAN
        END
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
---- Kiểm tra
--EXEC usp_ApDungCOMBOSALE 'DH001', 'SP002';
--GO
-------------------------------------- usp_ApDungMEMBERSALE --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_ApDungMemberSale
    @MaDH VARCHAR(10),
    @MaSP VARCHAR(10),
	@MucThanThiet VARCHAR(10),
	@SoLuong INT
AS
BEGIN
	BEGIN TRAN
    BEGIN TRY
        -- Khai báo các biến cần thiết
        DECLARE @MaKM VARCHAR(10);
        DECLARE @TiLeGiamGia DECIMAL(5, 2);
		DECLARE @SoLuongApDung INT;
		DECLARE @SoLuongConLai INT

        -- Lấy thông tin khuyến mãi MEMBERSALE
        SELECT TOP 1
            @MaKM = ms.MaKM,
            @TiLeGiamGia = ms.TiLeGiamGia,
			@SoLuongConLai = ms.SoLuongGioiHan - ms.SoLuongSPDaApDung
        FROM MEMBERSALE ms
        JOIN SALE s ON ms.MaKM = s.MaKM
        WHERE @MucThanThiet = ms.MucThanThiet
			AND s.ThoiGianBatDau <= GETDATE()
			AND GETDATE() <= s.ThoiGianKetThuc
			AND ms.SoLuongSPDaApDung < ms.SoLuongGioiHan
        ORDER BY s.ThoiGianBatDau DESC;

        -- Áp dụng khuyến mãi nếu có
        IF @MaKM IS NOT NULL
        BEGIN
			-- Xác định số lượng áp dụng
			SET @SoLuongApDung = CASE 
									WHEN @SoLuong < @SoLuongConLai THEN @SoLuong 
									ELSE @SoLuongConLai 
								 END;			
            -- Cập nhật CTDH
            UPDATE ctdh
            SET 
                MaKM = @MaKM,
				SoLuongSPDaApDung = @SoLuongApDung,
                ThanhTien = @SoLuongApDung * GiaNiemYet * (1 - @TiLeGiamGia)
            FROM CHITIETDH ctdh
            WHERE MaDH = @MaDH AND MaSP = @MaSP AND MaKM IS NULL; -- Đảm bảo sản phẩm này chưa áp dụng KM nào

            -- Cập nhật số lượng sản phẩm đã áp dụng khuyến mãi
            UPDATE MEMBERSALE
            SET SoLuongSPDaApDung = SoLuongSPDaApDung + @SoLuongApDung
            WHERE MaKM = @MaKM;
        END;
		COMMIT TRAN
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO

---- Kiểm tra
--EXEC usp_ApDungMEMBERSALE 'DH005', 'SP002', 'T2', 5;
--GO

-------------------------------------- usp_ApDungPhieuMuaHang --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_ApDungPhieuMuaHang 
	@MaHD VARCHAR(10),
	@MaKH VARCHAR(10)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
	BEGIN TRANSACTION;

	DECLARE @MaPMH VARCHAR(10);
	DECLARE @QuaTang INT;

	-- Lấy thông tin phiếu mua hàng hợp lệ
	SELECT TOP 1 @MaPMH = pmh.MaPhieuMuaHang, @QuaTang = pmh.QuaTang
	FROM PHIEUMUAHANG pmh
	WHERE pmh.MaKH = @MaKH 
		AND pmh.NgayBatDau <= GETDATE() 
		AND GETDATE() < pmh.NgayKetThuc 
		AND pmh.TrangThai = N'Chưa sử dụng';

	-- Kiểm tra xem có phiếu mua hàng hợp lệ không
	IF @MaPMH IS NULL
	BEGIN
		-- Không tìm thấy phiếu mua hàng, rollback và thông báo
		PRINT 'Không có phiếu mua hàng hợp lệ.';
		ROLLBACK TRANSACTION;
		RETURN;
	END

	-- Cập nhật thông tin đơn hàng
	UPDATE DONHANG
	SET MaPhieuMuaHang = @MaPMH, 
		ThanhTien = CASE
						WHEN TongTien > @QuaTang THEN TongTien - @QuaTang
						ELSE 0
					END
	WHERE MaDH = @MaHD;

	-- Cập nhật trạng thái phiếu mua hàng
	UPDATE PHIEUMUAHANG
	SET TrangThai = N'Đã sử dụng'
	WHERE MaPhieuMuaHang = @MaPMH;

	-- Commit transaction
	COMMIT TRANSACTION;
	PRINT 'Áp dụng phiếu mua hàng thành công.';

END
GO

-------------------------------------- usp_XuLyDonHang --------------------------------------
USE DB_QLSieuThi
GO
CREATE PROCEDURE usp_XuLyDonHang 
    @MaDH VARCHAR(10) 
AS 
BEGIN 
    -- Kiểm tra và deallocate tất cả cursor nếu tồn tại
    IF (SELECT CURSOR_STATUS('global','cur')) >= 0
    BEGIN
        CLOSE cur;
        DEALLOCATE cur;
    END
    IF (SELECT CURSOR_STATUS('global','fs_cur')) >= 0
    BEGIN
        CLOSE fs_cur;
        DEALLOCATE fs_cur;
    END
    IF (SELECT CURSOR_STATUS('global','cs_cur')) >= 0
    BEGIN
        CLOSE cs_cur;
        DEALLOCATE cs_cur;
    END
    IF (SELECT CURSOR_STATUS('global','ms_cur')) >= 0
    BEGIN
        CLOSE ms_cur;
        DEALLOCATE ms_cur;
    END

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
    BEGIN TRANSACTION; 
    BEGIN TRY 
		-- 1. Đọc tất cả các dòng đơn hàng trong bảng CHITIETDH
		-- Xac dinh tat ca cac san pham trong don hang
        DECLARE cur CURSOR FOR
            SELECT MaSP, SoLuong
            FROM CHITIETDH
            WHERE MaDH = @MaDH;
        
        OPEN cur;
        DECLARE @MaSP VARCHAR(10);
        DECLARE @SoLuong INT;
        FETCH NEXT FROM cur INTO @MaSP, @SoLuong;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- 1.1 Xác định giá niêm yết của sản phẩm từ bảng SANPHAM
            DECLARE @GiaNiemYet DECIMAL(18, 2);
            SELECT @GiaNiemYet = GiaNiemYet
            FROM SANPHAM
            WHERE MaSP = @MaSP;
            
            -- 1.2 Cập nhật giá niêm yết trong CHITIETDH
            UPDATE CHITIETDH WITH (UPDLOCK)
            SET GiaNiemYet = @GiaNiemYet
            WHERE MaDH = @MaDH AND MaSP = @MaSP;
            
            FETCH NEXT FROM cur INTO @MaSP, @SoLuong;
        END;

        CLOSE cur;
        DEALLOCATE cur;

        --2. Duyệt lại CTDH để cập nhật mã KM
        --2.1 Xác định loại KH, mức thân thiết nếu có
        DECLARE @MaKH VARCHAR(10);
        DECLARE @LoaiKhachHang INT;
        DECLARE @MucThanThiet VARCHAR(10);

        SELECT @MaKH = dh.MaKH
        FROM DONHANG dh
        JOIN KHACHHANG kh ON kh.MaKH = dh.MaKH 
        WHERE MaDH = @MaDH;

        EXEC usp_LoaiKhachHang @MaKH, @LoaiKhachHang OUTPUT;

		-- 2.2 Lần lượt kiểm tra mã KM theo thứ tự flash -> combo -> member
        -- Áp dụng Flash sale với tất cả SP trong HD nếu được
        DECLARE fs_cur CURSOR FOR 
            SELECT MaSP, SoLuong
            FROM CHITIETDH ctdh
            WHERE ctdh.MaDH = @MaDH;

        OPEN fs_cur;
        FETCH NEXT FROM fs_cur INTO @MaSP, @SoLuong;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC usp_ApDungFlashSale @MaDH, @MaSP, @SoLuong;
            FETCH NEXT FROM fs_cur INTO @MaSP, @SoLuong;
        END;
		CLOSE fs_cur
		DEALLOCATE fs_cur
		-- Áp dụng Combo sale với tất cả SP trong HD nếu được
		DECLARE cs_cur CURSOR FOR 
			SELECT MaSP, SoLuong
			FROM CHITIETDH ctdh
			WHERE ctdh.MaDH = @MaDH

		OPEN cs_cur;
		FETCH NEXT FROM cs_cur INTO @MaSP, @SoLuong
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC usp_ApDungComboSale @MaDH, @MaSP
			FETCH NEXT FROM cs_cur INTO @MaSP, @SoLuong;
		END
		CLOSE cs_cur
		DEALLOCATE cs_cur

		--Nếu là khách hàng thân thiết thì xét thêm membersale
		IF @LoaiKhachHang = 1 
		BEGIN
			-- Áp dụng Member sale với tất cả SP trong HD nếu được
			-- Xác định mức thân thiết
			SELECT @MucThanThiet = MucThanThiet
			FROM KHACHHANG 
			WHERE MaKH = @MaKH

			DECLARE ms_cur CURSOR FOR 
				SELECT MaSP, SoLuong
				FROM CHITIETDH ctdh
				WHERE ctdh.MaDH = @MaDH

			OPEN ms_cur;
			FETCH NEXT FROM ms_cur INTO @MaSP, @SoLuong
			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC usp_ApDungMemberSale @MaDH, @MaSP, @MucThanThiet, @SoLuong
				FETCH NEXT FROM ms_cur INTO @MaSP, @SoLuong;
			END

			CLOSE ms_cur
			DEALLOCATE ms_cur
		END

		-- Tính tổng tiền của các sản phẩm trong đơn hàng
		DECLARE @TongTien DECIMAL(18, 2);
		SELECT @TongTien = ISNULL(SUM(ThanhTien), 0)
		FROM CHITIETDH
		WHERE MaDH = @MaDH;

		-- Cập nhật tổng tiền vào bảng DONHANG
		UPDATE DONHANG
		SET TongTien = @TongTien
		WHERE MaDH = @MaDH;

		-- Áp dụng phiếu mua hàng và tính toán thành tiền (max(0, TongTien-QuaTang))
		EXEC usp_ApDungPhieuMuaHang @MaDH, @MaKH

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH 
        IF (SELECT CURSOR_STATUS('global','cur')) >= 0
        BEGIN
            CLOSE cur;
            DEALLOCATE cur;
        END
        IF (SELECT CURSOR_STATUS('global','fs_cur')) >= 0
        BEGIN
            CLOSE fs_cur;
            DEALLOCATE fs_cur;
        END
        IF (SELECT CURSOR_STATUS('global','cs_cur')) >= 0
        BEGIN
            CLOSE cs_cur;
            DEALLOCATE cs_cur;
        END
        IF (SELECT CURSOR_STATUS('global','ms_cur')) >= 0
        BEGIN
            CLOSE ms_cur;
            DEALLOCATE ms_cur;
        END

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; 
             
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY(); 
        DECLARE @ErrorState INT = ERROR_STATE(); 
         
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState); 
    END CATCH; 
END;
GO
-- Test
-- EXEC usp_XuLyDonHang 'DH004'


-------------------------------------- usp_CapNhatSanPhamTrongDonHang --------------------------------------
CREATE PROCEDURE usp_CapNhatSanPhamTrongDonHang
    @MaDH VARCHAR(10),
    @MaSP VARCHAR(10),
    @SoLuong INT
AS
BEGIN
    -- Thiết lập mức độ cô lập giao dịch
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    -- Bắt đầu transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Kiểm tra xem sản phẩm có tồn tại trong đơn hàng không
        IF EXISTS (
            SELECT 1 
            FROM CHITIETDH 
            WHERE MaDH = @MaDH AND MaSP = @MaSP
        )
        BEGIN
            IF @SoLuong > 0
            BEGIN
                -- Cập nhật số lượng và tính lại Thành Tiền
                UPDATE CHITIETDH
                SET 
                    SoLuong = @SoLuong,
                    ThanhTien = @SoLuong * GiaNiemYet
                WHERE MaDH = @MaDH AND MaSP = @MaSP;

                -- In thông báo thành công
                PRINT N'Cập nhật thành công.';
            END
            ELSE
            BEGIN
                -- Không thể cập nhật nếu số lượng <= 0
                PRINT N'Số lượng phải lớn hơn 0.';
                ROLLBACK TRANSACTION;
                RETURN;
            END
        END
        ELSE
        BEGIN
            -- Sản phẩm không tồn tại trong đơn hàng
            PRINT N'Sản phẩm không tồn tại trong đơn hàng.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Commit giao dịch nếu tất cả thao tác thành công
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi và rollback giao dịch trong trường hợp xảy ra ngoại lệ
        PRINT N'Đã xảy ra lỗi trong quá trình xử lý.';
        ROLLBACK TRANSACTION;
    END CATCH
END;

-- Kiem tra
-- EXEC usp_CapNhatSanPhamTrongDonHang 'DH001', 'SP001', 3
