CREATE DATABASE QLVT
GO
USE QLVT



--Tạo bảng TAI_KHOAN
CREATE TABLE TAI_KHOAN ( 
ID CHAR (5) PRIMARY KEY ,
hoten NVARCHAR (30) NOT NULL,
tuoi INT NOT NULL,
gioitinh NVARCHAR (3) CHECK (gioitinh IN (N'Nam', N'Nữ')),
sodienthoai VARCHAR(12) NOT NULL CHECK(sodienthoai NOT LIKE '%[^0-9]%'),
email VARCHAR(30) NOT NULL, 
)


--Tạo bảng TRAM_TAU
CREATE TABLE TRAM_TAU (
matram CHAR (2) PRIMARY KEY,
tentram NVARCHAR (20)
)



-- Tạo bảng TAU
CREATE TABLE TAU (
matau CHAR (3) PRIMARY KEY,
thoigiankhoihanh DATETIME NOT NULL, 
soluongghetrong INT  NOT NULL,
matramkhoihanh CHAR(2),
matramdung CHAR(2),
CONSTRAINT FK_matramkhoihanh FOREIGN KEY (matramkhoihanh) REFERENCES TRAM_TAU (matram),
CONSTRAINT FK_matramdung FOREIGN KEY(matramdung) REFERENCES TRAM_TAU(matram)
)





--Tạo bảng NHAN_VIEN
CREATE TABLE NHAN_VIEN (
manhanvien CHAR (5) PRIMARY KEY,
hotennv NVARCHAR (30)  NOT NULL,
tuoi INT  NOT NULL,
gioitinh NVARCHAR (3) CHECK (gioitinh IN (N'Nam', N'Nữ')),
matau CHAR (3),
CONSTRAINT FK_matau FOREIGN KEY (matau) REFERENCES TAU(matau)
)





--Tạo bảng LAI_CHINH
CREATE TABLE LAI_CHINH (
manhanvien CHAR (5) PRIMARY KEY,
sonamkinhnghiem INT DEFAULT (5),
matau CHAR (3),
CONSTRAINT FK_matau_laichinh FOREIGN KEY (matau) REFERENCES TAU(matau)
)




--Tạo bảng PHU_LAI
CREATE TABLE PHU_LAI (
manhanvien CHAR(5) PRIMARY KEY,
lydothay NVARCHAR (100)  NOT NULL,
matau CHAR (3),
CONSTRAINT FK_matau_phulai FOREIGN KEY (matau) REFERENCES TAU(matau)
)



--Tạo bảng HOA_DON
CREATE TABLE HOA_DON (
mahoadon CHAR (5) PRIMARY KEY,
thoigianthanhtoan DATETIME NOT NULL,
phuongthucthanhtoan VARCHAR (5) NOT NULL,
ID CHAR(5),
CONSTRAINT FK_ID_HOA_DON FOREIGN KEY (ID) REFERENCES TAI_KHOAN (ID)
)



--Tạo bảng PHIEU_DANGKY
CREATE TABLE PHIEU_DANGKY (
maphieu INT PRIMARY KEY,
thoigiandatve DATETIME NOT NULL,
soluongve INT NOT NULL,
mahoadon CHAR(5), 
ID CHAR(5),
matau CHAR(3)
CONSTRAINT FK_ID FOREIGN KEY (ID) REFERENCES TAI_KHOAN (ID),
CONSTRAINT FK_mahoadon FOREIGN KEY (mahoadon) REFERENCES HOA_DON (mahoadon),
CONSTRAINT FK_matau_dk FOREIGN KEY (matau) REFERENCES TAU (matau)
)






--Tạo bảng VE
CREATE TABLE VE (
mave CHAR(3) PRIMARY KEY,
thoigiandi DATETIME NOT NULL,
vitrighe VARCHAR (5) NOT NULL,
loaive VARCHAR(10) CHECK (loaive IN (N'PT', 'VIP')),
giave INT NOT NULL,
ID CHAR (5),
maphieu INT,
matau CHAR (3),
matramdon CHAR (2),
matramtra CHAR(2),
CONSTRAINT FK_ID1 FOREIGN KEY (ID) REFERENCES TAI_KHOAN(ID),
CONSTRAINT FK_matau1 FOREIGN KEY (matau) REFERENCES TAU(matau),
CONSTRAINT FK_matramdon FOREIGN KEY(matramdon) REFERENCES TRAM_TAU(matram),
CONSTRAINT FK_matramtra FOREIGN KEY(matramtra) REFERENCES  TRAM_TAU(matram),
CONSTRAINT FK_STT FOREIGN KEY (maphieu) REFERENCES PHIEU_DANGKY (maphieu)
)
