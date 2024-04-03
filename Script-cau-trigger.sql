-- Ràng buộc 1: Số năm kinh nghiệm tối thiểu đối với lái chính là 5 năm.
CREATE TRIGGER sonamkinhnghiem ON LAI_CHINH
AFTER INSERT, UPDATE
AS
DECLARE @sonamkinhnghiem INT
SELECT @sonamkinhnghiem = sonamkinhnghiem FROM inserted
IF
@sonamkinhnghiem < '5'
BEGIN
PRINT (N'Không đủ điều kiện phụ trách vị trí lái chính')
ROLLBACK TRANSACTION
END

-- Ràng buộc 2: Khách hàng chỉ được thực hiện đặt vé khi số lượng ghế trống vẫn còn.
CREATE TRIGGER soluongghetrong ON TAU
AFTER INSERT, UPDATE
AS
DECLARE @soluongghetrong INT
SELECT @soluongghetrong=soluongghetrong FROM inserted
IF @soluongghetrong < 0
BEGIN
PRINT (N'Không còn ghế để thực hiện thao tác đặt vé')
ROLLBACK TRANSACTION
END

-- Ràng buộc 3: Số lượng đặt vé của hành khách không được quá 10 vé.
CREATE TRIGGER soluongdatve ON PHIEU_DANGKY
AFTER INSERT, UPDATE
AS
DECLARE @soluongve INT
SELECT @soluongve= soluongve FROM inserted
IF @soluongve > '10'
BEGIN
PRINT (N'Hành khách đã đăng ký vượt quá số lượng vé cho phép')
ROLLBACK TRANSACTION
END

-- Ràng buộc 4: Với loại vé VIP, giá tiền sẽ đắt hơn 50% so với giá vé phổ thông.
CREATE TRIGGER giatienvenam ON VE
AFTER INSERT, UPDATE
AS
DECLARE @giave INT, @loaive VARCHAR(3)
SELECT @giave= giave, @loaive= loaive FROM inserted
IF (@loaive= 'VIP' and @giave <> 150000)
BEGIN
PRINT (N'Giá vé không hợp lệ')
ROLLBACK TRANSACTION
END

-- Ràng buộc 5: Trong buồng lái được phụ trách bởi ba nhân viên.
CREATE TRIGGER soluongnhanvien ON NHAN_VIEN
AFTER INSERT, UPDATE
AS
DECLARE @manhanvien CHAR(5), @matau CHAR(3)
SELECT @manhanvien= manhanvien, @matau=matau FROM inserted
IF exists (SELECT *
			FROM NHAN_VIEN
			GROUP BY matau
			HAVING count(@manhanvien) <> 3)
BEGIN
PRINT (N'Số lượng nhân viên không đúng với yêu cầu')
ROLLBACK TRANSACTION
END

-- Ràng buộc 6: Hệ thống cho phép hành khách thanh toán trực tuyến trong vòng 24 giờ
-- tính từ thời gian đặt vé.

--Trigger trên bảng HOA_DON
CREATE TRIGGER thoigian ON HOA_DON
AFTER INSERT, UPDATE
AS
DECLARE @thoigian DATETIME, @mahoadon CHAR (5)
SELECT @thoigian=thoigianthanhtoan, @mahoadon = mahoadon FROM INSERTED
IF
		EXISTS (SELECT * FROM PHIEU_DANGKY DK WHERE ((DK.mahoadon =
		@mahoadon
			AND DK.thoigiandatve > @thoigian)
				OR ( (DK.mahoadon = @mahoadon AND DATEDIFF (hour, DK.thoigiandatve,
					@thoigian)>24))))
BEGIN
PRINT (N'Thời gian thanh toán không hợp lệ')
ROLLBACK TRANSACTION
END

-- Trigger trên bảng PHIEU_DANGKY
CREATE TRIGGER thoigian ON PHIEU_DANGKY
AFTER INSERT, UPDATE
AS
DECLARE @thoigiandatve DATETIME, @mahoadon CHAR(5)
SELECT @thoigiandatve = thoigiandatve, @mahoadon = mahoadon FROM inserted
IF exists (SELECT * FROM HOA_DON HD
		WHERE ((HD.mahoadon = @mahoadon AND @thoigiandatve > HD.thoigianthanhtoan)
			OR ( HD.mahoadon = @mahoadon AND
DATEDIFF(HOUR,@thoigiandatve,HD.thoigianthanhtoan) >24 )))
BEGIN
PRINT (N'Đã xảy ra lỗi trong quá trình thực hiện thanh toán')
ROLLBACK TRANSACTION
END

-- Ràng buộc 7: Thời gian đi của vé bằng thời gian đi của tàu.
CREATE TRIGGER thoigiandi ON VE
AFTER INSERT, UPDATE
AS
DECLARE @thoigiandi DATE, @thoigiankhoihanh DATE
SELECT @thoigiandi= thoigiandi FROM VE
IF @thoigiandi NOT IN
	( SELECT @thoigiankhoihanh FROM TAU
			WHERE TAU.thoigiankhoihanh=@thoigiankhoihanh)
BEGIN
PRINT(N'Thời gian không phù hợp')
ROLLBACK TRANSACTION
END

-- Ràng buộc 8: Vé tàu chỉ được chấp nhận khi trạm đón và trạm dừng trên vé mà hành
-- khách đã đặt đúng với lộ trình mà tàu đó đi qua.
CREATE TRIGGER lotrinh ON VE
AFTER insert, update
AS
DECLARE @matramdon CHAR(3), @matramtra CHAR(3), @matau CHAR(3)
SELECT @matramdon=matramdon, @matramtra=matramtra, @matau=matau FROM inserted
IF NOT EXISTS
(SELECT * FROM TAU
WHERE @matau= TAU.matau AND TAU.matramkhoihanh = @matramdon)
OR NOT EXISTS
(SELECT * FROM TAU
WHERE @matau=TAU.matau AND TAU.matramdung = @matramtra)
BEGIN
PRINT (N'Lộ trình không được hỗ trợ');
ROLLBACK TRANSACTION
END

-- Ràng buộc 9: Hành khách chỉ có thể thực hiện đặt vé thành công khi vị trí ghế được
-- chọn vẫn còn trống.
CREATE TRIGGER ghetrong ON VE
AFTER INSERT, UPDATE
AS
DECLARE @vitrighe VARCHAR(5)
DECLARE @matau CHAR(3)
SELECT @vitrighe=vitrighe, @matau=matau FROM inserted
IF EXISTS (SELECT *
	FROM VE
	WHERE VE.vitrighe=@vitrighe and VE.matau=@matau
		GROUP BY matau, vitrighe
		HAVING COUNT(@vitrighe)>1)
BEGIN
PRINT(N'Thực hiện chọn chỗ không thành công do vị trí không còn trống')
ROLLBACK TRANSACTION
END

-- Ràng buộc 10: Mỗi nhân viên chỉ được đảm nhận một nhiệm vụ (hoặc đảm nhận vị trí
-- lái chính hoặc đảm nhận vị trí phụ lái).

-- Trigger trên bảng LAI_CHINH
CREATE TRIGGER phancong ONLAI_CHINH
AFTER INSERT, UPDATE
AS
DECLARE @manhanvien CHAR(5)
SELECT @manhanvien=manhanvien FROM inserted
IF EXISTS (SELECT @manhanvien FROM PHU_LAI WHERE PHU_LAI.manhanvien=
@manhanvien )
BEGIN
PRINT (N'Phân công không hợp lệ')
ROLLBACK TRANSACTION
END

-- Trigger trên bảng PHU_LAI
CREATE TRIGGER phancong1 ON PHU_LAI
AFTER INSERT, UPDATE
AS
DECLARE @manhanvien CHAR(5)
SELECT @manhanvien=manhanvien FROM inserted
IF exists (SELECT @manhanvien FROM LAI_CHINH WHERE
LAI_CHINH.manhanvien=@manhanvien)
BEGIN
PRINT (N'Phân công không hợp lệ')
ROLLBACK TRANSACTION
END

-- Ràng buộc 11: Số lượng vé được ghi nhận tại phiếu đăng ký phải phù hợp với tổng số
-- vé mà một ID hành khách đã thực hiện đăng ký tại bước chọn vé.

-- Trigger trên bảng PHIEU_DANGKY
CREATE TRIGGER ghinhan ON PHIEU_DANGKY
AFTER INSERT, UPDATE
AS
DECLARE @ID CHAR(5), @soluongghinhan INT
SELECT @ID=ID FROM inserted
SELECT @soluongghinhan = (SELECT COUNT(*) FROM inserted GROUP BY inserted.ID)
IF EXISTS (SELECT * FROM VE JOIN PHIEU_DANGKY DK
ON VE.ID = @ID WHERE (@soluongghinhan <> DK.soluongve))
BEGIN
PRINT (N'Số lượng vé được ghi nhận không phù hợp với lượng vé đặt')
ROLLBACK TRANSACTION
END

-- Ràng buộc 12: Số lượng ghế trống trên tàu sẽ được cập nhật mỗi khi hành khách thực
-- hiện thao tác hủy hoặc đặt vé.

-- Thực hiện cập nhật số lượng ghế trống khi hành khách thực hiện hủy vé
CREATE TRIGGER huydatve ON VE
FOR delete, UPDATE
AS
DECLARE @matau CHAR(3)
SELECT @matau=matau FROM deleted
BEGIN
UPDATE TAU
SET soluongghetrong = soluongghetrong + (SELECT count(*) as soluongghedat FROM
deleted WHERE @matau = TAU.matau)
END

-- Thực hiện cập nhật số lượng ghế trống khi hành khách thực hiện đặt vé
CREATE TRIGGER datve ON VE
FOR insert, UPDATE
AS
DECLARE @matau CHAR(3)
SELECT @matau=matau FROM inserted
BEGIN
UPDATE TAU
SET soluongghetrong = soluongghetrong - (SELECT count(*) as soluongghedat FROM
inserted WHERE @matau = TAU.matau)
END

-- Ràng buộc 13: Hành khách được quyền thực hiện đặt vé trước giờ tàu chạy, tuy nhiên
-- không được đặt vé trước quá 3 tháng tính đến thời điểm tàu khởi hành.

-- Trigger về giới hạn thời gian đặt vé
CREATE TRIGGER thoigiandatve ON PHIEU_DANGKY
AFTER INSERT, UPDATE
AS
DECLARE @thoigiandatve DATETIME, @matau CHAR(3)
SELECT @thoigiandatve = thoigiandatve, @matau = matau FROM inserted
IF EXISTS (SELECT * FROM TAU
WHERE ((@matau = TAU.matau AND @thoigiandatve > TAU.thoigiankhoihan
OR (@matau = TAU.matau AND
DATEDIFF(MONTH,@thoigiandatve,TAU.thoigiankhoihanh) > 3)))
BEGIN
PRINT (N'Thời gian đặt vé không phù hợp')
ROLLBACK TRANSACTION
END

