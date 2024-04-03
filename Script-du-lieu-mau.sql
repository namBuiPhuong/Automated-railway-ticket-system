--Thêm dữ liệu vào bảng TAI_KHOAN
INSERT INTO TAI_KHOAN
VALUES 
('ABC01', N'Nguyễn Văn Anh', '20', N'Nam', '0912345431', 'nguyenvananh@gmail.com'),
('ABC02', N'Trần Thanh Hoàng', '21', N'Nam', '091324534', 'tranthanhhoang@gmail.com'),
('ABC03', N'Nguyễn Thị Tiên', '18', N'Nữ', '0892543876', 'nguyenthitien@gmail.com'),
('ABC04', N'Trần Thị Dung', '19', N'Nữ', '0345654323', 'tranthidung@gmail.com'),
('ABC05', N'Đoàn Thị Hồng Yến', '24', N'Nữ', '0912543987', 'doanthihongyen@gmail.com'),
('ABC06', N'Nguyễn Thị Cẩm Tiên', '26', N'Nữ', '0915354987', 'nguyenthicamtien@gmail.com'),
('ABC07', N'Trần Tử Thanh', '23', N'Nam','0334410729', 'trantuthanh@gmail.com')


--Thêm dữ liệu vào bảng TRAM_TAU
INSERT INTO TRAM_TAU
VALUES 
('A1', N'Thái Sơn'),
('A2', N'Hoành Sơn'),
('A3', N'Bình Thiên'),
('A4', N'Thái Hòa'),
('A5', N'Thiên Thanh'),
('B1', N'Thanh Hà'),
('B2', N'Phàn Thành'),
('B3', N'Di Lăng'),
('B4', N'Xích Bích'),
('B5', N'Thành Đô')


--Thêm dữ liệu vào bảng TAU
INSERT INTO TAU
VALUES 
('T01', '2023-10-29 16:00', '300', 'A1', 'A3'),
('T02', '2023-12-25 12:00', '300', 'A2', 'A4'),
('T03', '2023-10-23 7:00', '280','A3', 'B1'),
('T04', '2023-08-17 23:30', '250', 'A2', 'B3')


--Thêm dữ liệu vào bảng NHAN_VIEN
INSERT INTO NHAN_VIEN
VALUES 
('NV001', N'Trần Thanh Nhã','40', N'Nam', 'T01'),
('NV002', N'Nguyễn Thanh Tuyền', '30', N'Nữ', 'T01'),
('NV003', N'Nguyễn Minh Quân','35', N'Nam', 'T01'),
('NV004',N'Nguyễn Thành Nhân', '25', N'Nam', 'T02'),
('NV005', N'Nguyễn Minh Nhựt', '40', N'Nam', 'T02'),
('NV006', N'Nguyễn Thiên Phước', '45',N'Nam', 'T02'),
('NV007', N'Nguyễn Trần Thanh', '43', N'Nam', 'T03'),
('NV008', N'Trần Minh Tiến', '25', N'Nam', 'T03'),
('NV009', N'Bùi Phương Tiếng', '30', N'Nam', 'T03'),
('NV010', N'Trần Minh Anh', '28', N'Nữ', 'T04'),
('NV011', N'Nguyễn Trần Minh Quân', '37', N'Nam', 'T04'),
('NV012', N'Đoàn Thị Hồng Thắm', '30', N'Nữ', 'T04')


--Thêm dữ liệu vào bảng LAI_CHINH
INSERT INTO LAI_CHINH 
VALUES 
('NV001','6', 'T01'),
('NV004', '7', 'T02'),
('NV007', '5', 'T03'),
('NV010', '5', 'T04')



--Thêm dữ liệu vào bảng PHU_LAI
INSERT INTO PHU_LAI
VALUES ('NV002', N'Lái chính gặp vấn đề về sức khỏe', 'T01'),
('NV003', N'Thay theo lịch phân công do lịch trình dài', 'T01'),
('NV005', N'Thay theo lịch phân công do lịch trình dài', 'T02'),
('NV006', N'Thay theo lịch phân công do lịch trình dài', 'T02'),
('NV008', N'Lái chính gặp vấn đề về sức khóe', 'T03'),
('NV009',N'Thay theo lịch phân công do lịch trình dài', 'T03'),
('NV011', N'Lái chính gặp vấn đề về sức khóe', 'T04'),
('NV012', N'Thay theo lịch phân công do lịch trình dài', 'T04')


-- Thêm dữ liệu vào bảng HOA_DON
INSERT INTO HOA_DON
VALUES 
('HD001', '2023-10-28 18:00', 'VNPAY', 'ABC01'),
('HD002', '2023-12-19 10:00', 'MOMO', 'ABC02'),
('HD003', '2023-12-19 19:30', 'MOMO', 'ABC03'),
('HD004', '2023-11-21 8:00', 'MOMO', 'ABC04'),
('HD005', '2023-10-20 7:30', 'VNPAY', 'ABC05')


--Thêm dữ liệu vào bảng PHIEU_DANGKY
INSERT INTO PHIEU_DANGKY
VALUES 
('1','2023-10-28 12:00', '1', 'HD001', 'ABC01', 'T01' ),
('2', '2023-12-19 10:00', '1','HD002', 'ABC02', 'T02'),
('3', '2023-12-19 10:30', '2', 'HD003', 'ABC03', 'T02'),
('4', '2023-11-21 8:00', '3', 'HD004', 'ABC04', 'T02'),
('5', '2023-10-20 7:00', '4','HD005', 'ABC05', 'T03')


--Thêm dữ liệu vào bảng VE
INSERT INTO VE
VALUES 
('AA1', '2023-10-29 16:00', 'NS1', 'PT','100000','ABC01','1', 'T01', 'A1', 'A3'),
('AA2','2023-12-25 12:00' , 'NS2', 'VIP','150000','ABC02','2', 'T02', 'A2', 'A4'),
('AA3','2023-12-25 12:00' , 'NS3', 'VIP','150000','ABC03','3', 'T02', 'A2', 'A4'),
('AA4','2023-12-25 12:00' , 'NS4', 'PT','100000','ABC04','4', 'T02', 'A2', 'A4'),
('AA6','2023-12-25 12:00' , 'NS6', 'PT','100000','ABC03','3', 'T02', 'A2', 'A4'),
('AA7','2023-12-25 12:00' , 'NS7', 'VIP','150000','ABC04','4', 'T02', 'A2', 'A4'),
('AA8','2023-12-25 12:00' , 'NS8', 'PT','100000','ABC04','4', 'T02', 'A2', 'A4'),
('AA5','2023-10-23 7:00' , 'NS1', 'PT','100000','ABC05','5', 'T03', 'A3', 'B1'),
('AA9','2023-10-23 7:00' , 'NS2', 'VIP','150000','ABC05','5', 'T03', 'A3', 'B1'),
('A10','2023-10-23 7:00' , 'NS3', 'VIP','150000','ABC05','5', 'T03', 'A3', 'B1'),
('A11','2023-10-23 7:00' , 'NS4', 'PT','100000','ABC05','5', 'T03', 'A3', 'B1')
