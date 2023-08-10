------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 01/04/2022
   Người thực hiện: Hoàng Nghĩa Minh Bảo
   Mã số sinh viên: 2011356
   Lab05: Quản lý tour du lịch
*/
------------------------------------------------
--Lệnh tạo CSDL
create database Lab05_QuanLyTourDuLich
go
--Lệnh sử dụng CSDL
use Lab05_QuanLyTourDuLich
--Lệnh tạo các bảng
create table Tour
(
MaTour char(5) primary key,
TongSoNgay int check(TongSoNgay>0)
)
go
create table ThanhPho
(
MaTP char(5) primary key,
TenTP nvarchar(10) not null
)
go
create table Tour_TP
(
MaTour char(5) references Tour(MaTour),
MaTP char(5) references ThanhPho(MaTP),
SoNgay int check(SoNgay>0),
primary key (MaTour, MaTP)
)
go
create table Lich_TourDL
(
MaTour char(5) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(5) not null,
SoNguoi int check(SoNguoi>0),
TenKH nvarchar(15) not null,
primary key (MaTour, NgayKH)
)
--drop table Lich_TourDL
-----Lệnh xem dữ liệu chứa trong bảng------
select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL
----NHẬP DỮ LIỆU CHO CÁC BẢNG-------
--Nhập bảng Tour
insert into Tour values ('T001', 3)
insert into Tour values ('T002', 4)
insert into Tour values ('T003', 5)
insert into Tour values ('T004', 7)
--Xem bảng Tour
select * from Tour
--Nhập bảng ThanhPho
insert into ThanhPho values ('01', N'Đà Lạt')
insert into ThanhPho values ('02', N'Nha Trang')
insert into ThanhPho values ('03', N'Phan Thiết')
insert into ThanhPho values ('04', N'Huế')
insert into ThanhPho values ('05', N'Đà Nẵng')
--Xem bảng ThanhPho
select * from ThanhPho
--Nhập bảng Tout_TP
insert into Tour_TP values ('T001', '01', 2)
insert into Tour_TP values ('T001', '03', 1)
insert into Tour_TP values ('T002', '01', 2)
insert into Tour_TP values ('T002', '02', 2)
insert into Tour_TP values ('T003', '02', 2)
insert into Tour_TP values ('T003', '01', 1)
insert into Tour_TP values ('T003', '04', 2)
insert into Tour_TP values ('T004', '02', 2)
insert into Tour_TP values ('T004', '05', 2)
insert into Tour_TP values ('T004', '04', 3)
--Xem bảng Tour_TP
select * from Tour_TP
--Nhập bảng Lich_TourDL
set dateformat dmy
go
insert into Lich_TourDL values ('T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng')
insert into Lich_TourDL values ('T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc')
insert into Lich_TourDL values ('T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng')
insert into Lich_TourDL values ('T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng')
insert into Lich_TourDL values ('T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam')
insert into Lich_TourDL values ('T003', '10/03/2017', N'Nam', 45, N'Nguyễn An')
insert into Lich_TourDL values ('T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung')
insert into Lich_TourDL values ('T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc')
insert into Lich_TourDL values ('T001', '30/04/2017', N'Nam', 25, N'Trần Nam')
insert into Lich_TourDL values ('T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá')
--Xem bảng Lich_Tour
select * from Lich_TourDL
----TRUY VẤN DỮ LIỆU
--1. Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
--2. Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017
--3. Cho biết các tour không đi qua thành phố Nha Trang
--4. Cho biết số lượng thành phố mà mỗi tour du lịch đi qua
--5. Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn
--6. Cho biết tên thành phố có nhiều tour du lịch đi qua nhất
--7. Cho biết thông tin của tour du lịch đi qua tất cả thành phố
--8. Lập danh sách các tour đi qua thành phố Đà Lạt, thông tin cần hiển thị bao gồm: MaTour, SoNgay
--9. Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất
--10. Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua