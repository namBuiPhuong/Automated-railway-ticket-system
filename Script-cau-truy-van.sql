-- Cho biết thông tin tài khoản của các khách hàng có giới tính nữ 
SELECT *
FROM TAI_KHOAN
WHERE gioitinh = N'Nữ'

-- Cho biết họ tên và số điện thoại của các hành khách đi chuyến tàu có mã tàu là “T02”
SELECT DISTINCT hoten, sodienthoai
FROM TAI_KHOAN JOIN VE ON TAI_KHOAN.ID = VE.ID
WHERE VE.matau = 'T02'

-- Cho biết thông tin của những hành khách đã thực hiện đăng ký tài khoản nhưng chưa
-- thực hiện mua vé (thực hiện sắp xếp từ bé đến lớn theo độ tuổi)
SELECT TAI_KHOAN.*
FROM TAI_KHOAN JOIN PHIEU_DANGKY ON TAI_KHOAN.ID = PHIEU_DANGKY.ID
WHERE PHIEU_DANGKY.thoigiandatve
BETWEEN '12/18/2023' and '12/22/2023'

-- Cho biết họ tên của khách hàng đã phải thanh toán số tiền lớn nhất để đặt vé
SELECT SUM(giave) AS sotienphaitra, TAI_KHOAN.hoten
FROM TAI_KHOAN
JOIN VE ON TAI_KHOAN.ID = VE.ID
JOIN PHIEU_DANGKY ON TAI_KHOAN.ID = PHIEU_DANGKY.ID
GROUP BY VE.ID, TAI_KHOAN.hoten
HAVING SUM(giave) >= ALL (SELECT SUM(giave)
						FROM VE
						GROUP BY VE.ID)

-- Cho biết số lượng nhân viên nam của tàu có mã tàu “T01”
SELECT matau, COUNT(*) AS soluongnhanviennam
FROM NHAN_VIEN
WHERE gioitinh = N'Nam' and matau = 'T01'
GROUP BY matau

-- Cho biết mã tàu nào có nhiều hành khách đăng ký nhất và họ tên các nhân viên phụ
-- trách tàu đó
SELECT VE.matau, COUNT (*) as soluongkhach, NHAN_VIEN.hotennv
FROM VE JOIN NHAN_VIEN ON VE.matau= NHAN_VIEN.matau
GROUP BY VE.matau, NHAN_VIEN.hotennv
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM VE
				GROUP BY VE.matau)

-- Cho biết thông tin tài khoản của tất cả hành khách đã đặt vé tàu T02 và có tuổi từ 20 trở
-- xuống nhưng không thực hiện thanh toán bằng VNPay
SELECT TAI_KHOAN.*
FROM TAI_KHOAN
WHERE tuoi <=20
INTERSECT
SELECT TAI_KHOAN.*
FROM TAI_KHOAN JOIN VE
ON TAI_KHOAN.ID = VE.ID
WHERE matau = 'T02'
EXCEPT
SELECT TAI_KHOAN.*
FROM TAI_KHOAN JOIN HOA_DON
ON TAI_KHOAN.ID = HOA_DON.ID
WHERE phuongthucthanhtoan = 'VNPAY'

-- Cho biết thông tin của nhân viên là lái chính của tàu “T02”
SELECT NHAN_VIEN.*
FROM NHAN_VIEN
WHERE matau = 'T02'
AND manhanvien IN (SELECT manhanvien FROM LAI_CHINH)

